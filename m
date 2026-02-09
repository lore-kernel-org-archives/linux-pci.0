Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BD176FB1
	for <linux-pci@vger.kernel.org>; Mon,  9 Feb 2026 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619431; cv=none; b=pPriI7IbwJiDBJta7uElD9IMna0onbe6r2UgLR6VjGyM+EUyf8CfOycxL5f7g2m3W6zkJE7YkUvgILenAzZ2ZlHKCkhfLjb5rNVEu/WDNeH1YS34eaCdXHG+23mB5+lycDeoESuc2LKZYL0qxHW3mcmh0uA9q12awxulsybqqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619431; c=relaxed/simple;
	bh=5FdRssF3qsKB2PIZAZhVLD1SX2L7NS+dB+0kmMY93Yk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JjJZwipHX+2f6kXsI8/gUG3cZ+4yvc+44dzPD6KzfSu4RYVsMq+pQntScYUHoTqDJWcxGA9HVWLYHcFelU+IzbDv4T4o9CfeiaQV0+dHZ+7o2cx0hRG5N4QkUZ9TUwItqppunpb+8/gxiQEEbMcJLZQSJnipTzaBVdYbztwtJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HeDHhRYU; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HeDHhRYU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770619422; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=GdpBtoKEEGy34xv2ANZ0Tigs/L9JKMFdf0z35fYmKxo=;
	b=HeDHhRYUD84ukOu3g2xBjaYS5ZWZTqjhUP7+oyBwBnIMd8oKdn2CFo9WgrOV9GGd0KEVspn6vX3Uq1S5aunjK4rhDvhfoYSlOcMrEHIEKHYmxSP65vUF0+/tGsa1xbtXfbXi3PKcNo9ll+0U5AhEiwXkuSR3EQ4Cf7z1jsug4ds=
Received: from 30.178.236.111(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WyoKfcu_1770619420 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Feb 2026 14:43:41 +0800
Message-ID: <2a9cada6-479f-4dc3-8856-a359d509e203@linux.alibaba.com>
Date: Mon, 9 Feb 2026 14:43:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v11 0/2] PCI: Fix crash when access broken ROM
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Xunlei Pang <xlpang@linux.alibaba.com>,
 oliver.yang@linux.alibaba.com
References: <20260130080729.96152-1-kanie@linux.alibaba.com>
In-Reply-To: <20260130080729.96152-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gentling ping...

Hi Bjorn and Ilpo, Could you please review these two patches?

In this version, I fixed the case issues in the first patch title.

Best Regards,
Guixin Liu

在 2026/1/30 16:07, Guixin Liu 写道:
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
>    thanks, (Andy Shevchenko).
> - Remove every step checking, just check the addr is in header or data
> struct.
> - Add Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com> tag.
> 
> Guixin Liu (2):
>    PCI: Introduce named defines for PCI ROM
>    PCI: Check ROM header and data structure addr before accessing
> 
>   drivers/pci/rom.c | 137 ++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 115 insertions(+), 22 deletions(-)
> 

