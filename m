Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64930AABC
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417492; cv=none; b=eC9YoadR0I3N298CCJ74IureL3xfQbx9FeFEUAyEE04QG48ELLD0U2thQwbhwGuavCwajuoqXswsnUvSCPf3PVfUaHdOds5nAvDSLkm5F3a1Kjs+PJW+8SQv0VOJL/wK6eBUXFSHfh+FcmfJ0C0OJFUPqO8CI0DimEswxx7QbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417492; c=relaxed/simple;
	bh=LLkqhZ9N+SgP8u+HwW8Vo0qy2/lC5t6oS5IC0lknNH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHPjJv8tcLs+S8CLYUW+ins7AYKCqLWzLRRxh7FcgaLJTunUK2NCvntgCF2rrf1+F/2WJl0jTTOXkwfGGRTK5uJUjE2WsHxTH8SPtMlIkWm6MLR5o7IJZSYRDSQ4RLGR6ivEaWbXf5ZirTqjo1lD1NaQmZl3TdbFABZFL2GKbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ltabsfcp; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ltabsfcp"
Message-ID: <6dc423bd-36e6-4f97-b2b2-c7030575a3a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770417479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jJ4UYueeYSPKpn5obREQWJr7THiJ5jfhsdhIm5npyc=;
	b=LtabsfcpkYYNEXj4rk6UxoAeebNMHH+eAxM6nF6ShkMfYHLDWCU9u7fr+tGWlVOjNlm5Ou
	2OCzSUYh05QKsYDU3hO1T/8obHmFYsBVToWOzWid2CAfWQklQinbky6jUjgvnMC1r7RgMq
	3l//E3MjKtfTYGC+VYr6MkBgsyp5+9w=
Date: Fri, 6 Feb 2026 14:37:45 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal
 <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>,
 Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
 kexec@lists.infradead.org, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pranjal Shrivastava <praan@google.com>, Pratyush Yadav
 <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-5-dmatlack@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260129212510.967611-5-dmatlack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/29/26 1:24 PM, David Matlack wrote:
> From: Vipin Sharma <vipinsh@google.com>
>
> Register a live update file handler for vfio-pci device files. Add stub
> implementations of all required callbacks so that registration does not
> fail (i.e. to avoid breaking git-bisect).
>
> This file handler will be extended in subsequent commits to enable a
> device bound to vfio-pci to run without interruption while the host is
> going through a kexec Live Update.
>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Co-developed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>   MAINTAINERS                            |  1 +
>   drivers/vfio/pci/Makefile              |  1 +
>   drivers/vfio/pci/vfio_pci.c            |  9 +++-
>   drivers/vfio/pci/vfio_pci_liveupdate.c | 69 ++++++++++++++++++++++++++
>   drivers/vfio/pci/vfio_pci_priv.h       | 14 ++++++
>   include/linux/kho/abi/vfio_pci.h       | 28 +++++++++++
>   6 files changed, 121 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
>   create mode 100644 include/linux/kho/abi/vfio_pci.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a671e3d4e8be..7d6cdecedb05 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27520,6 +27520,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
>   F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
>   F:	Documentation/driver-api/vfio.rst
>   F:	drivers/vfio/
> +F:	include/linux/kho/abi/vfio_pci.h
>   F:	include/linux/vfio.h
>   F:	include/linux/vfio_pci_core.h
>   F:	include/uapi/linux/vfio.h
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index e0a0757dd1d2..23305ebc418b 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
>   
>   vfio-pci-y := vfio_pci.o
>   vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> +vfio-pci-$(CONFIG_LIVEUPDATE) += vfio_pci_liveupdate.o
>   obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
>   
>   obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 0c771064c0b8..19e88322af2c 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -258,6 +258,10 @@ static int __init vfio_pci_init(void)
>   	int ret;
>   	bool is_disable_vga = true;
>   
> +	ret = vfio_pci_liveupdate_init();
> +	if (ret)
> +		return ret;
> +
>   #ifdef CONFIG_VFIO_PCI_VGA
>   	is_disable_vga = disable_vga;
>   #endif
> @@ -266,8 +270,10 @@ static int __init vfio_pci_init(void)
>   
>   	/* Register and scan for devices */
>   	ret = pci_register_driver(&vfio_pci_driver);
> -	if (ret)
> +	if (ret) {
> +		vfio_pci_liveupdate_cleanup();
>   		return ret;
> +	}
>   
>   	vfio_pci_fill_ids();
>   
> @@ -281,6 +287,7 @@ module_init(vfio_pci_init);
>   static void __exit vfio_pci_cleanup(void)
>   {
>   	pci_unregister_driver(&vfio_pci_driver);
> +	vfio_pci_liveupdate_cleanup();
>   }
>   module_exit(vfio_pci_cleanup);
>   
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> new file mode 100644
> index 000000000000..b84e63c0357b
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Vipin Sharma <vipinsh@google.com>
> + * David Matlack <dmatlack@google.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kho/abi/vfio_pci.h>
> +#include <linux/liveupdate.h>
> +#include <linux/errno.h>
> +
> +#include "vfio_pci_priv.h"
> +
> +static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
> +					     struct file *file)
> +{
> +	return false;
> +}
> +
> +static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
> +{
> +}
> +
> +static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
> +{
> +}
> +
> +static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
> +	.can_preserve = vfio_pci_liveupdate_can_preserve,
> +	.preserve = vfio_pci_liveupdate_preserve,
> +	.unpreserve = vfio_pci_liveupdate_unpreserve,
> +	.retrieve = vfio_pci_liveupdate_retrieve,
> +	.finish = vfio_pci_liveupdate_finish,
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
> +	.ops = &vfio_pci_liveupdate_file_ops,
> +	.compatible = VFIO_PCI_LUO_FH_COMPATIBLE,
> +};
> +
> +int __init vfio_pci_liveupdate_init(void)
> +{
> +	if (!liveupdate_enabled())
> +		return 0;
813 int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
814 {
815         struct liveupdate_file_handler *fh_iter;
816         int err;
817
818         if (!liveupdate_enabled())

819                 return -EOPNOTSUPP;

In the function liveupdate_register_file_handler, liveupdate_enabled is also checked.
as such, it is not necessary to check here?

+
+	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
+}
+
+void vfio_pci_liveupdate_cleanup(void)
+{
+	if (!liveupdate_enabled())
+		return;
+


ditto

Zhu Yanjun

> +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> +}
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 27ac280f00b9..68966ec64e51 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -133,4 +133,18 @@ static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
>   }
>   #endif
>   
> +#ifdef CONFIG_LIVEUPDATE
> +int __init vfio_pci_liveupdate_init(void);
> +void vfio_pci_liveupdate_cleanup(void);
> +#else
> +static inline int vfio_pci_liveupdate_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline void vfio_pci_liveupdate_cleanup(void)
> +{
> +}
> +#endif /* CONFIG_LIVEUPDATE */
> +
>   #endif
> diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
> new file mode 100644
> index 000000000000..37a845eed972
> --- /dev/null
> +++ b/include/linux/kho/abi/vfio_pci.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Vipin Sharma <vipinsh@google.com>
> + * David Matlack <dmatlack@google.com>
> + */
> +
> +#ifndef _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
> +#define _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H
> +
> +/**
> + * DOC: VFIO PCI Live Update ABI
> + *
> + * This header defines the ABI for preserving the state of a VFIO PCI device
> + * files across a kexec reboot using LUO.
> + *
> + * Device metadata is serialized into memory which is then handed to the next
> + * kernel via KHO.
> + *
> + * This interface is a contract. Any modification to any of the serialization
> + * structs defined here constitutes a breaking change. Such changes require
> + * incrementing the version number in the VFIO_PCI_LUO_FH_COMPATIBLE string.
> + */
> +
> +#define VFIO_PCI_LUO_FH_COMPATIBLE "vfio-pci-v1"
> +
> +#endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
