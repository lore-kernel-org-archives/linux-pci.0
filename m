Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0AD37EFFE;
	Fri, 21 Aug 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335291; cv=none; b=dI/ovJqPbgfcEXxuzYUenT6BoeZ5tyqFWu7RCZuL0PLwW2x7NP+EXVzACsPcxyy3TXF3cm+OQ26Wjbh1yIcRN7d22kMPxTFLj8LD2xJfvEwNliuIuAbYw9LxpjsA3888oQY6VYSEZ0q+hrFOYN/+bvzE7PCSdIVQ7dUArSqwrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335291; c=relaxed/simple;
	bh=tB8EKjN3Jx8KT/YoKMiM6I/hNFtwS7eEDyg2QxAGEKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axB6qZ27NP+7Xt/B3EeujLgDbkYs1bc6yjZtwy/reuzRWA86IRNuIE/QKtACDUzodZqAqS2g7LHBDY9mo6YuzUHKC3ifG5ARUIjaUGrBqlv5M1Qod6eA0Cy/6PbVgQiVe1z9u+8goV1F4Mv+FduGK0+cAx0wwqlUvdNAmb5hdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbuV1IOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbuV1IOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933AE1F000E9;
	Fri, 21 Aug 2026 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787335288;
	bh=ILFSvKoyo9akuN/BkYOZeQN/FHoc8oC2pA7NIcnlqD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UbuV1IOEHCQ2rLbYSgzA96x+udIoMQCMvtkB7pGqyw5PvgAunbZDlD5odvD+onhF6
	 FYlvztR/hXN2WCrtAFErz7UN3vC6up/acTENRDGc2+NJKfgWKcBjeiW1fMU3VQpWLf
	 SxOWNQ1yl4obkLAtciarLpA9lyVxxb+hErWCc0034xpR2BznsqEB/MLIoCWOcwxcQQ
	 a/MoakBdoznMGXFpB3i7Uhi5BGF772J29IQOl/CO4KUgpHuJbziq6c9hjDPF135jzW
	 FDPwaMeYf85ueM6cTvJsvrJiecmmYzRDHm8jZD96wFtnnv7aY7idFPaYueg1VXCVr/
	 EigUJjKhg8yag==
Date: Fri, 21 Aug 2026 19:01:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: penn <engguopeng@buaa.edu.cn>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, djbw@kernel.org, johnny.li@montage-tech.com,
 peng.guo@montage-tech.com, jingzhong.yang@montage-tech.com
Subject: Re: [PATCH v2 2/2] cxl/core: Skip non-CXL capabilities in MCAP
Message-ID: <20260821190122.54fb48f0@jic23-huawei>
In-Reply-To: <20260817075854.17207-3-engguopeng@buaa.edu.cn>
References: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
	<20260817075854.17207-3-engguopeng@buaa.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 15:58:54 +0800
penn <engguopeng@buaa.edu.cn> wrote:

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

Hi Penn,

I'm a bit lost to what is going on here. So bare with me!
I think the upshot of the following is we need a little more info
in this patch description.

If the problem you describe was 'real' then we'd have a backwards
compatibility bug in the CXL spec and those folk are normally
pretty good at catching those!

To someone who doesn't know how MCAP and CXL were made compatible
(or like me forgot!) it isn't obvious that the non CXL capabilities
can turn up via the CXL capabilities structures - having reread
the spec sections I'm not sure they can.

A reference + some text from the implementation note in CXL v4.0 8.2.9
CXL Device Register Interface would be helpful.  The picture in
Figure 8-12 for instance implies you should never see non CXL caps
headers via the the CXL register block path.

You are allowed to alias the destinations of the (sort of) pointers
in the capabilities array, but not the header with the pointers
in it.


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
This is in the headers, so I think any device that hits thew condition is
not spec compliant.  I'm not against papering over such a device, but if that
is the case we should identify which device it is.

Now, if were unified code to handle MCAP fully - then I'd be fine with this
check without such additional info.

Need another coffee, so may well be missing something here.

Jonathan
 
> +		/*
> +		 * The Vendor ID field is reserved and reads as zero in legacy
> +		 * CXL capability headers. See CXL r3.2, Table 8-44.
> +		 */
> +		if (vendor_id && vendor_id != PCI_VENDOR_ID_CXL)
> +			continue;
>  
>  		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
>  				   readl(base + cap * 0x10));

