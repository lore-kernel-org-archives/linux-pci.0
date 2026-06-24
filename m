Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0529ACC6;
	Wed, 24 Jun 2026 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267347; cv=none; b=XnBRLHCYLSj/jY16LNbtkyGpcCsyTwGIrWLOyQCLYf6l0w6H0gwCTD/dEEQduuejwppqf2BveliTFJVyUUlCMHZc1zWXVYgH1dNKAA5miY9AhGyk0YU8DpPEd87KfHtbagvmh5FlWoTBS104C6BZy6+zUoYT0R5457kiH9l3bKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267347; c=relaxed/simple;
	bh=OOsiLi27i69r5KpAr08Kcxj3VLKGGjXEV+B9WnQGoYc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VS/I/TkH8v/Ogf/r8s7iJWoxR8WOJgzCOQYPdGUaOSZ8t2I8Xm1TIDZxNQiuZxVgFGw2M/hYnhRA+ZsnE049lfYlHlKd9IEY6afWYtfrLSUw/0OQcssTC8CJNdDQPj1qATJjAENEd95zr7PtvFSEZUiwsjR4UCZxDGOWj308MI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY+wXWwg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY+wXWwg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1291F00A3D;
	Wed, 24 Jun 2026 02:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267346;
	bh=/K+8izIiHGXOJTYdgJwxQKC9x0jwf89johjfhHsIYgQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=nY+wXWwgo8mgcTM/qWHOZ3GM/7M/9KA1JqC4qV1uwK3CnLuWy0T5Djf0MUNyXIhHx
	 b/LIg4wIw7eRLPdbs/dI5McSDr1CVd46yzWGU6+dLoC5EFVDx/xZmMqSxxiaBYik0N
	 bSB2y1b3+Dtox50XmIBPb1niP/foe2m2zeZz0/whG3P2r2ut+ZqarF2PeEnnAq6b6y
	 /L+jhHzvTZ+Hb25PjoNei1bP38puw4l1wqQMAK4NHFqDD45A5YoOLwD5UP/wLgDsic
	 R3+f8wuoaA7xEbMuSAfAbOzCQxIKBQCeSj4m1nr7A18Qcyx5NjrQxkBFK1yoNYlGU5
	 4VAYPE5S/F15Q==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 65F85F4007E;
	Tue, 23 Jun 2026 22:15:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Jun 2026 22:15:44 -0400
X-ME-Sender: <xms:0D07ao1aa-qcnM3sp98cTrKq9cA3FVuzITDO2Ax_pn4VMYD12inhjQ>
    <xme:0D07ajgDeR6JOoehKR8aLbRaS_XckrkPTyBsWNIPvObQNOup33JV5x6xokwbyzwa7
    cb_h-QksQc9LmqomNDAEOcNSebAKMeZ35U2C148ehHy6ivvnoXnGw>
X-ME-Received: <xmr:0D07amXyyA4JSGcTkecRc6JxoKyrZvp1PmkTll3ZhxuxBCmGHUY8gqlhpjZkBI6RD1M5wddbQhgm7yjQuuzZFfcrkZ_MGng7rw8>
X-ME-Proxy-Cause: dmFkZTGs2ITfJFp9pYHtuvCGGW8yp1uDp77XvZtuiMUyfWBb+JOdR0DDzFXvYH29OwNH6j
    ekse8CVm5rSZxus+XqC4IScSh7b+PdlBo2Jhmx3gjvg3eKOM7D5I478Bj1KAfLJFMazDUg
    XdaN0ftWVNRzZMe2K/kiT44k7rGiJUyVt7s0xsmMRr3olphjjoRJKNwd7v3XHqSlbcIuBl
    0e9pOapzsO4jxnPBoKEHyas84Sx3szKkJkJ1jGe4yqzUHxpU0MfQU8MYsfs15t92uCozVG
    k2Oz/RMJTvPI8vI1AIPSXy8hquajl7fsSP08KQtQk13fHy8V/XV+GfU4QbQ+olS5T8oyFq
    OabVv2magINDoOIy47Ox7iEgjzBuRQOpvDmjwKR50+KzLRZ3+WJGckaNk6Od0V6vV05joK
    Tm9SUmitzPkIS1/j+Wid1f1R89wSxxJeh9wpxlC1xKpM7YgMVgHVFqIsjV+STBhP2Pjhuc
    KQd/1K8htDnD2jFCKAsBweQnakSJAqR88b7GRMqmX0m/7SVXinTG50X1ktcWNZq7hRDbTX
    pkYEGNsrWCZF8JV42RpyOmA5IY8m046Jx3kmllSbomXa6Azox2bc08OGTybIqIjlbKzlLx
    5O4JxietuyUQovEVgPpuTk2Epv0j5H/VMnLP7tDddo02mtwBusV0Dy97rRwA
X-ME-Proxy: <xmx:0D07avxJqvaFp56SN9Svax-1lx1G8RyTNLERemxHaM6-GfGpjY9Ybw>
    <xmx:0D07au5gAbnbDw3WBK2watE1ZzXvkJpYT_C2yNRA-8CpFpBjkvY6QQ>
    <xmx:0D07apgg3de35_1gKMQdeM9VxUgpTi9wDPExRhmX-0UZGpHhKv1nDw>
    <xmx:0D07ahhWUddNPg4XlHt3RjB3JmlUxN5FrGhnlKhR4xBphbT5YBLjrw>
    <xmx:0D07ahnfLLUaoEbmGJdMUVKQkhkykWpXPfv7-kR-x9hOPOpsQnFMnM4I>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 22:15:43 -0400 (EDT)
Date: Tue, 23 Jun 2026 19:15:42 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a3b3dce9f3e0_3c9f1005e@djbw-dev.notmuch>
In-Reply-To: <20260623032453.3404772-4-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-4-smadhavan@nvidia.com>
Subject: Re: [PATCH v7 03/11] cxl: Cache endpoint decoder settings during PCI
 enumeration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srirangan Madhavan wrote:
> Populate pci_dev->hdm from PCI capability initialization when a CXL.mem
> function already has memory decoding enabled. This gives driver-free reset
> paths an early HDM snapshot without enabling BAR decoding during
> enumeration.
> 
> CXL core later reuses and refreshes the same cache. Move the register
> helpers into the built-in CONFIG_CXL_HDM set so the early cache path is
> available without cxl_core.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile |   3 +-
>  drivers/cxl/core/hdm.c    |  59 +++++++----
>  drivers/cxl/core/reset.c  | 202 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c       |   2 +
>  include/cxl/cxl.h         |   9 ++
>  5 files changed, 252 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index dc075cee0450..69cf2ea7ee74 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_HDM) += reset.o
> +obj-$(CONFIG_CXL_HDM) += regs.o reset.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
>  cxl_core-y += pmem.o
> -cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 83cda63f76a5..0230ebfada42 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -91,11 +91,9 @@ static void clear_hdm_info(void *data)
>  	WRITE_ONCE(pdev->hdm, NULL);
>  }
>  
> -static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +static struct pci_dev *cxl_hdm_to_pci_dev(struct cxl_hdm *cxlhdm)
>  {
>  	struct cxl_port *port = cxlhdm->port;
> -	struct cxl_hdm_info *info;
> -	struct pci_dev *pdev;
>  	struct device *uport;
>  
>  	if (is_cxl_endpoint(port)) {
> @@ -107,9 +105,27 @@ static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
>  	}
>  
>  	if (!dev_is_pci(uport))
> +		return NULL;
> +
> +	return to_pci_dev(uport);
> +}
> +
> +static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_hdm_info *info;
> +	struct pci_dev *pdev;
> +
> +	pdev = cxl_hdm_to_pci_dev(cxlhdm);
> +	if (!pdev)
> +		return 0;
> +
> +	info = READ_ONCE(pdev->hdm);
> +	if (info) {
> +		if (info->decoder_count != cxlhdm->decoder_count)
> +			return -ENXIO;
>  		return 0;
> +	}
>  
> -	pdev = to_pci_dev(uport);
>  	info = devm_kzalloc(&pdev->dev,
>  			    struct_size(info, settings, cxlhdm->decoder_count),
>  			    GFP_KERNEL);
> @@ -125,23 +141,13 @@ static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
>  static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
>  				     struct cxl_decoder *cxld)
>  {
> -	struct cxl_port *port = cxlhdm->port;
>  	struct cxl_hdm_info *info;
>  	struct pci_dev *pdev;
> -	struct device *uport;
> -
> -	if (is_cxl_endpoint(port)) {
> -		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> -
> -		uport = cxlmd->dev.parent;
> -	} else {
> -		uport = port->uport_dev;
> -	}
>  
> -	if (!dev_is_pci(uport))
> +	pdev = cxl_hdm_to_pci_dev(cxlhdm);
> +	if (!pdev)
>  		return;
>  
> -	pdev = to_pci_dev(uport);
>  	info = READ_ONCE(pdev->hdm);
>  	if (!info || cxld->id >= info->decoder_count)
>  		return;
> @@ -202,6 +208,7 @@ static struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	struct cxl_register_map *reg_map = &port->reg_map;
>  	struct device *dev = &port->dev;
>  	struct cxl_hdm *cxlhdm;
> +	struct pci_dev *pdev;
>  	int rc;
>  
>  	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
> @@ -227,11 +234,21 @@ static struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  		return ERR_PTR(-ENODEV);
>  	}
>  
> -	rc = cxl_map_component_regs(reg_map, &cxlhdm->regs,
> -				    BIT(CXL_CM_CAP_CAP_ID_HDM));
> -	if (rc) {
> -		dev_err(dev, "Failed to map HDM capability.\n");
> -		return ERR_PTR(rc);
> +	pdev = cxl_hdm_to_pci_dev(cxlhdm);
> +	if (pdev) {
> +		struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
> +
> +		if (info && info->regs.hdm_decoder)
> +			cxlhdm->regs = info->regs;

The driver probably should not reuse the core mapping. The driver's only
role is to update the cached settings if it changes them.

> +	}
> +
> +	if (!cxlhdm->regs.hdm_decoder) {
> +		rc = cxl_map_component_regs(reg_map, &cxlhdm->regs,
> +					    BIT(CXL_CM_CAP_CAP_ID_HDM));
> +		if (rc) {
> +			dev_err(dev, "Failed to map HDM capability.\n");
> +			return ERR_PTR(rc);
> +		}
>  	}
>  
>  	parse_hdm_decoder_caps(cxlhdm);
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 14f024098e82..fc52d3abdb5b 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -2,9 +2,16 @@
>  /* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */
>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/bitfield.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxlpci.h>
>  
>  #include "cxl.h"
>  #include "core.h"
> @@ -116,3 +123,198 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm)
>  	return 0;
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_commit, "cxl_core");
> +
> +#define CXL_HDM_DECODER_MAX_COUNT 32
> +
> +static void cxl_pci_hdm_clear(void *data)
> +{
> +	struct pci_dev *pdev = data;
> +
> +	WRITE_ONCE(pdev->hdm, NULL);
> +}
> +
> +static void cxl_pci_hdm_unmap(struct pci_dev *pdev,
> +			      struct cxl_component_regs *regs,
> +			      struct cxl_register_map *map)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +
> +	if (!regs->hdm_decoder)
> +		return;
> +
> +	devm_iounmap(&pdev->dev, regs->hdm_decoder);
> +	devm_release_mem_region(&pdev->dev, map->resource + hdm_map->offset,
> +				hdm_map->size);
> +}
> +
> +static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
> +				    struct cxl_decoder_settings *settings,
> +				    void __iomem *hdm, int id)
> +{
> +	u64 target_or_skip, base, size;
> +	u32 ctrl, lo, hi;
> +	int rc;
> +
> +	*settings = (struct cxl_decoder_settings) {
> +		.id = id,
> +	};
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
> +		return 0;
> +
> +	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	base = ((u64)hi << 32) | lo;
> +
> +	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	size = ((u64)hi << 32) | lo;
> +
> +	if (!size || base == U64_MAX || size == U64_MAX ||
> +	    base > U64_MAX - (size - 1)) {
> +		pci_err(pdev, "CXL HDM decoder %d has invalid range\n", id);
> +		return -ENXIO;
> +	}

Zero size is ok now (see series from Richard), and the U64_MAX checks in
the main driver are more about catching common MMIO read failure cases.
In any event I think the core of this function and the validation should
be shared with init_hdm_decoder() so these kinds of disconnects are
prevented.

> +
> +	lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +	target_or_skip = ((u64)hi << 32) | lo;
> +
> +	settings->hpa_range = (struct range) {
> +		.start = base,
> +		.end = base + size - 1,
> +	};
> +	settings->targets = target_or_skip;
> +	settings->target_type = FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) ?
> +				CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM;
> +	settings->flags = CXL_DECODER_F_ENABLE;
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		settings->flags |= CXL_DECODER_F_LOCK;
> +
> +	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> +			 &settings->interleave_ways);
> +	if (rc)
> +		return rc;
> +
> +	return eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK,
> +					    ctrl),
> +				  &settings->interleave_granularity);
> +}
> +
> +static int cxl_pci_hdm_capable(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +	int dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return -ENOTTY;
> +
> +	return 0;
> +}
> +
> +int pci_cxl_hdm_init(struct pci_dev *pdev)

Capability init does not fail, so this can be void.

If you want you can make an inner function to report the init failure
via an info message, but otherwise PCI core is not looking for failures.

> +{
> +	struct cxl_decoder_settings *settings;
> +	struct cxl_component_regs regs = { 0 };
> +	struct cxl_register_map map = { 0 };
> +	struct cxl_hdm_info *info;
> +	bool allocated_info = false;
> +	int decoder_count;
> +	u16 command;
> +	int rc;
> +
> +	info = READ_ONCE(pdev->hdm);
> +	if (info && info->regs.hdm_decoder)
> +		return 0;
> +
> +	rc = cxl_pci_hdm_capable(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(command & PCI_COMMAND_MEMORY))
> +		return -ENOTTY;

This needs some commentary about expectations and likely some formal
recommendation to, and agreement with firmware implementers.

The problem is that CXL memory may be, and usually often is, handed off
actively mapped to the OS. When that happens this needs to be able to
assume that PCI_COMMAND_MEMORY is also enabled for access to the HDM
decoders. It would be broken for firmware to say "here is a device
actively mapping CXL.mem and by the way you can not find out what those
settings are without enabling the device MMIO memory space."

So the expectation is that if a device arrives without
PCI_COMMAND_MEMORY then the OS is free to disable CXL reset when a
driver is not loaded. Conversely, if a device arrives actively providing
system resources, it needs to also arrange for active management.

That said, is it safe to assume that in your testing the memory space is
indeed arriving enabled?

> +
> +	if (!info) {
> +		info = devm_kzalloc(&pdev->dev,

Devres is not suitable for use outside of a driver.

> +				    struct_size(info, settings,
> +						CXL_HDM_DECODER_MAX_COUNT),
> +				    GFP_KERNEL);
> +		if (!info)
> +			return -ENOMEM;
> +		allocated_info = true;
> +	}
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_setup_regs(&map);
> +	if (rc)
> +		return rc;
> +
> +	if (!map.component_map.hdm_decoder.valid) {
> +		rc = -ENODEV;
> +		return rc;
> +	}
> +
> +	rc = cxl_map_component_regs(&map, &regs, BIT(CXL_CM_CAP_CAP_ID_HDM));

This uses devres internally so needs a flavor that does typical
allocation. One way to differentiate would be to set "map.host = NULL"
for this case.

> +	if (rc)
> +		return rc;
> +
> +	decoder_count = cxl_hdm_decoder_count(readl(regs.hdm_decoder +
> +						    CXL_HDM_DECODER_CAP_OFFSET));
> +	if (decoder_count < 0) {
> +		rc = decoder_count;
> +		goto out_unmap;
> +	}
> +
> +	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	if (info->decoder_count && info->decoder_count != decoder_count) {
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->regs = regs;
> +
> +	settings = info->settings;
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &settings[i],
> +					      regs.hdm_decoder, i);
> +		if (rc)
> +			goto out_unmap;
> +	}
> +
> +	WRITE_ONCE(pdev->hdm, info);

The HDM info is accessed either by the reset path or the driver and
should be protected by cxl_rwsem.dpa. So WRITE_ONCE() becomes
unnecessary if info update happens under that synchronization.
