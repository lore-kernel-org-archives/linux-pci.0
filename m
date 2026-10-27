Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793088442;
	b=Odk9JSxFISC8ANfq8pe6PfAsnzIVVJGEIQxv2vsWKKYqn04tv+AaY3BAGQEbsJSgFTYr
	 XFkl3zsaUD8LI+goAFj46ZS1EjbmbyojTS+/ERIiLnl64iGW4CBFKNEBqxRqPSqknNfCs
	 tW5Eptyh+W3dR2Dct1SRDbnrvN3narw42x56RijG9oJ5N2KsNopur4fvaE5QKhD1/hMKD
	 E0nenC+ftMh9YyGpfFq3tIe0YJjhOtI26A0n70dS6xO4m078VLGyg3qx/WkNBv3rfzJcB
	 RG/N8W2NfQBA5mHFZYRzvaBniRpnlienP5mzX+lzFAX99sRk9B482g9ZitvpMfuHCSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088442;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=54Dkxq3MU/drcbR6b4/3kpMIW1E/Hv+kD/+CkARUSyk=;
	b=R2Ggfvf/7CzNRV8q1cixWlBALfqxBkYoPu6Mp9zfFUyfMvuoP+6/eGI4nTyZfveNK1cb
	 zOvWLAKypKSYVMgWS1Scs9OCgT4d2u2ZLQGUrZzXywuJoddPnUxuAT8VzsMjUDYhHmik8
	 BF2815/+EJhQzjMEp1EAN/IqafzNZV3BIfBjZVoTM920UDOETE0B/oAv7V3LU49OJlx66
	 czlBV2qlOJxOZMURL5a8QXZJE4MlG8OZcrZcWrvof+YKzyYP0DCMybiAtjFKlkIHh9VOS
	 YlFeXM6o0/3ejx7JwGcFTQBiwDOr31l8G7Npq0LWIz3eOwCmTNM3+FYxDeJB9cM5kTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=VyR1dH2w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD4606A31F;
	Tue, 27 Oct 2026 08:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69AD4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=VyR1dH2w
ARC-Seal: i=1; a=rsa-sha256; t=1793088429; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S4m0FPdLnNaisuczUwmZtq3JlRtjgbZN44Z/xDRT3x8rctdnHRQ9mc6lFjMvXdG9cfzjHlLvlwtHB0Bkndg/vrhGxUPyWu6vA8SdtubZDDa34IMe7N5ikDT/5bFnjT6HIE1QeQyWnjugZDnEfnL4mMY5DCuo7aotjlX7xI2iiss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793088429; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=54Dkxq3MU/drcbR6b4/3kpMIW1E/Hv+kD/+CkARUSyk=; 
	b=UmAhJ7LVY2GlmhlAEvqfEDQRZB59mM54896tfUYf5YuwCoHqpcoW63/n4k3t+jsTYENe34Xkhc5FV4xbtEnaSdtV0LRZhscSrd1cXFlv8GKsEsxYe+DRLvBrWlovDtVE7h0f0nYebWxqqzA8VfxUNuR5Q9o2EEkZhfbXvMbsTus=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793088429;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=54Dkxq3MU/drcbR6b4/3kpMIW1E/Hv+kD/+CkARUSyk=;
	b=VyR1dH2wQ0IeJ7Ru/9T1KG7Dk7SJGIc6+PKGQ60U2+BdSEwN155qwHN4eRNNQi3G
	e2h5I/1NX/1lgKDYZONPBrIKOa/msHEVnTcK7Yzp2Je34ODqIoEfdWdhcKLGjFayCAX
	kukqY0wzE30+1I4NDeVi2k0yquoqVxlgq7orYilE=
Received: by smtp.zohomail.com with SMTPS id 1793088427428473.4587512642951;
	Tue, 27 Oct 2026 01:07:07 -0700 (PDT)
Message-ID: <44598fd3-916b-4bc0-bc73-3b97eda1e87a@zohomail.com>
Date: Tue, 27 Oct 2026 16:07:01 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 09/16] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-10-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261011021422.3428136-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227e408d5d1aac3d578800f33a60000a449b338d4fb8f1a79acdaddd835787081ba4acebc3637df56:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/11 10:14, Srirangan Madhavan 写道:
> Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
> binding, so reset can restore it without a bound CXL driver.
>
> Save the HDM register location, decoder settings, and Device DVSEC state.
> Validate capability reads and decoder counts, and restore PCI_COMMAND
> after temporary MMIO access, reporting restoration failures.
>
> Keep PCI discovery separate from shared HDM helpers. Move cxl_rwsem into
> built-in state code and protect cache publication with its DPA lock, so
> the cache remains usable when cxl_core is modular.
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b12baa1105f33cc1a10f9c9c0c6376194397d9f3
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> ---
>   MAINTAINERS                  |   1 +
>   drivers/cxl/core/Makefile    |   3 +-
>   drivers/cxl/core/hdm.c       |   5 -
>   drivers/cxl/core/hdm_regs.c  |  99 ++++++++++++++++
>   drivers/cxl/core/hdm_state.c |  64 ++++++++++
>   drivers/cxl/core/pci.c       |  17 ++-
>   drivers/cxl/core/regs.c      |   9 ++
>   drivers/cxl/cxl.h            |   3 -
>   drivers/pci/Makefile         |   1 +
>   drivers/pci/bus.c            |   1 +
>   drivers/pci/cxl.c            | 223 +++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.h            |   8 ++
>   drivers/pci/probe.c          |   1 +
>   include/cxl/cxl.h            |   6 +
>   include/cxl/hdm.h            |  12 ++
>   include/cxl/pci.h            |  13 ++
>   tools/testing/cxl/Kbuild     |   1 -
>   17 files changed, 454 insertions(+), 13 deletions(-)
>   create mode 100644 drivers/cxl/core/hdm_state.c
>   create mode 100644 drivers/pci/cxl.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2414447892c..b874340b0265 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6572,6 +6572,7 @@ S:	Maintained
>   F:	Documentation/driver-api/cxl
>   F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
>   F:	drivers/cxl/
> +F:	drivers/pci/cxl.c
>   F:	include/cxl/
>   F:	include/uapi/linux/cxl_mem.h
>   F:	tools/testing/cxl/
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 6703c1729396..9a77e68d44ce 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o
> +obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o regs.o
>   obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>   
>   ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>   
>   cxl_core-y := port.o
>   cxl_core-y += pmem.o
> -cxl_core-y += regs.o
>   cxl_core-y += memdev.o
>   cxl_core-y += mbox.o
>   cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index b57257efbf4e..a0d8f6a66810 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -17,11 +17,6 @@
>    * for enumerating these registers and capabilities.
>    */
>   
> -struct cxl_rwsem cxl_rwsem = {
> -	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> -	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> -};
> -
>   static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
>   {
>   	int rc;
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> index b6ee4becde8d..f0b360867655 100644
> --- a/drivers/cxl/core/hdm_regs.c
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -2,6 +2,7 @@
>   /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>   #include <linux/delay.h>
>   #include <linux/bug.h>
> +#include <linux/device.h>
>   #include <linux/errno.h>
>   #include <linux/export.h>
>   #include <linux/kernel.h>
> @@ -174,3 +175,101 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
>   	return 0;
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
> +
> +/**
> + * cxl_hdm_decoder_count_mapped() - read the decoder count of a mapped block
> + * @dev: device for error reporting
> + * @hdm: mapped HDM decoder capability
> + * @size: size of the mapping
> + *
> + * Return: the decoder count, or a negative errno if the count is reserved or
> + * the mapping cannot hold every decoder.
> + */
> +int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
> +				 resource_size_t size)
> +{
> +	int count;
> +
> +	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (count < 0)
> +		return count;
> +
> +	/* The last decoder's target-list high register must fit in the mapping. */
> +	if (CXL_HDM_DECODER0_TL_HIGH(count - 1) + sizeof(u32) > size) {
> +		dev_err(dev, "CXL HDM decoder count exceeds mapped register block\n");
> +		return -ENXIO;
> +	}
> +
> +	return count;
> +}
> +
> +/* Read one endpoint decoder; a disabled decoder keeps only its id. */
> +static int cxl_hdm_read_decoder_settings(struct device *dev,
> +					 struct cxl_endpoint_decoder_settings *settings,
> +					 void __iomem *hdm, int id)
> +{
> +	u64 base, size;
> +	u32 ctrl;
> +	int rc;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	base = ((u64)readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id)) << 32) |
> +	       readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	size = ((u64)readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id)) << 32) |
> +	       readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	rc = cxl_hdm_unpack_decoder(&settings->config, id, ctrl, base, size);
> +	if (rc) {
> +		dev_err(dev,
> +			"CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +
> +	if (!(settings->config.flags & CXL_DECODER_F_ENABLE))
> +		*settings = (struct cxl_endpoint_decoder_settings) {
> +			.config.id = id,
> +		};
> +	else
> +		settings->skip =
> +			((u64)readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(id)) << 32) |
> +			readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_hdm_read_state() - read endpoint HDM decoder state
> + * @dev: device for error messages
> + * @hdm: mapped HDM decoder capability
> + * @info: state to fill; @info->decoder_count must be set
> + *
> + * Return: 0 on success, or a negative errno if a decoder holds an invalid
> + * configuration or the decoder count changed while reading.
> + */
> +int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
> +		       struct cxl_hdm_info *info)
> +{
> +	int count;
> +	int rc;
> +
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_hdm_read_decoder_settings(dev, &info->settings[i],
> +						    hdm, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/*
> +	 * A changed decoder count means the snapshot no longer describes the
> +	 * complete hardware state. Reject it rather than publish a partial cache.
> +	 */
> +	count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (count != info->decoder_count) {
> +		dev_err(dev, "CXL HDM decoder count changed from %d to %d\n",
> +			info->decoder_count, count);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
> new file mode 100644
> index 000000000000..9a31f5996c74
> --- /dev/null
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/cleanup.h>
> +#include <linux/export.h>
> +#include <linux/slab.h>
> +
> +#include <cxl/hdm.h>
> +#include "cxl.h"
> +#include "core.h"
> +
> +/*
> + * CXL state that must stay available while no CXL driver is bound: the CXL
> + * locks and the per-device HDM cache filled during PCI enumeration.
> + */
> +struct cxl_rwsem cxl_rwsem = {
> +	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
> +	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
> +};
> +EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
> +
> +/* A published cache is usable only if its HDM register block was mapped. */
> +bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot)
> +{
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	return *slot && (*slot)->hdm_size;
> +}
> +
> +/**
> + * cxl_hdm_cache_publish() - publish HDM state read during enumeration
> + * @slot: cache pointer owned by the device, for example &pci_dev->hdm
> + * @info: state to publish
> + *
> + * Ownership of @info passes to @slot, or @info is freed if another caller
> + * published first.
> + */
> +void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
> +			   struct cxl_hdm_info *info)
> +{
> +	struct cxl_hdm_info *new __free(kfree) = info;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	/* Another initializer may have published while we read MMIO. */
> +	if (!*slot)
> +		*slot = no_free_ptr(new);
> +}
> +
> +/**
> + * cxl_hdm_cache_release() - unpublish and free cached HDM state
> + * @slot: cache pointer owned by the device
> + *
> + * Take the DPA write lock to exclude readers while clearing @slot, then
> + * free the unpublished cache after releasing the lock.
> + */
> +void cxl_hdm_cache_release(struct cxl_hdm_info **slot)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		info = *slot;
> +		/* Unpublish before freeing so readers cannot see stale state. */
> +		*slot = NULL;
> +	}
> +	kfree(info);
> +}
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 2acddb472103..88d25d0776b4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -250,6 +250,16 @@ int cxl_hdm_check_decoder_count(struct cxl_hdm *cxlhdm)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_hdm_check_decoder_count, "CXL");
>   
> +static void cxl_hdm_cache_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
> +{
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (!pdev->hdm)
> +		return;
> +
> +	pdev->hdm->dvsec_ctrl = ctrl;
> +	pdev->hdm->dvsec_ctrl_valid = true;
> +}
> +
>   static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>   {
>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -261,8 +271,10 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>   	if (rc)
>   		return pcibios_err_to_errno(rc);
>   
> -	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val) {
> +		cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
>   		return 1;
> +	}
>   	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
>   	ctrl |= val;
>   
> @@ -270,6 +282,7 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>   	if (rc)
>   		return pcibios_err_to_errno(rc);
>   
> +	cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
>   	return 0;
>   }
>   
> @@ -360,7 +373,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>   	 * capable, there is no point in continuing to enable CXL.mem.
>   	 */
>   	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
> -	if (!hdm_count || hdm_count > 2)
> +	if (!cxl_dvsec_hdm_count_valid(hdm_count))
>   		return -EINVAL;
>   
>   	/*
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7..ba1f942d20e1 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>   
>   	return ret_val;
>   }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>   
>   int cxl_map_component_regs(const struct cxl_register_map *map,
>   			   struct cxl_component_regs *regs,
> @@ -285,6 +286,8 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>   	}
>   
>   	map->reg_type = reg_type;
> +	map->bar = bar;
> +	map->bar_offset = offset;
>   	map->resource = pci_resource_start(pdev, bar) + offset;
>   	map->max_size = pci_resource_len(pdev, bar) - offset;
>   	return true;
> @@ -309,6 +312,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>   	*map = (struct cxl_register_map) {
>   		.host = &pdev->dev,
>   		.resource = CXL_RESOURCE_NONE,
> +		.bar = -1,
>   	};
>   
>   	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> @@ -339,6 +343,8 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>   	}
>   
>   	map->resource = CXL_RESOURCE_NONE;
> +	map->bar = -1;
> +	map->bar_offset = 0;
>   	if (index == CXL_INSTANCES_COUNT)
>   		return instance;
>   
> @@ -518,6 +524,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>   
>   	return offset;
>   }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>   
>   static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>   {
> @@ -634,6 +641,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>   
>   	return component_reg_phys;
>   }
> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>   
>   resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>   					   struct cxl_dport *dport)
> @@ -642,3 +650,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>   		return CXL_RESOURCE_NONE;
>   	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>   }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 688350c7c5fb..ad4e80be2bd7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -239,9 +239,6 @@ enum cxl_regloc_type;
>   int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>   int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>   			       struct cxl_register_map *map, unsigned int index);
> -int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
>   struct cxl_dport;
>   int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>   
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 41ebc3b9a518..7a5d9f7297e9 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_CXL_RESET)		+= cxl.o
>   obj-$(CONFIG_PCI_IDE)		+= ide.o
>   obj-$(CONFIG_PCI_TSM)		+= tsm.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3..aad567fb7c56 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -359,6 +359,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>   
>   	/* Save config space for error recoverability */
>   	pci_save_state(dev);
> +	pci_cxl_hdm_cache_init(dev);
>   
>   	/*
>   	 * Enable runtime PM, which potentially allows the device to
> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> new file mode 100644
> index 000000000000..471b57391593
> --- /dev/null
> +++ b/drivers/pci/cxl.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +/*
> + * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
> + * memory device at enumeration, so it can be restored after a reset without
> + * a CXL driver. HDM register formats and programming live in drivers/cxl.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxl/hdm.h>
> +#include <cxl/pci.h>
> +
> +#include "pci.h"
> +
> +/* Find the CXL Device DVSEC and read its capability register. */
> +static int cxl_pci_device_dvsec(struct pci_dev *pdev, u16 *dvsec, u16 *cap)
> +{
> +	int rc;
> +
> +	*dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					   PCI_DVSEC_CXL_DEVICE);
> +	if (!*dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, *dvsec + PCI_DVSEC_CXL_CAP, cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (PCI_POSSIBLE_ERROR(*cap))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static bool cxl_pci_bar_assigned(struct pci_dev *pdev, int bar)
> +{
> +	struct resource *res = &pdev->resource[bar];
> +
> +	return pci_resource_len(pdev, bar) &&
> +	       !(res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) &&
> +	       resource_type(res) == IORESOURCE_MEM && res->start && res->end;
> +}
> +
> +static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
> +					  struct cxl_register_map *map,
> +					  resource_size_t *hdm_offset,
> +					  int *decoder_count)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	/* cxl_setup_regs() populates hdm_map, including its valid bit. */
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return ERR_PTR(rc);
> +	if (!hdm_map->valid)
> +		return ERR_PTR(-ENODEV);
> +	if (hdm_map->offset > map->max_size ||
> +	    hdm_map->size > map->max_size - hdm_map->offset)
> +		return ERR_PTR(-ENXIO);
> +	if (check_add_overflow(map->bar_offset,
> +			       (resource_size_t)hdm_map->offset, hdm_offset))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
> +	if (!hdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*decoder_count = cxl_hdm_decoder_count_mapped(&pdev->dev, hdm,
> +					      hdm_map->size);
> +	if (*decoder_count < 0) {
> +		iounmap(hdm);
> +		return ERR_PTR(*decoder_count);
> +	}
> +
> +	return hdm;
> +}
> +
> +static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						    struct cxl_register_map *map,
> +						    int dvsec)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	resource_size_t hdm_offset;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	u16 dvsec_ctrl;
> +	int rc;
> +
> +	hdm = cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
> +	if (IS_ERR(hdm))
> +		return ERR_CAST(hdm);
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				  &dvsec_ctrl);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		goto out_unmap;
> +	}
> +
> +	struct cxl_hdm_info *info =
> +		kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
> +	if (!info) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->hdm_bar = map->bar;
> +	info->hdm_offset = hdm_offset;
> +	info->hdm_size = hdm_map->size;
> +	info->dvsec = dvsec;
> +	info->dvsec_ctrl = dvsec_ctrl;
> +	info->dvsec_ctrl_valid = true;
> +
> +	rc = cxl_hdm_read_state(&pdev->dev, hdm, info);
> +	if (rc)
> +		goto out_free;
> +
> +	iounmap(hdm);
> +	return info;
> +
> +out_free:
> +	kfree(info);
> +out_unmap:
> +	iounmap(hdm);
> +	return ERR_PTR(rc);
> +}
> +
> +static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						  struct cxl_register_map *map,
> +						  int dvsec)
> +{
> +	struct cxl_hdm_info *info;
> +	u16 command;
> +	int rc;
> +
> +	guard(pci_dev)(pdev);
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	if (command & PCI_COMMAND_MEMORY)
> +		return __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +
> +	rc = pci_write_config_word(pdev, PCI_COMMAND,
> +				   command | PCI_COMMAND_MEMORY);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	info = __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (!rc)
> +		return info;
> +
> +	pci_err(pdev,
> +		"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +		pcibios_err_to_errno(rc));
> +	if (IS_ERR(info))
> +		return info;
> +
> +	kfree(info);
> +	return ERR_PTR(pcibios_err_to_errno(rc));

If restoring PCI_COMMAND fails but the most important 
part(__cxl_pci_hdm_read_info()) has been done successfully. Do we really 
need to release the info then return an error? I think just a warning is 
enough in the case if the info can be used. So I think the 
implementation is like:

{

......

info = __cxl_pci_hdm_read_info(pdev, map, dvsec);

rc = pci_write_config_word(pdev, PCI_COMMAND, command);

if (rc)

     pci_err(pdev, "Failed to restore PCI_COMMAND after CXL HDM cache 
init: %d\n", pcibios_err_to_errno(rc));


return info;

}


Ming

> +}
> +
> +static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { };
> +	u16 dvsec, cap;
> +	int rc;
> +
> +	/* Avoid duplicate MMIO reads when the cache is already present. */
> +	if (cxl_hdm_cache_present(&pdev->hdm))
> +		return 0;
> +
> +	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	if (rc == -ENOTTY)
> +		return 0;
> +	if (rc)
> +		return rc;
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !cxl_dvsec_hdm_count_valid(FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap)))
> +		return 0;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS ||
> +	    !cxl_pci_bar_assigned(pdev, map.bar))
> +		return -ENODEV;
> +
> +	struct cxl_hdm_info *read_info =
> +		cxl_pci_hdm_read_info(pdev, &map, dvsec);
> +	if (IS_ERR(read_info))
> +		return PTR_ERR(read_info);
> +
> +	/* Another initializer may have published while we read MMIO. */
> +	cxl_hdm_cache_publish(&pdev->hdm, read_info);
> +
> +	return 0;
> +}
> +
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_cache_init(pdev);
> +	if (rc)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}
> +
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
> +{
> +	cxl_hdm_cache_release(&pdev->hdm);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..9e218f236e66 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -730,6 +730,14 @@ static inline void pci_doe_destroy(struct pci_dev *pdev) { }
>   static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>   #endif
>   
> +#ifdef CONFIG_CXL_RESET
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
> +#else
> +static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
> +static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
> +#endif
> +
>   #ifdef CONFIG_PCI_NPEM
>   void pci_npem_create(struct pci_dev *dev);
>   void pci_npem_remove(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5af..cb52357344ed 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2484,6 +2484,7 @@ static void pci_release_dev(struct device *dev)
>   	struct pci_dev *pci_dev;
>   
>   	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_cache_release(pci_dev);
>   	pci_release_capabilities(pci_dev);
>   	pci_release_of_node(pci_dev);
>   	pcibios_release_device(pci_dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index b29374b34cfa..3e70f74685b6 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -27,6 +27,7 @@ enum cxl_devtype {
>   
>   struct cxl_region;
>   struct cxl_hdm_info;
> +struct pci_dev;
>   
>   enum cxl_decoder_type {
>   	CXL_DECODER_DEVMEM = 2,
> @@ -149,6 +150,8 @@ struct cxl_pmu_reg_map {
>    * @base: virtual base of the register-block-BAR + @block_offset
>    * @resource: physical resource base of the register block
>    * @max_size: maximum mapping size to perform register search
> + * @bar: PCI BAR containing the register block
> + * @bar_offset: register block offset relative to @bar
>    * @reg_type: see enum cxl_regloc_type
>    * @component_map: cxl_reg_map for component registers
>    * @device_map: cxl_reg_maps for device registers
> @@ -159,6 +162,8 @@ struct cxl_register_map {
>   	void __iomem *base;
>   	resource_size_t resource;
>   	resource_size_t max_size;
> +	int bar;
> +	resource_size_t bar_offset;
>   	u8 reg_type;
>   	union {
>   		struct cxl_component_reg_map component_map;
> @@ -167,6 +172,7 @@ struct cxl_register_map {
>   	};
>   };
>   
> +
>   /**
>    * struct cxl_dpa_perf - DPA performance property entry
>    * @dpa_range: range for DPA address
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index d5e7efd2ffc0..af7cef649446 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -23,6 +23,7 @@ struct cxl_endpoint_decoder_settings {
>    * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
>    * @hdm_size: size of the HDM decoder register block
>    * @global_ctrl: HDM decoder global control register
> + * @dvsec: config space offset of the CXL Device DVSEC
>    * @dvsec_ctrl: CXL DVSEC control register
>    * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
>    * @settings: per-endpoint-decoder programming state
> @@ -36,9 +37,20 @@ struct cxl_hdm_info {
>   	resource_size_t hdm_offset;
>   	resource_size_t hdm_size;
>   	u32 global_ctrl;
> +	u16 dvsec;
>   	u16 dvsec_ctrl;
>   	bool dvsec_ctrl_valid;
>   	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
>   };
> +struct device;
> +
> +int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
> +				 resource_size_t size);
> +int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
> +		       struct cxl_hdm_info *info);
> +bool cxl_hdm_cache_present(struct cxl_hdm_info *const *slot);
> +void cxl_hdm_cache_publish(struct cxl_hdm_info **slot,
> +			   struct cxl_hdm_info *info);
> +void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
>   
>   #endif /* __CXL_HDM_H__ */
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index 3e0000015871..b15d7e415e27 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -4,6 +4,8 @@
>   #ifndef __CXL_CXL_PCI_H__
>   #define __CXL_CXL_PCI_H__
>   
> +#include <linux/types.h>
> +
>   /* Register Block Identifier (RBI) */
>   enum cxl_regloc_type {
>   	CXL_REGLOC_RBI_EMPTY = 0,
> @@ -19,4 +21,15 @@ struct pci_dev;
>   
>   int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>   		       struct cxl_register_map *map);
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		      struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map);
> +/*
> + * CXL r4.0 sec 8.1.3.1: a CXL.mem capable device reports one or two HDM
> + * ranges. 00b is illegal when Mem_Capable is set and 11b is reserved.
> + */
> +static inline bool cxl_dvsec_hdm_count_valid(unsigned int hdm_count)
> +{
> +	return hdm_count == 1 || hdm_count == 2;
> +}
>   #endif
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 2be1df80fcc9..e80500f457a9 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -55,7 +55,6 @@ obj-m += cxl_core.o
>   
>   cxl_core-y := $(CXL_CORE_SRC)/port.o
>   cxl_core-y += $(CXL_CORE_SRC)/pmem.o
> -cxl_core-y += $(CXL_CORE_SRC)/regs.o
>   cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>   cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>   cxl_core-y += $(CXL_CORE_SRC)/pci.o
