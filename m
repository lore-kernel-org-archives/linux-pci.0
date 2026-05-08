Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013E39C013
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278807; cv=none; b=ml9O812ChMUtbYI00vfErkAXgAu4TWSiBVLTT8coWuF6dgHcxR4eWqYU3hEMv2SBRyBn7WkulHMQ1qnWq3DK1xJIXndscqVZhYlOaGjTrUL24c/6/iQ0d59Gvq81tmrA0qvWi1FG8+wq98fS1yjAXw0U/5bSwgCusM9oJsfVQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278807; c=relaxed/simple;
	bh=NPutYCJSXhX9kT8mMtUc6ImrsCe8AtpGnv1xsAeo6ps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UgUeRAAj8A/T/yBFcWdpyHC6iBlj4BIbbOk8WJqN2yfeN14YDCqt/fMPAPqGfb0S9YgEPCmu6ODL9oU19Ta3AptDAfB8+GMET981pqx1B7DczPUEAjWyq+qaFXA40ZVtqz3E4uMJ+b/J6FukhDPfgH+o0eFXN6NGJRfP1ark1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLMR5BFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLMR5BFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB1DC2BCB0;
	Fri,  8 May 2026 22:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278807;
	bh=NPutYCJSXhX9kT8mMtUc6ImrsCe8AtpGnv1xsAeo6ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fLMR5BFr7Bm7yO1SfPu/zlKwIBmuZvijcb8sgqlsWTbpsy+kUuYHdiyZFeCWcLACn
	 19fh9KfZt4rFZ5Jd8AimIwjPdXFHHQ0I+EMaHh7WqTzpFzrL3yc7rWj7GQlI9pvquo
	 nTqopZTc65buCC2tzGzqyNn9meh+6EllAQIOX6j/m+f9n0Hh/glDZM3HR+3lh46ILL
	 lLoR25bVRLfj04kc5sDQJYhD8kEf1FuSgKe+ooPIwplQPkif0meWxVeWGw7XkKcXaX
	 YSPiibNKwjIbtVmhwWN6dgvelAlOufzA1fKn294jsyLdgfarbZNoJ6YcNOtGvxy1+7
	 MPNVQplhIXeeg==
Date: Fri, 8 May 2026 17:20:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v12 0/2] PCI: Fix crash when access broken ROM
Message-ID: <20260508222005.GA25034@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508082128.3344255-1-kanie@linux.alibaba.com>

On Fri, May 08, 2026 at 04:21:26PM +0800, Guixin Liu wrote:
> v11 -> v12:
> - Add rb tag from Krzysztof Wilczyński in the first patch, thanks.
> - Change "get" to "Get".
> - Renamed parameter last_image → expect_valid in
>   pci_rom_is_header_valid() to better reflect its semantics: it
>   indicates whether the caller expects the image to be valid
>   (and thus whether a missing/invalid signature should be reported
>   as an error or as normal end-of-chain).
> - Tightened image alignment check: replaced the 2-byte alignment check
>   with a 512-byte (PCI_ROM_IMAGE_SECTOR_SIZE) alignment check on image,
>   per PCI Firmware Specification r3.3, sec 5.1, which mandates that each
>   ROM image starts on a 512-byte boundary. This also satisfies the
>   natural-alignment requirement of readw() on architectures such as arm64.
> - Updated comment to cite the PCI Firmware Spec r3.3 sec 5.1 as the
>   authoritative source for the alignment requirement, and to explain the
>   relationship between page-aligned rom, sector-aligned image,
>   and the IOMEM access constraint.
> - Fixed off-by-one in overflow checks: check_add_overflow() now uses
>   PCI_ROM_HEADER_SIZE - 1 and data_len - 1 so that header_end / end
>   represent the inclusive last byte of the region, matching the
>   subsequent > rom_end comparison.
> - Refactored signature-check log flow: collapsed the dual-return branches
>   into a single if (signature != PCI_ROM_IMAGE_SIGNATURE) block, emitting
>   the appropriate pci_info() based on expect_valid, then returning false;
>   success path returns true at the end.
> - Reorder pci_rom_is_data_struct_valid() to check the "PCIR" signature
>   before reading data_len, so bad signatures are still logged.
> - Collapse the signature branch to early-return on failure,
>   matching the style of pci_rom_is_header_valid().
> - Add PCI_ROM_DATA_STRUCT_MIN_LEN (0x18), the PCI 2.x baseline PCI Data
>   Structure length.
> - Reject data_len < PCI_ROM_DATA_STRUCT_MIN_LEN to keep the fixed-offset
>   reads (PCI_ROM_IMAGE_LEN @0x10, PCI_ROM_LAST_IMAGE_INDICATOR @0x15)
>   in pci_get_rom_size() inside the mapped ROM window.
> - Cite PCI Firmware Spec r3.3 sec 5.1.3 Table 5-2 in the new macro's
>   comment.
> 
> v10 -> v11:
> - Change 'pci rom' to 'PCI ROM' of the tittle of the first patch.
> - Add Andy Shevchenko's rb tag in the first patch, thanks. 
> 
> v9 -> v10:
> - Reorder the header files, and not touch kernel.h
> - Change PCI_ROM_IMAGE_LEN_UNIT_BYTES to PCI_ROM_IMAGE_SECTOR_SIZE.
> - Add a comment for PCI_ROM_DATA_STRUCT_SIGNATURE.
> 
> v8 -> v9:
> - Supplemental explanation for the commit body of the first patch.
> - Change PCI_ROM_IMAGE_LEN_UNIT_SZ_512 to PCI_ROM_IMAGE_LEN_UNIT_BYTES,
> and change it's definition to SZ_512.
> - Use u16 and u32 for signature val instead of unsigned short/int.
> 
> v7 -> v8:
> - Ordered header files alphabetically.
> - Convert the literals too in the firt patch.
> - Use local val to save signature instead of reading twice.
> 
> v6 -> v7:
> - Put all named defines to a separate patch.
> - Change PCI_ROM_IMAGE_LEN_UNIT_BYTES to PCI_ROM_IMAGE_LEN_UNIT_SZ_512.
> - Named BIT(7) to PCI_ROM_LAST_IMAGE_INDICATOR_BIT.
> - Fix all other comments from Ilpo, such as including header files,
> and alignment fault, Thanks.
> 
> v5 -> v6:
> - Convert some magic number to named defines, suggested by
> Ilpo, thanks.
> 
> v4 -> v5:
> - Add Andy Shevchenko's rb tag, thanks.
> - Change u64 to unsigned long.
> - Change pci_rom_header_valid() to pci_rom_is_header_valid() and
> change pci_rom_data_struct_valid() to pci_rom_is_data_struct_valid().
> - Change rom_end from rom+size to rom+size-1 for more readble,
> and also change header_end >= rom_end to header_end > rom_end, same
> as data structure end.
> - Change if(!last_image) to if (last_image)..
> - Use U16_MAX instead of 0xffff.
> - Split check_add_overflow() from data_len checking.
> - Remove !!() when reading last_image, and Use BIT(7) instead of 0x80.
> 
> v3 -> v4:
> - Use "u64" instead of "uintptr_t".
> - Invert the if statement to avoid excessive indentation.
> - Add comment for alignment checking.
> - Change last_image's type from int to bool.
> 
> v2 -> v3:
> - Add pci_rom_header_valid() helper for checking image addr and signature.
> - Add pci_rom_data_struct_valid() helper for checking data struct add
> and signature.
> - Handle overflow issue when adding addr with size.
> - Handle alignment fault when running on arm64.
> 
> v1 -> v2:
> - Fix commit body problems, such as blank line in "Call Trace" both sides,
>   thanks, (Andy Shevchenko).
> - Remove every step checking, just check the addr is in header or data
> struct.
> - Add Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com> tag.
> 
> Guixin Liu (2):
>   PCI: Introduce named defines for PCI ROM
>   PCI: Check ROM header and data structure addr before accessing
> 
>  drivers/pci/rom.c | 154 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 131 insertions(+), 23 deletions(-)

Applied to pci/rom for v7.2, thanks for all your work on this!
