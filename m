Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7CF25F984
	for <linux-pci@vger.kernel.org>; Mon,  9 Feb 2026 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659674; cv=none; b=k5ydZA2TfGJPJH6V5leg6BnHTpSa9a+NrvhMjX3eXoxNKWQ+OQQsh7u/yWkDDsvvRtbatCjd0mEKO+aENdBBFi7D7+N+7xKvYCCqyHgzbsnvB4bg6W4IftzGnpIf3RjSDIL4EvgyiG8QTYz6iBTe3Af7P+d0xGhpjpE9Q3HLhbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659674; c=relaxed/simple;
	bh=tdqgvC4SIWtjoQa8SK56q9E39Y+Yhcz7D5YffA9iCFM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KmkMK4xwEetniA9lNCmmWFmDy/DCbI8d91aGtXbwrZw9pCGBlKUw4tDAHSxV/8C6RerG/d9ZfFoF3oWjHw2meH/bE8jffMxJFdxPxp0BP6uX3Yj46glEYb7wfci+Z17l8GHIh/I+i6ZQ7xHNPYnyz/z7Gn8c7/txzWeOhLa4jA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccRKdtIZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccRKdtIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E190C116C6;
	Mon,  9 Feb 2026 17:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770659674;
	bh=tdqgvC4SIWtjoQa8SK56q9E39Y+Yhcz7D5YffA9iCFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ccRKdtIZsoImh2LtG9uJqLKfYc5ezya21c9/cqblZJZDjn6pKgKrfxwJ/jFNGXE+H
	 Q0ZaV9Gn0mR3SF2SkfW6L95A4hfEJhWJ0JI7ToY+WA3+QCTWts4qQalO/Zu0xCByuz
	 usIeqkbncyAQG506CpREsVaomsnQEqqwNemua391bfVerRyllX6NUY6ea5NOUjUAuB
	 J2AEULazq184gL6Jt6XUHtgQPCwyspwM6tYw3/beSsnwUx9QThPVxWw1keH0+0XELZ
	 75y561TSLNQzFTDCmItfODqJtOsr5ojcQQi89D5knr7GLkh8Bx+PPX/fG0NBHTymZp
	 zpDv10mKKh8vQ==
Date: Mon, 9 Feb 2026 11:54:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Xunlei Pang <xlpang@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v11 0/2] PCI: Fix crash when access broken ROM
Message-ID: <20260209175432.GA196137@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a9cada6-479f-4dc3-8856-a359d509e203@linux.alibaba.com>

On Mon, Feb 09, 2026 at 02:43:39PM +0800, Guixin Liu wrote:
> Gentling ping...
> 
> Hi Bjorn and Ilpo, Could you please review these two patches?
> 
> In this version, I fixed the case issues in the first patch title.

Will do, thanks.  Since the v7.0 merge window is open, this is on my
list to look at as soon as v7.0-rc1 is tagged, probably on Feb 22.

> 在 2026/1/30 16:07, Guixin Liu 写道:
> > v10 -> v11:
> > - Change 'pci rom' to 'PCI ROM' of the tittle of the first patch.
> > - Add Andy Shevchenko's rb tag in the first patch, thanks.
> > 
> > v9 -> v10:
> > - Reorder the header files, and not touch kernel.h
> > - Change PCI_ROM_IMAGE_LEN_UNIT_BYTES to PCI_ROM_IMAGE_SECTOR_SIZE.
> > - Add a comment for PCI_ROM_DATA_STRUCT_SIGNATURE.
> > 
> > v8 -> v9:
> > - Supplemental explanation for the commit body of the first patch.
> > - Change PCI_ROM_IMAGE_LEN_UNIT_SZ_512 to PCI_ROM_IMAGE_LEN_UNIT_BYTES,
> > and change it's definition to SZ_512.
> > - Use u16 and u32 for signature val instead of unsigned short/int.
> > 
> > v7 -> v8:
> > - Ordered header files alphabetically.
> > - Convert the literals too in the firt patch.
> > - Use local val to save signature instead of reading twice.
> > 
> > v6 -> v7:
> > - Put all named defines to a separate patch.
> > - Change PCI_ROM_IMAGE_LEN_UNIT_BYTES to PCI_ROM_IMAGE_LEN_UNIT_SZ_512.
> > - Named BIT(7) to PCI_ROM_LAST_IMAGE_INDICATOR_BIT.
> > - Fix all other comments from Ilpo, such as including header files,
> > and alignment fault, Thanks.
> > 
> > v5 -> v6:
> > - Convert some magic number to named defines, suggested by
> > Ilpo, thanks.
> > 
> > v4 -> v5:
> > - Add Andy Shevchenko's rb tag, thanks.
> > - Change u64 to unsigned long.
> > - Change pci_rom_header_valid() to pci_rom_is_header_valid() and
> > change pci_rom_data_struct_valid() to pci_rom_is_data_struct_valid().
> > - Change rom_end from rom+size to rom+size-1 for more readble,
> > and also change header_end >= rom_end to header_end > rom_end, same
> > as data structure end.
> > - Change if(!last_image) to if (last_image)..
> > - Use U16_MAX instead of 0xffff.
> > - Split check_add_overflow() from data_len checking.
> > - Remove !!() when reading last_image, and Use BIT(7) instead of 0x80.
> > 
> > v3 -> v4:
> > - Use "u64" instead of "uintptr_t".
> > - Invert the if statement to avoid excessive indentation.
> > - Add comment for alignment checking.
> > - Change last_image's type from int to bool.
> > 
> > v2 -> v3:
> > - Add pci_rom_header_valid() helper for checking image addr and signature.
> > - Add pci_rom_data_struct_valid() helper for checking data struct add
> > and signature.
> > - Handle overflow issue when adding addr with size.
> > - Handle alignment fault when running on arm64.
> > 
> > v1 -> v2:
> > - Fix commit body problems, such as blank line in "Call Trace" both sides,
> >    thanks, (Andy Shevchenko).
> > - Remove every step checking, just check the addr is in header or data
> > struct.
> > - Add Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com> tag.
> > 
> > Guixin Liu (2):
> >    PCI: Introduce named defines for PCI ROM
> >    PCI: Check ROM header and data structure addr before accessing
> > 
> >   drivers/pci/rom.c | 137 ++++++++++++++++++++++++++++++++++++++--------
> >   1 file changed, 115 insertions(+), 22 deletions(-)
> > 
> 
