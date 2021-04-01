/// 请求的各种状态集合
/// * blank [PQSkeletonLoadStatus.blank] 默认的状态
/// * loading [PQSkeletonLoadStatus.loading] 加载中
/// * loading [PQSkeletonLoadStatus.success] 加载成功
/// * noNetwork [PQSkeletonLoadStatus.noNetwork] 没有网络
/// * failed [PQSkeletonLoadStatus.failed] 加载失败
/// * emptyData [PQSkeletonLoadStatus.emptyData] 空数据
/// * custom [PQSkeletonLoadStatus.custom] 自定义
enum PQSkeletonLoadStatus {
  blank,
  loading,
  success,
  noNetwork,
  failed,
  emptyData,
  custom
}
