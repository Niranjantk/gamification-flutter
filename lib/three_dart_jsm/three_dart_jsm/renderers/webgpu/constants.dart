part of three_webgpu;

class GPUShaderStage {
  static const int Vertex = 1;
  static const int Fragment = 2;
  static const int Compute = 4;
}

class GPUBufferUsage {
  static const int MapRead = 1;
  static const int MapWrite = 2;
  static const int CopySrc = 4;
  static const int CopyDst = 8;
  static const int Index = 16;
  static const int Vertex = 32;
  static const int Uniform = 64;
  static const int Storage = 128;
  static const int Indirect = 256;
  static const int QueryResolve = 512;
}

class GPUMapMode {
  static const int Read = 1;
  static const int Write = 2;
}

class GPULoadOp {
  static const String Load = 'load';
  static const String Clear = 'clear';
}

class GPUStoreOp {
  static const String Store = 'store';
  static const String Discard = 'discard';
}

class GPUIndexFormat {
  static const String Uint16 = 'uint16';
  static const String Uint32 = 'uint32';
}

class GPUTextureFormat {
  static const String R8Unorm = 'r8unorm';
  static const String R16Float = 'r16float';
  static const String RG8Unorm = 'rg8unorm';
  static const String RG16Float = 'rg16float';
  static const String R32Float = 'r32float';
  static const String RGBA8Unorm = 'rgba8unorm';
  static const String RGBA8UnormSRGB = 'rgba8unorm-srgb';
  static const String RG32Float = 'rg32float';
  static const String RGBA16Float = 'rgba16float';
  static const String RGBA32Float = 'rgba32float';
  static const String BGRA8Unorm = 'bgra8unorm';
  static const String Depth24PlusStencil8 = 'depth24plus-stencil8';
  static const String Depth32Float = 'depth32float';
  static const String Depth24Plus = 'depth24plus';
  static const String Depth16Unorm = 'depth16unorm';
  static const String Depth32FloatStencil8 = 'depth32float-stencil8';
  
  static const String BC1RGBAUnorm = 'bc1-rgba-unorm';
  static const String BC1RGBAUnormSRGB = 'bc1-rgba-unorm-srgb';
  static const String BC2RGBAUnorm = 'bc2-rgba-unorm';
  static const String BC2RGBAUnormSRGB = 'bc2-rgba-unorm-srgb';
  static const String BC3RGBAUnorm = 'bc3-rgba-unorm';
  static const String BC3RGBAUnormSRGB = 'bc3-rgba-unorm-srgb';
  static const String BC4RUnorm = 'bc4-r-unorm';
  static const String BC4RSNorm = 'bc4-r-snorm';
  static const String BC5RGUnorm = 'bc5-rg-unorm';
  static const String BC5RGSnorm = 'bc5-rg-snorm';
  static const String BC6HRGBUFloat = 'bc6h-rgb-ufloat';
  static const String BC6HRGBFloat = 'bc6h-rgb-float';
  static const String BC7RGBAUnorm = 'bc7-rgba-unorm';
  static const String BC7RGBAUnormSRGB = 'bc7-rgba-unorm-srgb';
}

class GPUAddressMode {
  static const String ClampToEdge = 'clamp-to-edge';
  static const String Repeat = 'repeat';
  static const String MirrorRepeat = 'mirror-repeat';
}

class GPUFilterMode {
  static const String Nearest = 'nearest';
  static const String Linear = 'linear';
}

class GPUTextureDimension {
  static const String OneD = '1d';
  static const String TwoD = '2d';
  static const String ThreeD = '3d';
}

class GPUInputStepMode {
  static const String Vertex = 'vertex';
  static const String Instance = 'instance';
}

class GPUCompareFunction {
  static const String Never = 'never';
  static const String Less = 'less';
  static const String Equal = 'equal';
  static const String LessEqual = 'less-equal';
  static const String Greater = 'greater';
  static const String NotEqual = 'not-equal';
  static const String GreaterEqual = 'greater-equal';
  static const String Always = 'always';
}

class GPUStencilOperation {
  static const String Keep = 'keep';
  static const String Zero = 'zero';
  static const String Replace = 'replace';
  static const String Invert = 'invert';
  static const String IncrementClamp = 'increment-clamp';
  static const String DecrementClamp = 'decrement-clamp';
  static const String IncrementWrap = 'increment-wrap';
  static const String DecrementWrap = 'decrement-wrap';
}

class GPUColorWriteFlags {
  static const int None = 0;
  static const int Red = 1;
  static const int Green = 2;
  static const int Blue = 4;
  static const int Alpha = 8;
  static const int All = 15;
}

class GPUFrontFace {
  static const String CCW = 'ccw';
  static const String CW = 'cw';
}

class GPUCullMode {
  static const String None = 'none';
  static const String Front = 'front';
  static const String Back = 'back';
}

class GPUPrimitiveTopology {
  static const String PointList = 'point-list';
  static const String LineList = 'line-list';
  static const String LineStrip = 'line-strip';
  static const String TriangleList = 'triangle-list';
  static const String TriangleStrip = 'triangle-strip';
}

class GPUVertexFormat {
  static const String Uint8x2 = 'uint8x2';
  static const String Uint8x4 = 'uint8x4';
  static const String Sint8x2 = 'sint8x2';
  static const String Sint8x4 = 'sint8x4';
  static const String Unorm8x2 = 'unorm8x2';
  static const String Unorm8x4 = 'unorm8x4';
  static const String Snorm8x2 = 'snorm8x2';
  static const String Snorm8x4 = 'snorm8x4';
  static const String Uint16x2 = 'uint16x2';
  static const String Uint16x4 = 'uint16x4';
  static const String Sint16x2 = 'sint16x2';
  static const String Sint16x4 = 'sint16x4';
  static const String Unorm16x2 = 'unorm16x2';
  static const String Unorm16x4 = 'unorm16x4';
  static const String Snorm16x2 = 'snorm16x2';
  static const String Snorm16x4 = 'snorm16x4';
  static const String Float16x2 = 'float16x2';
  static const String Float16x4 = 'float16x4';
  static const String Float32 = 'float32';
  static const String Float32x2 = 'float32x2';
  static const String Float32x3 = 'float32x3';
  static const String Float32x4 = 'float32x4';
  static const String Uint32 = 'uint32';
  static const String Uint32x2 = 'uint32x2';
  static const String Uint32x3 = 'uint32x3';
  static const String Uint32x4 = 'uint32x4';
  static const String Sint32 = 'sint32';
  static const String Sint32x2 = 'sint32x2';
  static const String Sint32x3 = 'sint32x3';
  static const String Sint32x4 = 'sint32x4';
}

class GPUBlendFactor {
  static const String Zero = 'zero';
  static const String One = 'one';
  static const String SrcColor = 'src-color';
  static const String OneMinusSrcColor = 'one-minus-src-color';
  static const String SrcAlpha = 'src-alpha';
  static const String OneMinusSrcAlpha = 'one-minus-src-alpha';
  static const String DstColor = 'dst-color';
  static const String OneMinusDstColor = 'one-minus-dst-color';
  static const String DstAlpha = 'dst-alpha';
  static const String OneMinusDstAlpha = 'one-minus-dst-alpha';
  static const String SrcAlphaSaturated = 'src-alpha-saturated';
  static const String BlendColor = 'blend-color';
  static const String OneMinusBlendColor = 'one-minus-blend-color';
}

class GPUBlendOperation {
  static const String Add = 'add';
  static const String Subtract = 'subtract';
  static const String ReverseSubtract = 'reverse-subtract';
  static const String Min = 'min';
  static const String Max = 'max';
}

class GPUBufferBindingType {
  static const String Uniform = 'uniform';
  static const String Storage = 'storage';
  static const String ReadonlyStorage = 'read-only-storage';
}

class GPUExtent3D {
  late int width;
  late int height;
  late int depthOrArrayLayers;
  GPUExtent3D({required this.width, required this.height, this.depthOrArrayLayers = 1});
}

class GPUOrigin3D {
  late int x, y, z;
  GPUOrigin3D({this.x = 0, this.y = 0, this.z = 0});
}

class GPUBufferDescriptor {
  late int size;
  late int usage;
  late String? label;
  late bool mappedAtCreation;
  GPUBufferDescriptor({required this.size, required this.usage, this.label, this.mappedAtCreation = false});
}

class GPUTextureDescriptor {
  late dynamic size;
  late int mipLevelCount;
  late int sampleCount;
  late String dimension;
  late String format;
  late int usage;
  GPUTextureDescriptor({this.size, this.mipLevelCount = 1, this.sampleCount = 1, this.dimension = '2d', this.format = 'rgba8unorm', this.usage = 0});
}

class GPUSamplerDescriptor {
  late String addressModeU, addressModeV, addressModeW;
  late String magFilter, minFilter, mipmapFilter;
  late double lodMinClamp, lodMaxClamp;
  late String compare;
  late int maxAnisotropy;
  GPUSamplerDescriptor({
    this.addressModeU = GPUAddressMode.ClampToEdge, 
    this.addressModeV = GPUAddressMode.ClampToEdge, 
    this.addressModeW = GPUAddressMode.ClampToEdge, 
    this.magFilter = GPUFilterMode.Nearest, 
    this.minFilter = GPUFilterMode.Nearest, 
    this.mipmapFilter = GPUFilterMode.Nearest, 
    this.lodMinClamp = 0, 
    this.lodMaxClamp = 32, 
    this.compare = GPUCompareFunction.Always, 
    this.maxAnisotropy = 1
  });
}

class GPUTextureDataLayout {
  late int offset;
  late int bytesPerRow;
  late int rowsPerImage;
  GPUTextureDataLayout({this.offset = 0, this.bytesPerRow = 0, this.rowsPerImage = 0});
}

class GPUShaderModuleDescriptor {
  late String code;
  late String? label;
  GPUShaderModuleDescriptor({required this.code, this.label});
}

class GPURenderPipelineDescriptor {
  late dynamic layout;
  late dynamic vertex;
  late dynamic fragment;
  late dynamic primitive;
  late dynamic depthStencil;
  late dynamic multisample;
  GPURenderPipelineDescriptor({this.layout, this.vertex, this.fragment, this.primitive, this.depthStencil, this.multisample});
}

class GPUVertexState {
  late dynamic module;
  late String entryPoint;
  late List buffers;
  GPUVertexState({this.module, this.entryPoint = 'main', this.buffers = const []});
}

class GPUFragmentState {
  late dynamic module;
  late String entryPoint;
  late dynamic targets;
  GPUFragmentState({this.module, this.entryPoint = 'main', this.targets});
}

class GPUColorTargetState {
  late String format;
  late dynamic blend;
  late int writeMask;
  GPUColorTargetState({required this.format, this.blend, this.writeMask = 0xF});
}

class GPUPrimitiveState {
  late String topology;
  late String? stripIndexFormat;
  late String frontFace;
  late String cullMode;
  GPUPrimitiveState({this.topology = 'triangle-list', this.stripIndexFormat, this.frontFace = 'ccw', this.cullMode = 'back'});
}

class GPUMultisampleState {
  late int count;
  late int mask;
  late bool alphaToCoverageEnabled;
  GPUMultisampleState({this.count = 1, this.mask = 0xFFFFFFFF, this.alphaToCoverageEnabled = false});
}

class GPUTextureViewDescriptor {
  late String? format;
  late dynamic dimension;
  late String aspect;
  late int baseMipLevel;
  late int mipLevelCount;
  late int baseArrayLayer;
  late int arrayLayerCount;
  GPUTextureViewDescriptor({this.format, this.dimension, this.aspect = 'all', this.baseMipLevel = 0, this.mipLevelCount = 1, this.baseArrayLayer = 0, this.arrayLayerCount = 1});
}

class GPUBindGroupDescriptor {
  late dynamic layout;
  late List entries;
  late int? entryCount;
  GPUBindGroupDescriptor({required this.layout, required this.entries, this.entryCount});
}

class GPUBindGroupEntry {
  late int binding;
  late dynamic resource;
  late dynamic buffer;
  late dynamic sampler;
  late dynamic textureView;
  GPUBindGroupEntry({required this.binding, this.resource, this.buffer, this.sampler, this.textureView});
}

class GPUBindGroupLayoutDescriptor {
  late List entries;
  GPUBindGroupLayoutDescriptor({required this.entries});
}

class GPUBindGroupLayoutEntry {
  late int binding;
  late int visibility;
  late dynamic buffer;
  late dynamic sampler;
  late dynamic texture;
  late dynamic storageTexture;
  GPUBindGroupLayoutEntry({required this.binding, required this.visibility, this.buffer, this.sampler, this.texture, this.storageTexture});
}

class GPUBufferBindingLayout {
  late String type;
  late bool hasDynamicOffset;
  late int minBindingSize;
  GPUBufferBindingLayout({this.type = 'uniform', this.hasDynamicOffset = false, this.minBindingSize = 0});
}

class GPUPipelineLayoutDescriptor {
  late dynamic bindGroupLayouts;
  late int? bindGroupLayoutCount;
  GPUPipelineLayoutDescriptor({required this.bindGroupLayouts, this.bindGroupLayoutCount});
}

class GPUComputePipelineDescriptor {
  late dynamic layout;
  late dynamic compute;
  GPUComputePipelineDescriptor({this.layout, this.compute});
}

class GPUVertexAttribute {
  late String format;
  late int offset;
  late int shaderLocation;
  GPUVertexAttribute({required this.format, required this.offset, required this.shaderLocation});
}

class GPUStencilFaceState {
  late String compare;
  late String failOp;
  late String depthFailOp;
  late String passOp;
  GPUStencilFaceState({this.compare = 'always', this.failOp = 'keep', this.depthFailOp = 'keep', this.passOp = 'keep'});
}

class GPUDepthStencilState {
  late String format;
  late bool depthWriteEnabled;
  late String depthCompare;
  late dynamic stencilFront;
  late dynamic stencilBack;
  late int stencilReadMask;
  late int stencilWriteMask;
  late int depthBias;
  late double depthBiasSlopeScale;
  late double depthBiasClamp;
  GPUDepthStencilState({
    required this.format, 
    this.depthWriteEnabled = false, 
    this.depthCompare = 'always', 
    this.stencilFront, 
    this.stencilBack, 
    this.stencilReadMask = 0xFFFFFFFF, 
    this.stencilWriteMask = 0xFFFFFFFF, 
    this.depthBias = 0, 
    this.depthBiasSlopeScale = 0.0, 
    this.depthBiasClamp = 0.0
  });
}

class GPUBlendState {
  late dynamic color;
  late dynamic alpha;
  GPUBlendState({this.color, this.alpha});
}

class GPUBlendComponent {
  late String operation;
  late String srcFactor;
  late String dstFactor;
  GPUBlendComponent({this.operation = 'add', this.srcFactor = 'one', this.dstFactor = 'zero'});
}

class GPUVertexBufferLayout {
  late int arrayStride;
  late String stepMode;
  late List attributes;
  GPUVertexBufferLayout({this.arrayStride = 0, this.stepMode = 'vertex', this.attributes = const []});
}

class GPUImageCopyTexture {
  late dynamic texture;
  late int mipLevel;
  late dynamic origin;
  GPUImageCopyTexture({required this.texture, this.mipLevel = 0, this.origin});
}

class GPUTextureUsage {
  static const int CopySrc = 1;
  static const int CopyDst = 2;
  static const int TextureBinding = 4;
  static const int StorageBinding = 8;
  static const int RenderAttachment = 16;
}

class GPURenderPassDescriptor {
  late dynamic colorAttachments;
  late dynamic depthStencilAttachment;
  GPURenderPassDescriptor({required this.colorAttachments, this.depthStencilAttachment});
}

class GPURenderPassColorAttachment {
  late dynamic view;
  late dynamic resolveTarget;
  late String loadOp;
  late String storeOp;
  late dynamic clearValue;
  late dynamic clearColor;
  late dynamic loadValue;
  GPURenderPassColorAttachment({this.view, this.resolveTarget, this.loadOp = GPULoadOp.Load, this.storeOp = GPUStoreOp.Store, this.clearValue, this.clearColor, this.loadValue});
}

class GPURenderPassDepthStencilAttachment {
  late dynamic view;
  late String depthLoadOp;
  late String depthStoreOp;
  late double depthClearValue;
  late String stencilLoadOp;
  late String stencilStoreOp;
  late int stencilClearValue;
  late dynamic clearDepth;
  late dynamic clearStencil;
  late dynamic depthLoadValue;
  late dynamic stencilLoadValue;
  GPURenderPassDepthStencilAttachment({
    this.view, 
    this.depthLoadOp = GPULoadOp.Load, 
    this.depthStoreOp = GPUStoreOp.Store, 
    this.depthClearValue = 1.0, 
    this.stencilLoadOp = GPULoadOp.Load, 
    this.stencilStoreOp = GPUStoreOp.Store, 
    this.stencilClearValue = 0,
    this.clearDepth,
    this.clearStencil,
    this.depthLoadValue,
    this.stencilLoadValue
  });
}

class GPUAdapter {
  requestDevice([descriptor]) {}
}

class GPUDevice {
  late dynamic queue;
  createBuffer(GPUBufferDescriptor descriptor) {}
  createTexture(GPUTextureDescriptor descriptor) {}
  createSampler([GPUSamplerDescriptor? descriptor]) {}
  createBindGroupLayout(GPUBindGroupLayoutDescriptor descriptor) {}
  createPipelineLayout(GPUPipelineLayoutDescriptor descriptor) {}
  createBindGroup(GPUBindGroupDescriptor descriptor) {}
  createShaderModule(GPUShaderModuleDescriptor descriptor) {}
  createRenderPipeline(GPURenderPipelineDescriptor descriptor) {}
  createComputePipeline(GPUComputePipelineDescriptor descriptor) {}
  createCommandEncoder([descriptor]) {}
  poll(wait) {}
}

class GPUQueue {
  submit(buffers) {}
  writeBuffer(buffer, bufferOffset, data, [dataOffset, size]) {}
  writeTexture(destination, data, dataLayout, size) {}
}

class GPUBuffer {
  mapAsync(mode, [offset, size]) {}
  getMappedRange([offset, size]) {}
  unmap() {}
  destroy() {}
}

class GPUTexture {
  createView([GPUTextureViewDescriptor? descriptor]) {}
  destroy() {}
}

class GPUSampler {}
class GPUBindGroupLayout {}
class GPUPipelineLayout {}
class GPURenderPipeline {
  late dynamic pipeline;
}
class GPUComputePipeline {}
class GPUBindGroup {}
class GPUShaderModule {}

class GPUCommandEncoder {
  beginRenderPass(GPURenderPassDescriptor descriptor) {}
  beginComputePass([descriptor]) {}
  copyBufferToBuffer(source, sourceOffset, destination, destinationOffset, size) {}
  copyBufferToTexture(source, destination, copySize) {}
  copyTextureToBuffer(source, destination, copySize) {}
  copyTextureToTexture(source, destination, copySize) {}
  finish([descriptor]) {}
}

class GPURenderPassEncoder {
  setPipeline(pipeline) {}
  setBindGroup(index, bindGroup, [dynamic offsets]) {}
  setIndexBuffer(buffer, indexFormat, [offset, size]) {}
  setVertexBuffer(slot, buffer, [offset, size]) {}
  draw(vertexCount, [instanceCount, firstVertex, firstInstance]) {}
  drawIndexed(indexCount, [instanceCount, firstIndex, baseVertex, firstInstance]) {}
  setViewport(x, y, width, height, minDepth, maxDepth) {}
  setScissorRect(x, y, width, height) {}
  end() {}
}

class GPUComputePassEncoder {
  setPipeline(pipeline) {}
  setBindGroup(index, bindGroup, [dynamic offsets]) {}
  dispatch(x, [y, z]) {}
  end() {}
}

class GPUCommandBuffer {}

class GPUColor {
  late double r, g, b, a;
  GPUColor({this.r = 0.0, this.g = 0.0, this.b = 0.0, this.a = 1.0});
}

class GPUDeviceDescriptor {
  late int? maxBindGroups;
  GPUDeviceDescriptor({this.maxBindGroups});
}

class GPURequestAdapterOptions {
  late dynamic powerPreference;
  GPURequestAdapterOptions({this.powerPreference});
}

class GPUCommandBufferDescriptor {
  late String? label;
  GPUCommandBufferDescriptor({this.label});
}

class GPUImageCopyBuffer {
  late dynamic buffer;
  late int offset;
  late int bytesPerRow;
  late int rowsPerImage;
  GPUImageCopyBuffer({required this.buffer, this.offset = 0, required this.bytesPerRow, this.rowsPerImage = 0});
}

class GPUBindingType {
  static const String UniformBuffer = 'uniform-buffer';
  static const String StorageBuffer = 'storage-buffer';
  static const String ReadonlyStorageBuffer = 'readonly-storage-buffer';
  static const String Sampler = 'sampler';
  static const String ComparisonSampler = 'comparison-sampler';
  static const String SampledTexture = 'sampled-texture';
  static const String MultisampledTexture = 'multisampled-texture';
  static const String ReadonlyStorageTexture = 'readonly-storage-texture';
  static const String WriteonlyStorageTexture = 'writeonly-storage-texture';
}

class GPUTextureViewDimension {
  static const String OneD = '1d';
  static const String TwoD = '2d';
  static const String TwoDArray = '2d-array';
  static const String Cube = 'cube';
  static const String CubeArray = 'cube-array';
  static const String ThreeD = '3d';
}

// Global functions
requestAdapter([options]) {}
const int WGPUMapMode_Read = 1;
const int WGPUMapMode_Write = 2;
const int GPUChunkSize = 16;
const int BlendColorFactor = 211;
const int OneMinusBlendColorFactor = 212;
