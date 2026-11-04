Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834649;
	b=DjtFv2/lWQtRM8eoaXzjkGhg1JYiFtW0Po9aHAA8SXv+qsIBQX9Xs5KhwRXMCBMcVThS
	 dT9z4YnfH82BB3M3krsS6CiMYad5UNDxI4BUR2ixSQiRBW6T76MNa31HYrPNI326lkVHG
	 ff4kg09I4oF0S3dD95LqSmAVEK/sWeijLgnDlIfEaptROY4zc6emq3QP9EyVRB7F8pudz
	 ydcxzoV0FzMNuz6kUaq1uyOkfB4ZI+B3bxgyk3ej0+OXW1avbvh/r4zmBvMcyhuDPwKLR
	 vbsoDFZwLqq0Ld9W/tD4NWFKh64RXnAHycwILHhOwnkrgyC+rebuTYVnYuavYCzLfLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834649;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=jYeLi8tUmdcFROiq/jmTkZ4ahpzcaw03wqXaIhratXY=;
	b=q3+kUTvPbYfdTRmoKDhyxloTHgPn899rkxlRMbyQVxcrCI5DGb11VJpZSL2Oeh9XvA/6
	 9wkrxTpdegXsRn/Wvje9tWwi+EuwuxJC2Ann1c/ha5ATyMjco43C+Iiw/hDOcpqykyihs
	 55eWYQSBxkypu1/wuksGB5DK5IVw1om/tG/JXolA16leg2UEUQRw5di4XZuY/NAOXyKTs
	 XyLwltEQW8GCP9GKKbdV8uWfTEnLLBhSIlFb7CHK/1QUsLn65Y+ureaIzpyhxJE8Xi1uN
	 zZUiLwriyzRPx/5Q+LzGYQrps//YQMRfG6RCD1CCXrRjGgjG0VaS3xemaSrotn4DAdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="J6eQ9pL/";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317E606A31B;
	Wed,  4 Nov 2026 23:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B317E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=J6eQ9pL/
Received: from localhost (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F0C820B7166;
	Wed,  4 Nov 2026 15:23:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F0C820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793834632;
	bh=jYeLi8tUmdcFROiq/jmTkZ4ahpzcaw03wqXaIhratXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6eQ9pL/r15bH7Qh1CB8Nj21vQZAsQ49wPwIRLFaB/znP1aeZE+SgGk+3BMCorZX8
	 qb7tbVHfG/vE6yOjWiSn1CVWqWZ2AtQU2yrQR8m++pexA+HDASvrrghR4WKGicGN/4
	 Tg56ukofwyEtVSfUNJqMKpz4JzwcXy74SP9GRGzE=
Date: Wed, 4 Nov 2026 15:23:51 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>, Alexey
 Kardashevskiy <aik@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Jonathan
 Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Krishna
 Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Nicolin Chen
 <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, Samuel Ortiz
 <sameo@rivosinc.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Steven Price
 <steven.price@arm.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>, Vasant Hegde
 <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Xu Yilun
 <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Message-ID: <20261104152351.00002565@linux.microsoft.com>
In-Reply-To: <20261104161632.3547423-13-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
	<20261104161632.3547423-13-aneesh.kumar@kernel.org>
Organization: LSG
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Aneesh,

On Wed,  4 Nov 2026 21:46:29 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> In confidential-computing configurations, a vIOMMU may be implemented
> by a TEE Security Manager rather than by the physical IOMMU driver.
> Such an implementation also needs the TSM identity when creating and
> validating vdevices.
>=20
> Allow VIOMMU_ALLOC to first query the TSM associated with the target
> PCI device for vIOMMU operations. Fall back to the physical IOMMU
> driver when the TSM does not provide operations for the requested
> vIOMMU type.
>=20
> Resolve the PCI TSM association under pci_tsm_rwsem, pin the module
> providing the operations, and take a TSM device reference. Store the
> TSM device in the vIOMMU and release both references on allocation
> failure, fallback to the physical IOMMU driver, or vIOMMU
> destruction. Keep the module pinned until after dropping the device
> reference, since the final put may release the TSM device.
>=20
> The device reference preserves the TSM allocation. Backends providing
> vIOMMU operations must not unregister their TSM while the module is
> pinned, since the reference does not prevent backend resource
> teardown.
>=20
> This enables the Realm vIOMMU implementation to provide its operations
> through the PCI TSM backend and retain the TSM identity needed by its
> vdevices.
>=20
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: iommu@lists.linux.dev
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/viommu.c | 35 +++++++++++++++++++++++++++-----
>  drivers/pci/tsm/core.c         | 22 ++++++++++++++++++++
>  drivers/virt/coco/tsm-core.c   | 37
> ++++++++++++++++++++++++++++++++++ include/linux/iommufd.h        |
> 2 ++ include/linux/pci-tsm.h        | 24 ++++++++++++++++++++++
>  include/linux/tsm.h            | 25 +++++++++++++++++++++++
>  6 files changed, 140 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iommu/iommufd/viommu.c
> b/drivers/iommu/iommufd/viommu.c index 16e8b6421f1f..1686f19c5060
> 100644 --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -15,6 +15,8 @@ void iommufd_viommu_destroy(struct iommufd_object
> *obj)=20
>  	if (viommu->ops && viommu->ops->destroy)
>  		viommu->ops->destroy(viommu);
> +	if (viommu->tsm_dev)
> +		tsm_put_device(viommu->tsm_dev);
>  	refcount_dec(&viommu->hwpt->common.obj.users);
>  	if (viommu->kvm_file)
>  		fput(viommu->kvm_file);
> @@ -30,6 +32,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd
> *ucmd) .len =3D cmd->data_len,
>  	};
>  	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct tsm_dev *tsm_dev =3D NULL;
>  	struct iommufd_viommu *viommu;
>  	struct iommufd_device *idev;
>  	struct iommu_device *iommu_dev;
> @@ -49,15 +52,33 @@ int iommufd_viommu_alloc_ioctl(struct
> iommufd_ucmd *ucmd) rc =3D -EOPNOTSUPP;
>  		goto out_put_idev;
>  	}
> -	if (!iommu_dev->ops->get_viommu_ops) {
> -		rc =3D -EOPNOTSUPP;
> +	tsm_dev =3D tsm_get_device(idev->dev);
So I want to reuse this flow for MSHV since tsm already does module
pinning and locking for backend providers. Once MSHV supports TDISP, it
could register a link TSM similarly to the CCA =A0cca_link_pci_ops.

However, we also want to use the same viommu/vdevice flow to support
non-confidential device assignment with Hypervisor managed S2 mapping.
I belive pKVM has the same need.[1]

I am thinking MSHV/pKVM can register an assignment-only tsm_dev to
leverage this? Could PCI/TSM support this role without device-security?

Something like:
@@ -48,7 +41,13 @@ struct pci_tsm_ops {
        struct module *owner;
        const struct iommufd_viommu_ops *(*viommu_get_ops)(
                struct device *dev, enum iommu_viommu_type type);
+
+       struct pci_tsm_assignment_ops {
+               bool (*match)(struct pci_dev *pdev);
+               struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
+                                        struct pci_dev *pdev);
+               void (*remove)(struct pci_tsm *tsm);
+       } assignment_ops;

[1] https://lore.kernel.org/linux-iommu/atiaKG86qcifKzBT@google.com/
> +	if (IS_ERR(tsm_dev)) {
> +		rc =3D PTR_ERR(tsm_dev);
> +		tsm_dev =3D NULL;
>  		goto out_put_idev;
>  	}
> -	ops =3D iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
> -	if (!ops) {
> -		rc =3D -EOPNOTSUPP;
> +	ops =3D tsm_dev ? tsm_viommu_get_ops(tsm_dev, idev->dev,
> cmd->type) : NULL;
> +	if (IS_ERR(ops)) {
> +		rc =3D PTR_ERR(ops);
>  		goto out_put_idev;
>  	}
> +	if (!ops) {
> +		if (tsm_dev) {
> +			tsm_put_device(tsm_dev);
> +			tsm_dev =3D NULL;
> +		}
> +		if (!iommu_dev->ops->get_viommu_ops) {
> +			rc =3D -EOPNOTSUPP;
> +			goto out_put_idev;
> +		}
> +		ops =3D iommu_dev->ops->get_viommu_ops(idev->dev,
> cmd->type);
> +		if (!ops) {
> +			rc =3D -EOPNOTSUPP;
> +			goto out_put_idev;
> +		}
> +	}
> +
>  	/*
>  	 * It is a driver bug to omit the required operations or
> provide a size
>  	 * smaller than the core vIOMMU structure.
> @@ -95,6 +116,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd
> *ucmd) viommu->kvm_file =3D get_file(idev->kvm_file);
>  	viommu->type =3D cmd->type;
>  	viommu->ictx =3D ucmd->ictx;
> +	viommu->tsm_dev =3D tsm_dev;
> +	tsm_dev =3D NULL;
>  	viommu->hwpt =3D hwpt_paging;
>  	refcount_inc(&viommu->hwpt->common.obj.users);
>  	INIT_LIST_HEAD(&viommu->veventqs);
> @@ -119,6 +142,8 @@ int iommufd_viommu_alloc_ioctl(struct
> iommufd_ucmd *ucmd) out_put_hwpt:
>  	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
>  out_put_idev:
> +	if (tsm_dev)
> +		tsm_put_device(tsm_dev);
>  	iommufd_put_object(ucmd->ictx, &idev->obj);
>  	return rc;
>  }
> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> index 96ba5a8be8af..5ded1a5a4f7e 100644
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c
> @@ -9,6 +9,8 @@
>  #define dev_fmt(fmt) "PCI/TSM: " fmt
> =20
>  #include <linux/bitfield.h>
> +#include <linux/iommufd.h>
> +#include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/pci-tsm.h>
> @@ -36,6 +38,26 @@ static const struct pci_tsm_ops
> *to_pci_tsm_ops(struct pci_tsm *tsm) return tsm->tsm_dev->pci_ops;
>  }
> =20
> +struct tsm_dev *pci_tsm_get_device(struct pci_dev *pdev)
> +{
> +	const struct pci_tsm_ops *ops;
> +	struct tsm_dev *tsm_dev;
> +
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +	if (!pdev->tsm)
> +		return NULL;
> +
> +	tsm_dev =3D pdev->tsm->tsm_dev;
> +	ops =3D tsm_dev->pci_ops;
> +	if (!ops->viommu_get_ops)
> +		return NULL;
> +	if (!try_module_get(ops->owner))
> +		return ERR_PTR(-ENODEV);
> +	get_device(&tsm_dev->dev);
> +	return tsm_dev;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_get_device);
> +
>  static inline bool is_dsm(struct pci_dev *pdev)
>  {
>  	return pdev->tsm && pdev->tsm->dsm_dev =3D=3D pdev;
> diff --git a/drivers/virt/coco/tsm-core.c
> b/drivers/virt/coco/tsm-core.c index e7807dc94807..92ce3337f1ea 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -9,6 +9,16 @@
>  #include <linux/cleanup.h>
>  #include <linux/pci-tsm.h>
> =20
> +/* The caller must hold a tsm_get_device() reference for the entire
> use. */ +const struct iommufd_viommu_ops *tsm_viommu_get_ops(struct
> tsm_dev *tsm_dev,
> +		struct device *dev, enum iommu_viommu_type type)
> +{
> +	if (!tsm_dev->pci_ops->viommu_get_ops)
> +		return NULL;
> +	return tsm_dev->pci_ops->viommu_get_ops(dev, type);
> +}
> +EXPORT_SYMBOL_GPL(tsm_viommu_get_ops);
> +
>  static void tsm_release(struct device *);
>  static const struct class tsm_class =3D {
>  	.name		=3D "tsm",
> @@ -16,6 +26,33 @@ static const struct class tsm_class =3D {
>  };
>  static DEFINE_IDA(tsm_ida);
> =20
> +/**
> + * tsm_get_device() - Pin the TSM attached to a device
> + * @dev: device whose TSM is to be pinned
> + *
> + * A successful lookup takes a TSM device reference and pins the
> backend
> + * module. Release both with tsm_put_device(). Backends providing
> vIOMMU
> + * operations must not unregister their TSM independently of module
> unload.
> + * Return: NULL if no vIOMMU-capable TSM is attached, an error if
> the module
> + * cannot be pinned, or the TSM device associated with the pinned
> backend.
> + */
> +struct tsm_dev *tsm_get_device(struct device *dev)
> +{
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +	return pci_tsm_get_device(to_pci_dev(dev));
> +}
> +EXPORT_SYMBOL_GPL(tsm_get_device);
> +
> +void tsm_put_device(struct tsm_dev *tsm_dev)
> +{
> +	struct module *owner =3D tsm_dev->pci_ops->owner;
> +
> +	put_device(&tsm_dev->dev);
> +	module_put(owner);
> +}
> +EXPORT_SYMBOL_GPL(tsm_put_device);
> +
>  static int match_id(struct device *dev, const void *data)
>  {
>  	struct tsm_dev *tsm_dev =3D container_of(dev, struct tsm_dev,
> dev); diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 5f5c67b24134..a4b29915d0ca 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -23,6 +23,7 @@ struct iommufd_access;
>  struct iommufd_ctx;
>  struct iommufd_device;
>  struct iommufd_viommu_ops;
> +struct tsm_dev;
>  struct page;
> =20
>  enum iommufd_object_type {
> @@ -104,6 +105,7 @@ struct iommufd_viommu {
>  	struct iommu_device *iommu_dev;
>  	struct iommufd_hwpt_paging *hwpt;
>  	struct file *kvm_file;
> +	struct tsm_dev *tsm_dev;
> =20
>  	const struct iommufd_viommu_ops *ops;
> =20
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index eaf0199d01f7..19e9e0ef3bbb 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -3,7 +3,10 @@
>  #define __PCI_TSM_H
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <uapi/linux/iommufd.h>
> =20
> +struct iommufd_viommu_ops;
> +struct module;
>  struct pci_tsm;
>  struct pci_tsm_context;
>  struct tsm_dev;
> @@ -16,12 +19,27 @@ struct tsm_dev;
>   * @devsec_ops: Lock, unlock, and interrogate the security state of
> the
>   *		function via the platform TSM (typically virtual
> function
>   *		operations).
> + * @viommu_get_ops: Return operations for a supported TSM-owned
> vIOMMU type,
> + *		  or NULL if unsupported
> + * @owner: Module providing the vIOMMU operations, if built as a
> module
> + *
> + * The vIOMMU owner holds a TSM device reference and pins the
> backend module
> + * before querying @viommu_get_ops, releasing both after vIOMMU
> destruction.
> + * A backend providing this callback must not unregister its TSM
> while the
> + * module is pinned.
>   *
>   * This operations are mutually exclusive either a tsm_dev instance
>   * manages physical link properties or it manages function security
>   * states like TDISP lock/unlock.
> + *
> + * @viommu_get_ops runs with the backend module pinned. The PCI/TSM
> + * association is checked during acquisition under pci_tsm_rwsem.
>   */
>  struct pci_tsm_ops {
> +	struct module *owner;
> +	const struct iommufd_viommu_ops *(*viommu_get_ops)(
> +		struct device *dev, enum iommu_viommu_type type);
> +
>  	/*
>  	 * struct pci_tsm_link_ops - Manage physical link and the
> TSM/DSM session
>  	 * @probe: establish context with the TSM (allocate / wrap
> 'struct @@ -151,6 +169,7 @@ struct pci_tsm_pf0
> *pci_tsm_context_pf0(struct pci_tsm_context *context); struct pci_dev
> *pci_tsm_context_dsm_dev(struct pci_tsm_context *context); bool
> pci_tsm_context_match_device(struct pci_tsm_context *context, struct
> pci_dev *pdev); +struct tsm_dev *pci_tsm_get_device(struct pci_dev
> *pdev); #else
>  static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>  {
> @@ -165,6 +184,11 @@ static inline bool pci_tsm_is_configured(struct
> pci_dev *pdev) return false;
>  }
> =20
> +static inline struct tsm_dev *pci_tsm_get_device(struct pci_dev
> *pdev) +{
> +	return NULL;
> +}
> +
>  static inline struct pci_tsm_context *
>  pci_tsm_context_get(struct pci_dev *pdev, struct tsm_dev
> *viommu_tsm_dev) {
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 19dedf971f14..3d5286aeaa42 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -110,6 +110,8 @@ struct tsm_report_ops {
>  };
> =20
>  struct pci_tsm_ops;
> +struct iommufd_viommu_ops;
> +
>  struct tsm_dev {
>  	struct device dev;
>  	int id;
> @@ -124,4 +126,27 @@ int tsm_report_unregister(const struct
> tsm_report_ops *ops); struct tsm_dev *tsm_register(struct device
> *parent, struct pci_tsm_ops *ops); void tsm_unregister(struct tsm_dev
> *tsm_dev); struct tsm_dev *find_tsm_dev(int id);
> +
> +#ifdef CONFIG_TSM
> +struct tsm_dev *tsm_get_device(struct device *dev);
> +void tsm_put_device(struct tsm_dev *tsm_dev);
> +const struct iommufd_viommu_ops *tsm_viommu_get_ops(struct tsm_dev
> *tsm_dev,
> +		struct device *dev, enum iommu_viommu_type type);
> +#else
> +static inline struct tsm_dev *tsm_get_device(struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +static inline void tsm_put_device(struct tsm_dev *tsm_dev)
> +{
> +}
> +
> +static inline const struct iommufd_viommu_ops *
> +tsm_viommu_get_ops(struct tsm_dev *tsm_dev, struct device *dev,
> +		enum iommu_viommu_type type)
> +{
> +	return NULL;
> +}
> +#endif
>  #endif /* __TSM_H */

