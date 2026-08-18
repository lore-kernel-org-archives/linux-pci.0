Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB437A833;
	Tue, 18 Aug 2026 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787093016; cv=none; b=IumlwbHpOwhKdcbZ/fzuKlThJRKRQO0ik6fHtIpZf2UFiXdBA97NBCFSrlzqKqAMFkdqpmJt4HygJkfmuQuheAnsbGbVpr4vvruH1HK5fmRyoAMGzHPWHbZoybRYorf0wIxPBLGMJbTXq2xFlpWiTyVZ9AyEMLQRgtwxYnJcpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787093016; c=relaxed/simple;
	bh=YnwdgxHIxA9ySANDIZUzSkvLUXLT162QA9EzxhCH0NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhbMJc7JNka7MTrf0lghKpcE9+NSqv1HYaudVFBCzhnsIcHltwfh6ZcDmD15PFIReZY1YXZ2X9VPn6C2v5f5ZYVsm+RbXaU6JkYHUqaPUIqlQzZdfGX+DmXguypFZiuCZqaA4Zesm9ivIUesTVLCLrwZ6ALoe4mMs7HHJJuwGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cq2c2Ppe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cq2c2Ppe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787093014; x=1818629014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YnwdgxHIxA9ySANDIZUzSkvLUXLT162QA9EzxhCH0NU=;
  b=Cq2c2Ppef/g1Gj+hpTkAAfzz5xfEyS8+FDONNrHMkp595f2zfOLB2SCk
   IrDFIwDyFxtisLUKao60ZhimKZFzhGdHyr3S95h2x3wzGrvb1Hj6d8qOz
   B3XkD8g6ntQ1ScCMXpB7WzrX4manIMA3qErZLDFfKYOjdLoPGBOZqPhkj
   xstZWcN6j5uhpN16Qy03T74MTqycGAhScmjd504fEgJwlc+PTVnuDRkLW
   xXFxqe0XzsPwPB8XSHmwp69+5Zc5UGAutY2AWaqVm1JHkal0n85y5P6Wz
   OlhdgKT4zUwoEixEjw7wNF3AQBAjU+xZWsUImdW29cvtA9cO6eEVdxOb4
   Q==;
X-CSE-ConnectionGUID: 6EEh17ZrT1CmdBcZoT3TfQ==
X-CSE-MsgGUID: X1cRp162RrmfyczgSqchyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87452430"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87452430"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 15:43:34 -0700
X-CSE-ConnectionGUID: VbPJq+WITKm8+RbVy6SkYw==
X-CSE-MsgGUID: h8D5HBEKQfSLx2POoSGnTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="290178793"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.209]) ([10.125.111.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 15:43:31 -0700
Message-ID: <c01709c9-4c3b-4ced-9635-72947807c301@intel.com>
Date: Tue, 18 Aug 2026 15:43:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cxl/core: Skip non-CXL capabilities in MCAP
To: penn <engguopeng@buaa.edu.cn>, linux-cxl@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, johnny.li@montage-tech.com, peng.guo@montage-tech.com,
 jingzhong.yang@montage-tech.com
References: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
 <20260817075854.17207-3-engguopeng@buaa.edu.cn>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260817075854.17207-3-engguopeng@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/17/26 12:58 AM, penn wrote:
> From: Penn <engguopeng@buaa.edu.cn>
> 
> When MMPT is enabled, a CXL device may expose CXL-defined capabilities
> and PCIe Management Message Passthrough (MMPT) capabilities in the same
> MMIO Capabilities Register Block (MCAP).
> 
> The CXL capability parser currently identifies entries using only the
> capability ID. Since capability IDs are scoped by Vendor ID, a
> PCI-SIG-defined capability may have the same ID as a CXL-defined
> capability. This causes non-CXL entries, including MMPT and MMIO Mailbox,
> to be interpreted as CXL register blocks.
> 
> The MMPT register block may be interpreted as a CXL mailbox. This
> causes mailbox initialization to fail with:
> 
>     cxl_pci 0000:3b:00.0: Mailbox is too small (64b)
> 
> Check the MCAP Vendor ID before interpreting an entry as a CXL-defined
> capability. Skip capabilities with a non-zero Vendor ID other than
> PCI_VENDOR_ID_CXL.
> 
> In legacy CXL capability headers, the field now used for the MCAP
> Vendor ID was reserved and reads as zero. Continue to accept zero to
> preserve compatibility with those devices.
> 
> The fix has been tested on CXL 1.1 and CXL 3.0 devices. On the
> MMPT-enabled device, it prevents both Mailbox and Status capabilities
> from being misidentified.
> 
> Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
> Suggested-by: Johnny <johnny.li@montage-tech.com>
> Signed-off-by: Penn <engguopeng@buaa.edu.cn>

After addressing Lukas's comment,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Given that you are utilizing the new PCIe MMIO MBOX feature, have you considered migrate the CXL MBOX block parsing code to a PCI lib and shared between PCI and CXL? I did attempted something [1] like that a while back but never upstreamed the code due to no hardware to test on.
 
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=pci-mbox

DJ

> ---
> Changes in v2:
> - Accept a zero Vendor ID for compatibility with legacy CXL capability
>   headers.
> - Move the u16 declaration above the u32 declaration to follow the
>   reverse Christmas tree convention.
> - Document testing on CXL 1.1 and CXL 3.0 devices.
> 
>  drivers/cxl/core/regs.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 93710cf4f0a6..c7c14089f2c6 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -133,8 +133,18 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  
>  	for (cap = 1; cap <= cap_count; cap++) {
>  		struct cxl_reg_map *rmap;
> +		u16 cap_id, vendor_id;
>  		u32 offset, length;
> -		u16 cap_id;
> +
> +		vendor_id = FIELD_GET(PCI_MCAP_HDR_VENDOR_ID,
> +				      readl(base + PCI_MCAP_HDR_BASE(cap) +
> +					    PCI_MCAP_HDR_REG_4));
> +		/*
> +		 * The Vendor ID field is reserved and reads as zero in legacy
> +		 * CXL capability headers. See CXL r3.2, Table 8-44.
> +		 */
> +		if (vendor_id && vendor_id != PCI_VENDOR_ID_CXL)
> +			continue;
>  
>  		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
>  				   readl(base + cap * 0x10));

