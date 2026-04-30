Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB422690EC
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777585577; cv=none; b=qbxm+DzAZuKbgX2ZGFZ40YtdR3m4R44fWN07pmQY4O/peCup+hZ6/9Av45NNBAGBkVwdABahcGNTQ9tIQySQd8IHTimApMGQX9QDXd+xZJSFjLj2cEPznc8GAXRNi5H2Y4hZfrIY2H+V0mdjlZaZ4+YlTEc2CXzKH+8oB4afKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777585577; c=relaxed/simple;
	bh=0xPFDMUmb+S4bnGKhFmD/1JTV3urGir4pXCC42KbLvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fMyG+qnlmA3s77zEJbifAWQUVv8KaeUtOAXeJoMAsA36BgD1r1xRdLzoMSgRuFE47YbpnpEXkEGf1ZqYa3svC6Uo1PChBCYovi1PC6Rn3jysvTevynCvOAzHOxJU6SYoZjnDR5wbr53NyNzhspUPRS5a16lWcJKHw9L7679Z3V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOcTKxtD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOcTKxtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C939C2BCB3;
	Thu, 30 Apr 2026 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777585576;
	bh=0xPFDMUmb+S4bnGKhFmD/1JTV3urGir4pXCC42KbLvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pOcTKxtDhLx0fYN3IrQOcAUkFpY0Zmhx4qopabkCzxqoB8AOxPvdS5DrlR1Iuydsc
	 Fj+e9lY+UjeXbbYY6c3zZvsC9tO4Idz/3F0t6EQtlQyND5rAiKKXJgbT96ur1kiCti
	 4qqZWLDJq3m4c1GbliD+u3TEsAIgvLRJsV3aCzmpE5UBl6Qc72StIBzOO5UfxYCa6S
	 EO47QnGNRo8Ibda3IUUV/7nw4CtxODw7pf2JO4Ndnm573NGIsw1tfHG4wsK7pfZgwJ
	 jc6cecySwVpb5wPfmspZgTEURHalV3hwgsJx7bMUmOjYiuDyowZTxv5TUR5peGvMz4
	 RIfn+4+25QIIw==
Date: Thu, 30 Apr 2026 16:46:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Xunlei Pang <xlpang@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v11 2/2] PCI: Check ROM header and data structure addr
 before accessing
Message-ID: <20260430214615.GA441190@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130080729.96152-3-kanie@linux.alibaba.com>

On Fri, Jan 30, 2026 at 04:07:29PM +0800, Guixin Liu wrote:
> We meet a crash when running stress-ng on x86_64 machine:
> 
>   BUG: unable to handle page fault for address: ffa0000007f40000
>   RIP: 0010:pci_get_rom_size+0x52/0x220
>   Call Trace:
>   <TASK>
>     pci_map_rom+0x80/0x130
>     pci_read_rom+0x4b/0xe0
>     kernfs_file_read_iter+0x96/0x180
>     vfs_read+0x1b1/0x300
> 
> Our analysis reveals that the ROM space's start address is
> 0xffa0000007f30000, and size is 0x10000. Because of broken ROM
> space, before calling readl(pds), the pds's value is
> 0xffa0000007f3ffff, which is already pointed to the ROM space
> end, invoking readl() would read 4 bytes therefore cause an
> out-of-bounds access and trigger a crash.
> Fix this by adding image header and data structure checking.
> 
> We also found another crash on arm64 machine:
> 
>   Unable to handle kernel paging request at virtual address
> ffff8000dd1393ff
>   Mem abort info:
>   ESR = 0x0000000096000021
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x21: alignment fault
> 
> The call trace is the same with x86_64, but the crash reason is
> that the data structure addr is not aligned with 4, and arm64
> machine report "alignment fault". Fix this by adding alignment
> checking.
> 
> Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
> Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/pci/rom.c | 113 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 95 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index 4f7641b93b4b..d8abed669fac 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -6,9 +6,12 @@
>   * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
>   */
>  
> +#include <linux/align.h>
>  #include <linux/bits.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -84,6 +87,91 @@ void pci_disable_rom(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_rom);
>  
> +static bool pci_rom_is_header_valid(struct pci_dev *pdev,
> +				    void __iomem *image,
> +				    void __iomem *rom,
> +				    size_t size,
> +				    bool last_image)
> +{
> +	unsigned long rom_end = (unsigned long)rom + size - 1;
> +	unsigned long header_end;
> +	u16 signature;
> +
> +	/*
> +	 * Some CPU architectures require IOMEM access addresses to
> +	 * be aligned, for example arm64, so since we're about to
> +	 * call readw(), we check here for 2-byte alignment.
> +	 */

I think PCI Firmware r3.3, sec 5.1, actually requires 512-byte
alignment, but I guess we haven't enforced that before.  Worth
mentioning the spec requirement to show that this isn't just an
arbitrary thing to accommodate a weird CPU architecture.

> +	if (!IS_ALIGNED((unsigned long)image, 2))
> +		return false;
> +
> +	if (check_add_overflow((unsigned long)image, PCI_ROM_HEADER_SIZE,
> +				&header_end))
> +		return false;
> +
> +	if (image < rom || header_end > rom_end)
> +		return false;

From Sashiko:

  Does this correctly handle a ROM structure that fits exactly at the
  end of the window?

  Since header_end is calculated exclusively and rom_end inclusively,
  a perfectly sized structure will have header_end equal to rom_end +
  1, causing the header_end > rom_end check to incorrectly evaluate to
  true and reject the ROM. This same inclusive versus exclusive
  boundary mismatch also happens in pci_rom_is_data_struct_valid()
  when checking the end pointer.

> +
> +	/* Standard PCI ROMs start out with these bytes 55 AA */
> +	signature = readw(image);
> +	if (signature == PCI_ROM_IMAGE_SIGNATURE)
> +		return true;

I think this and pci_rom_is_data_struct_valid() would read better if
every test was a check for failure instead of having a bunch of
failure returns, followed by a success return, followed by another
failure return.  E.g.,

  if (signature != PCI_ROM_IMAGE_SIGNATURE) {
    if (last_image) {
      ...
    }
    return false;
  }

  return true;

> +	if (last_image) {
> +		pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
> +			 PCI_ROM_IMAGE_SIGNATURE, signature);
> +	} else {
> +		pci_info(pdev, "No more image in the PCI ROM\n");
> +	}

I'm not completely convinced that it's worth passing in last_image.  I
suppose the reason was to make the messages exactly the same as
before?

Even in the "!last_image" case, I think it might be worth printing the
signature we got.  The "No more image" message means that the ROM
format isn't strictly conforming, doesn't it?  Maybe the same message
would suffice for both "last_image" and "!last_image"?

> +	return false;
> +}
> +
> +static bool pci_rom_is_data_struct_valid(struct pci_dev *pdev,
> +					 void __iomem *pds,
> +					 void __iomem *rom,
> +					 size_t size)
> +{
> +	unsigned long rom_end = (unsigned long)rom + size - 1;
> +	unsigned long end;
> +	u32 signature;
> +	u16 data_len;
> +
> +	/*
> +	 * Some CPU architectures require IOMEM access addresses to
> +	 * be aligned, for example arm64, so since we're about to
> +	 * call readl(), we check here for 4-byte alignment.
> +	 */
> +	if (!IS_ALIGNED((unsigned long)pds, 4))
> +		return false;
> +
> +	/* Before reading length, check addr range. */
> +	if (check_add_overflow((unsigned long)pds, PCI_ROM_DATA_STRUCT_LEN + 1,
> +				&end))
> +		return false;
> +
> +	if (pds < rom || end > rom_end)
> +		return false;
> +
> +	data_len = readw(pds + PCI_ROM_DATA_STRUCT_LEN);
> +	if (!data_len || data_len == U16_MAX)
> +		return false;
> +
> +	if (check_add_overflow((unsigned long)pds, data_len, &end))
> +		return false;
> +
> +	if (end > rom_end)
> +		return false;

More from Sashiko:

  Does pci_rom_is_data_struct_valid() need to enforce a minimum safe
  size for data_len?

  If a malformed device advertises a small data_len (e.g., 12 bytes),
  validation passes here, but the subsequent reads in
  pci_get_rom_size() for PCI_ROM_IMAGE_LEN and
  PCI_ROM_LAST_IMAGE_INDICATOR could access unmapped memory past the
  ROM boundary.

> +	signature = readl(pds);
> +	if (signature == PCI_ROM_DATA_STRUCT_SIGNATURE)
> +		return true;

Seems like it would be nicer to check the signature first, before
checking the data_len.  If the signature is bad, we log a hint about
what went wrong, but we don't log anything if data_len is bad.

> +	pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
> +		 PCI_ROM_DATA_STRUCT_SIGNATURE, signature);
> +	return false;
> +}
> +
>  /**
>   * pci_get_rom_size - obtain the actual size of the ROM image
>   * @pdev: target PCI device
> @@ -99,38 +187,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>  			       size_t size)
>  {
>  	void __iomem *image;
> -	int last_image;
>  	unsigned int length;
> +	bool last_image;
>  
>  	image = rom;
>  	do {
>  		void __iomem *pds;
> -		/* Standard PCI ROMs start out with these bytes 55 AA */
> -		if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
> -			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
> -				 PCI_ROM_IMAGE_SIGNATURE, readw(image));
> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, true))
>  			break;
> -		}
> +
>  		/* get the PCI data structure and check its "PCIR" signature */
>  		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
> -		if (readl(pds) != PCI_ROM_DATA_STRUCT_SIGNATURE) {
> -			pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
> -				 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
> +		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
>  			break;
> -		}
> +
>  		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
>  				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
>  		length = readw(pds + PCI_ROM_IMAGE_LEN);
>  		image += length * PCI_ROM_IMAGE_SECTOR_SIZE;
> -		/* Avoid iterating through memory outside the resource window */
> -		if (image >= rom + size)
> +
> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, last_image))
>  			break;

More from Sashiko.  I'm not sure about this one.

  Does this log a false-positive warning when processing the final
  image?

  When last_image is true, the image pointer is advanced to the end of
  the ROM and passed into pci_rom_is_header_valid().

  Because last_image is passed as true to the helper, the signature
  check will fail and log an invalid header signature error for a
  perfectly valid device instead of gracefully finishing the loop.

> -		if (!last_image) {
> -			if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
> -				pci_info(pdev, "No more image in the PCI ROM\n");
> -				break;
> -			}
> -		}
>  	} while (length && !last_image);
>  
>  	/* never return a size larger than the PCI resource window */
> -- 
> 2.32.0.3.g01195cf9f
> 
