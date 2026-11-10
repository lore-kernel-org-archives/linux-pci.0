Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794319991;
	b=mH3w216FmWGsW7fKfyQo+ocHOeovYoWc203ii++lMwW2/dFlPI9d47VVFa+nvMm2BKV3
	 w5P6E08Q/Ml6oezLG1Dcp5jQLu4tXikDQfTlZReplI2Q2WfliTVppWT6MaiT9lU8EfjwM
	 2iCPl/8aJkaPQn++tAAdEo21XWxHzsXRtnfsRwes1WhqaNXU9QYJ1+mmcWHa/jBh76Z03
	 Hz3ZoXG69/7AWb3NRMnbSH+NO0FFcbxCu/gIC91xCYY5hyQubh0cAKuCIOb6a6DEJbg6X
	 ttd9SGpzCCUqfElW2KmOrB5cIcDxKf/6ynkwG3n3TsCidyTEGkGuhuFa1Zywgv5uZeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319991;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=lWrkBheSZH3Fu20kxB5DUkSXr8Oyps+1pr4WaRyMMm0=;
	b=QtPUp3H10nyQ67wsuwusU8krYOIfRGrZXhT+LB5kiB89CrafNDg4o7US1UbXSW3xxkuy
	 9yJJxSytgYYD8sg+jht9b5Vhim/HnqSJMPdtOHC8IiWLsPkvC9blbTLX3uOeiFcLCkE6a
	 Rms91VTuET7FwF5vT/bttAQjSUn2HwwbmCSajkkcailjOJjcH4lssfpWcgtVnTniiiX4E
	 akB6ZKffaNdw6IP02ZHgc/SupZKILBc7YYryNopt7VZaZ1h82r4xmdvUbgclk96oOG7U1
	 pLDlV6oZHIj1+cGPo5vuOViKin5P6/+mQ6OnH28zqzS8ZdPYgGHj4FCwqS+yMlNa3KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=ZXYl5kNL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83D606A31C;
	Tue, 10 Nov 2026 14:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B83D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=ZXYl5kNL
ARC-Seal: i=1; a=rsa-sha256; t=1794319952; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bVb9nYbb08BdFx+AXUqcwIuMjuRUzn7SZDsPNw6NjA8rCQKZ74IUCtAIKDu8JJyUp2hDVL5CGAywv7licZQ7qZeSqy9YJpiMK6xTmbFSk4//Q8yztQLLF3zAtdIVt9+TftU0sY0k86EgZIVj3U93ngk3g0Ew86Fuf/XBr0bX0a8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794319952; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lWrkBheSZH3Fu20kxB5DUkSXr8Oyps+1pr4WaRyMMm0=; 
	b=kN4vv8cGR/Ri28tbIjbkVVmON49aCBBE2ctgjQxzMooxRcQe8HipNV7Qe2ls3/0utKA/TzHfHC0uBKjBQBtMA8D9ZBTdi2Sv/QDKceQdw5nFQ3hqpUiV4NmS3pYSnppp7Dy061r+bw+pXWcmkvjOO4A/rNyF034vY0VEHoXWMDU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=ZXYl5kNLO2IP/fFrkaUrwDt5hDrk5rg5F/pZ92dOiH4sJiQEWx+NxI9OqOcPTsHmYYiXAD9zwBGNH0hEIQIxgblnYtDiSkxiXo8NbavvbLvjhcR5bzwK5JysLpjbecnfD8to4H7wPU50tDdHvQikAFbGL3QNb58baKazJ89W4Y4=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=lWrkBheSZH3Fu20kxB5DUkSXr8Oyps+1pr4WaRyMMm0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794319950277905.1757118011263;
	Tue, 10 Nov 2026 06:12:30 -0800 (PST)
Message-ID: <e8084759-ce40-4a74-b47f-cf62080be7d5@zohomail.com>
Date: Tue, 10 Nov 2026 22:12:16 +0800
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
Subject: Re: [PATCH v17 11/19] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-12-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261105185917.2667656-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112270252696cb9be86ae055113940000d4400ba7e81734e969f0f4c1c52eb53623a04559fbe8ac6786:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/6 02:59, Srirangan Madhavan 写道:
> Cache HDM state in pci_dev->hdm after BAR resource setup and before driver
> binding, so reset can restore it without a bound CXL driver.
>
> Limit caching to devices that advertise CXL.cache, CXL.mem, CXL Reset,
> and Reset Memory Clear. Save their HDM register location, decoder
> settings, and Device DVSEC state.
>
> Validate capability reads and decoder counts, and restore PCI_COMMAND
> after temporary MMIO access, reporting restoration failures. Publish the
> cache under the PCI device lock and protect later updates with the DPA
> lock.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
>
> ---
> Changes in v17:
> - Publish the cache under the PCI device lock without taking
>    cxl_rwsem.dpa, and drop the cxl_hdm_cache_present() and
>    cxl_hdm_cache_publish() helpers (Li Ming)
>    https://lore.kernel.org/linux-cxl/d581f2a0-dd9e-4d0a-bd19-639c1bd9b832@zohomail.com/
> - Reject an all-ones DVSEC Control read in cxl_set_mem_enable() before
>    it is written back or cached (Sashiko)
>    https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=11
> - Explain why cxl_set_mem_enable() refreshes the cached DVSEC Control
>    when MEM_ENABLE already matches (Richard)
>    https://lore.kernel.org/linux-cxl/auRQN6a3QVtqjd5a@MWDK4CY14F/
>
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b12baa1105f33cc1a10f9c9c0c6376194397d9f3
> ---
>   MAINTAINERS                   |   1 +
>   drivers/cxl/core/hdm_regs.c   |  96 +++++++++++++++
>   drivers/cxl/core/hdm_state.c  |  37 +++++-
>   drivers/cxl/core/pci.c        |  29 +++--
>   drivers/pci/Makefile          |   1 +
>   drivers/pci/bus.c             |   1 +
>   drivers/pci/cxl.c             | 225 ++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.h             |   8 ++
>   drivers/pci/probe.c           |   1 +
>   include/cxl/hdm.h             |   9 ++
>   include/uapi/linux/pci_regs.h |   2 +
>   11 files changed, 399 insertions(+), 11 deletions(-)
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
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> index cc5d77c4abf5..c92dbb017162 100644
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
> @@ -190,3 +191,98 @@ int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
>   	return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");
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
> +	u64 lo, hi;
> +	u32 ctrl;
> +	int rc;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	rc = cxl_hdm_read_decoder(&settings->config, hdm, id, ctrl);
> +	if (rc) {
> +		dev_err(dev,
> +			"CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +
> +	if (!(settings->config.flags & CXL_DECODER_F_ENABLE)) {
> +		*settings = (struct cxl_endpoint_decoder_settings) {
> +			.config.id = id,
> +		};
> +	} else {
> +		lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +		hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +		settings->skip = (hi << 32) | lo;
> +	}
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
> +						   hdm, i);
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
> index d4c2be1ef833..9def4a7439c9 100644
> --- a/drivers/cxl/core/hdm_state.c
> +++ b/drivers/cxl/core/hdm_state.c
> @@ -1,21 +1,37 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +#include <linux/cleanup.h>
>   #include <linux/export.h>
>   #include <linux/io.h>
>   #include <linux/pci.h>
>   #include <linux/rwsem.h>
> +#include <linux/slab.h>
>   
>   #include <cxl/hdm.h>
> -
>   #include "cxl.h"
>   #include "core.h"
>   
> +/*
> + * CXL state that must stay available while no CXL driver is bound: the CXL
> + * locks and the per-device HDM cache filled during PCI enumeration.
> + */
>   struct cxl_rwsem cxl_rwsem = {
>   	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
>   	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
>   };
>   EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
>   
> +void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
> +{
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
Is this lock needed? “pdev->hdm->dvsec_ctrl” could be modified 
concurrently? Seems like it is called during the endpoint port probing.
> +	if (!pdev->hdm)
> +		return;
> +
> +	pdev->hdm->dvsec_ctrl = ctrl;
> +	pdev->hdm->dvsec_ctrl_valid = true;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_set_dvsec_ctrl, "cxl_core");
> +
>   void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
>   				   struct cxl_endpoint_decoder *cxled)
>   {
> @@ -70,3 +86,22 @@ int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count)
>   	return 0;
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_cache_check_decoder_count, "cxl_core");
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
I don't think we need this lock either. And we can free the “*slot” 
directly. Because cxl_hdm_cache_release() is called in 
pci_release_dev(). pci_release_dev() runs once the pci_dev refcount 
drops to 0, so the pci_dev is being released, no driver can access this 
pci_dev at this point.
> +}
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5272013548c7..ea5327cd627f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -209,22 +209,31 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>   	int d = cxlds->cxl_dvsec;
>   	u16 ctrl;
> -	int rc;
> +	int rc, ret = 1;
>   
>   	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
>   	if (rc)
>   		return pcibios_err_to_errno(rc);
> +	/* An all-ones read must not be written back or cached. */
> +	if (PCI_POSSIBLE_ERROR(ctrl))
> +		return -ENODEV;
>   
> -	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
> -		return 1;
> -	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
> -	ctrl |= val;
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) != val) {
> +		ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
> +		ctrl |= val;
>   
> -	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
> -	if (rc)
> -		return pcibios_err_to_errno(rc);
> +		rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		ret = 0;
> +	}
>   
> -	return 0;
> +	/*
> +	 * Refresh the PCI-core cache from the live register even when
> +	 * MEM_ENABLE already matched: a reset restores the cached value.
> +	 */
> +	cxl_hdm_cache_set_dvsec_ctrl(pdev, ctrl);
> +	return ret;
>   }
>   
>   static void clear_mem_enable(void *cxlds)
> @@ -314,7 +323,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>   	 * capable, there is no point in continuing to enable CXL.mem.
>   	 */
>   	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
> -	if (!hdm_count || hdm_count > 2)
> +	if (!cxl_dvsec_hdm_count_valid(hdm_count))
>   		return -EINVAL;
>   
>   	/*
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
> index 000000000000..a0d20f4210a5
> --- /dev/null
> +++ b/drivers/pci/cxl.c
> @@ -0,0 +1,225 @@
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
> +						      hdm_map->size);
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
> +	struct cxl_hdm_info *info;
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
> +	info = kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
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
How about like this?

+static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
+						    struct cxl_register_map *map,
+						    int dvsec)
+{
+	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
+	struct cxl_hdm_info *info = NULL;
+	resource_size_t hdm_offset;
+	void __iomem *hdm;
+	int decoder_count;
+	u16 dvsec_ctrl;
+	int rc;
+
+	hdm = cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
+	if (IS_ERR(hdm))
+		return ERR_CAST(hdm);
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
+				  &dvsec_ctrl);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		goto out;
+	}
+
+	info = kzalloc_flex(*info, settings, decoder_count, GFP_KERNEL);
+	if (!info) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	info->decoder_count = decoder_count;
+	info->hdm_bar = map->bar;
+	info->hdm_offset = hdm_offset;
+	info->hdm_size = hdm_map->size;
+	info->dvsec = dvsec;
+	info->dvsec_ctrl = dvsec_ctrl;
+	info->dvsec_ctrl_valid = true;
+
+	rc = cxl_hdm_read_state(&pdev->dev, hdm, info);
+out:
+	if (rc)
+		kfree(info);
+	iounmap(hdm);
+	return rc ? ERR_PTR(rc) : info;
+}


> +
> +static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						  struct cxl_register_map *map,
> +						  int dvsec)
> +{
> +	struct cxl_hdm_info *info;
> +	u16 command;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	if (!(command & PCI_COMMAND_MEMORY)) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return ERR_PTR(pcibios_err_to_errno(rc));
> +	}
> +
> +	info = __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +	if (!(command & PCI_COMMAND_MEMORY)) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		if (rc)
> +			pci_err(pdev,
> +				"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +				pcibios_err_to_errno(rc));
> +	}
> +	return info;
> +}
> +
> +static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { };
> +	struct cxl_hdm_info *read_info;
> +	u16 dvsec, cap;
> +	int rc;
> +
> +	guard(pci_dev)(pdev);
> +
> +	/* Avoid duplicate MMIO reads when the cache is already present. */
> +	if (pdev->hdm)
> +		return 0;
> +
> +	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	if (rc == -ENOTTY)
> +		return 0;
> +	if (rc)
> +		return rc;
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE) ||
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
> +	read_info = cxl_pci_hdm_read_info(pdev, &map, dvsec);
> +	if (IS_ERR(read_info))
> +		return PTR_ERR(read_info);
> +
> +	/*
> +	 * The PCI device lock held since the cache check excludes other
> +	 * initializers. CXL drivers bind only after enumeration, so no cache
> +	 * mutator can run yet and cxl_rwsem.dpa is not needed to publish.
> +	 */
I think this comment should be moved to above "guard(pci_dev)(pdev);".
> +	pdev->hdm = read_info;
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
> diff --git a/include/cxl/hdm.h b/include/cxl/hdm.h
> index 06e9aa4479c2..0604dcc439c9 100644
> --- a/include/cxl/hdm.h
> +++ b/include/cxl/hdm.h
> @@ -26,6 +26,7 @@ struct cxl_endpoint_decoder_settings {
>    * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
>    * @hdm_size: size of the HDM decoder register block
>    * @global_ctrl: HDM decoder global control register
> + * @dvsec: config space offset of the CXL Device DVSEC
>    * @dvsec_ctrl: CXL DVSEC control register
>    * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
>    * @settings: per-endpoint-decoder programming state
> @@ -39,13 +40,21 @@ struct cxl_hdm_info {
>   	resource_size_t hdm_offset;
>   	resource_size_t hdm_size;
>   	u32 global_ctrl;
> +	u16 dvsec;
>   	u16 dvsec_ctrl;
>   	bool dvsec_ctrl_valid;
>   	struct cxl_endpoint_decoder_settings settings[] __counted_by(decoder_count);
>   };
> +struct device;
>   
> +int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
> +				 resource_size_t size);
> +int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
> +		       struct cxl_hdm_info *info);
> +void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl);
>   void cxl_hdm_cache_refresh_decoder(struct pci_dev *pdev, void __iomem *hdm,
>   				   struct cxl_endpoint_decoder *cxled);
>   int cxl_hdm_cache_check_decoder_count(struct pci_dev *pdev, int count);
> +void cxl_hdm_cache_release(struct cxl_hdm_info **slot);
>   
>   #endif /* __CXL_HDM_H__ */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index facaa324bd86..ca3e77b72d87 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,6 +1352,8 @@
>   #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>   #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>   #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>   #define  PCI_DVSEC_CXL_CTRL				0xC
>   #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
>   #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
