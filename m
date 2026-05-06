Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3240DFDE
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778042390; cv=none; b=a7kPgyej38vcQU8yVXi+xu2ZDjXN4wbOaBjQyTm3q7H8LFO2Y9yZITWGi4qutwulLsVOrrC2VZn5+L12BuPxqqLsLLSXJMP2lkJ81kLLgcS9y978AF8skJ32B/p9PoIFIa7dFOBlnLN+ZSoP5pJbeDkwSR4o0AGFj4XfrvGRQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778042390; c=relaxed/simple;
	bh=oucua38T8wm1KyL1kAlDQ54gxQ0An3taoENAPAtQ3T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Idsi4NH6YKUMzRjOED+WsQSvZL4aHf8oG1I6SWyS7/KPwIbZQwQzdq9pTBujwrh4YBvLAxOLcAC0MEfLiE6L/4HlOSMnnr08Y/zqHWOsN8lqfs+s5uxjYEWh1QxGNkq9vxdcXgEUPhZ4/bUPb7eiM9dkZgmP6PyiUrzeD/Y6wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rc4pjYVf; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rc4pjYVf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778042378; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O0pcudE2O9NRpRLh76BAZRJFTyNMzyc2+RdYjWE/kRs=;
	b=rc4pjYVfwPCuY2EE1PiWap9irPaX6ajtSvjMIS5Byv4uAroJ2rm+M7nWhiQ0bDedv/e5jPcOwYUPdAJ9qVyu8fxO2KiDimg40wJIfzWGuCz+6y/st/MhAeL6Tj4ypG7UPKolWrfnwsYtmBG5m9uQbevwsx1Pd0nOpvM8BSClKNA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X2KbY28_1778042376;
Received: from 30.178.82.123(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X2KbY28_1778042376 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 May 2026 12:39:37 +0800
Message-ID: <d843329a-85c3-4b1c-b35b-e506d247d0ab@linux.alibaba.com>
Date: Wed, 6 May 2026 12:39:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] PCI: Check ROM header and data structure addr
 before accessing
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Xunlei Pang <xlpang@linux.alibaba.com>,
 oliver.yang@linux.alibaba.com
References: <20260430214615.GA441190@bhelgaas>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260430214615.GA441190@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/5/1 05:46, Bjorn Helgaas 写道:
> On Fri, Jan 30, 2026 at 04:07:29PM +0800, Guixin Liu wrote:
>> We meet a crash when running stress-ng on x86_64 machine:
>>
>>    BUG: unable to handle page fault for address: ffa0000007f40000
>>    RIP: 0010:pci_get_rom_size+0x52/0x220
>>    Call Trace:
>>    <TASK>
>>      pci_map_rom+0x80/0x130
>>      pci_read_rom+0x4b/0xe0
>>      kernfs_file_read_iter+0x96/0x180
>>      vfs_read+0x1b1/0x300
>>
>> Our analysis reveals that the ROM space's start address is
>> 0xffa0000007f30000, and size is 0x10000. Because of broken ROM
>> space, before calling readl(pds), the pds's value is
>> 0xffa0000007f3ffff, which is already pointed to the ROM space
>> end, invoking readl() would read 4 bytes therefore cause an
>> out-of-bounds access and trigger a crash.
>> Fix this by adding image header and data structure checking.
>>
>> We also found another crash on arm64 machine:
>>
>>    Unable to handle kernel paging request at virtual address
>> ffff8000dd1393ff
>>    Mem abort info:
>>    ESR = 0x0000000096000021
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x21: alignment fault
>>
>> The call trace is the same with x86_64, but the crash reason is
>> that the data structure addr is not aligned with 4, and arm64
>> machine report "alignment fault". Fix this by adding alignment
>> checking.
>>
>> Fixes: 47b975d234ea ("PCI: Avoid iterating through memory outside the resource window")
>> Suggested-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> ---
>>   drivers/pci/rom.c | 113 ++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 95 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
>> index 4f7641b93b4b..d8abed669fac 100644
>> --- a/drivers/pci/rom.c
>> +++ b/drivers/pci/rom.c
>> @@ -6,9 +6,12 @@
>>    * (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
>>    */
>>   
>> +#include <linux/align.h>
>>   #include <linux/bits.h>
>>   #include <linux/kernel.h>
>>   #include <linux/export.h>
>> +#include <linux/io.h>
>> +#include <linux/overflow.h>
>>   #include <linux/pci.h>
>>   #include <linux/sizes.h>
>>   #include <linux/slab.h>
>> @@ -84,6 +87,91 @@ void pci_disable_rom(struct pci_dev *pdev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_disable_rom);
>>   
>> +static bool pci_rom_is_header_valid(struct pci_dev *pdev,
>> +				    void __iomem *image,
>> +				    void __iomem *rom,
>> +				    size_t size,
>> +				    bool last_image)
>> +{
>> +	unsigned long rom_end = (unsigned long)rom + size - 1;
>> +	unsigned long header_end;
>> +	u16 signature;
>> +
>> +	/*
>> +	 * Some CPU architectures require IOMEM access addresses to
>> +	 * be aligned, for example arm64, so since we're about to
>> +	 * call readw(), we check here for 2-byte alignment.
>> +	 */
> I think PCI Firmware r3.3, sec 5.1, actually requires 512-byte
> alignment, but I guess we haven't enforced that before.  Worth
> mentioning the spec requirement to show that this isn't just an
> arbitrary thing to accommodate a weird CPU architecture.
Yes, it says "Each image must start on a 512-byte boundary and must 
contain the PCI Expansion ROM header".

OK, I'll add a 512-byte alignment check in the next version, along
with a comment citing the spec requirement.
>> +	if (!IS_ALIGNED((unsigned long)image, 2))
>> +		return false;
>> +
>> +	if (check_add_overflow((unsigned long)image, PCI_ROM_HEADER_SIZE,
>> +				&header_end))
>> +		return false;
>> +
>> +	if (image < rom || header_end > rom_end)
>> +		return false;
>  From Sashiko:
>
>    Does this correctly handle a ROM structure that fits exactly at the
>    end of the window?
>
>    Since header_end is calculated exclusively and rom_end inclusively,
>    a perfectly sized structure will have header_end equal to rom_end +
>    1, causing the header_end > rom_end check to incorrectly evaluate to
>    true and reject the ROM. This same inclusive versus exclusive
>    boundary mismatch also happens in pci_rom_is_data_struct_valid()
>    when checking the end pointer.
That's right, chagend in v12, thanks.
>> +
>> +	/* Standard PCI ROMs start out with these bytes 55 AA */
>> +	signature = readw(image);
>> +	if (signature == PCI_ROM_IMAGE_SIGNATURE)
>> +		return true;
> I think this and pci_rom_is_data_struct_valid() would read better if
> every test was a check for failure instead of having a bunch of
> failure returns, followed by a success return, followed by another
> failure return.  E.g.,
>
>    if (signature != PCI_ROM_IMAGE_SIGNATURE) {
>      if (last_image) {
>        ...
>      }
>      return false;
>    }
>
>    return true;
I think so, changed in v12, thanks.
>> +	if (last_image) {
>> +		pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
>> +			 PCI_ROM_IMAGE_SIGNATURE, signature);
>> +	} else {
>> +		pci_info(pdev, "No more image in the PCI ROM\n");
>> +	}
> I'm not completely convinced that it's worth passing in last_image.  I
> suppose the reason was to make the messages exactly the same as
> before?
>
> Even in the "!last_image" case, I think it might be worth printing the
> signature we got.  The "No more image" message means that the ROM
> format isn't strictly conforming, doesn't it?  Maybe the same message
> would suffice for both "last_image" and "!last_image"?
Commit beced88e6af43 ("PCI: Add check code for last image indicator not 
set")
added this printing to avoid print "Invalid image",
I thinks it's worth keeping as-is.
>> +	return false;
>> +}
>> +
>> +static bool pci_rom_is_data_struct_valid(struct pci_dev *pdev,
>> +					 void __iomem *pds,
>> +					 void __iomem *rom,
>> +					 size_t size)
>> +{
>> +	unsigned long rom_end = (unsigned long)rom + size - 1;
>> +	unsigned long end;
>> +	u32 signature;
>> +	u16 data_len;
>> +
>> +	/*
>> +	 * Some CPU architectures require IOMEM access addresses to
>> +	 * be aligned, for example arm64, so since we're about to
>> +	 * call readl(), we check here for 4-byte alignment.
>> +	 */
>> +	if (!IS_ALIGNED((unsigned long)pds, 4))
>> +		return false;
>> +
>> +	/* Before reading length, check addr range. */
>> +	if (check_add_overflow((unsigned long)pds, PCI_ROM_DATA_STRUCT_LEN + 1,
>> +				&end))
>> +		return false;
>> +
>> +	if (pds < rom || end > rom_end)
>> +		return false;
>> +
>> +	data_len = readw(pds + PCI_ROM_DATA_STRUCT_LEN);
>> +	if (!data_len || data_len == U16_MAX)
>> +		return false;
>> +
>> +	if (check_add_overflow((unsigned long)pds, data_len, &end))
>> +		return false;
>> +
>> +	if (end > rom_end)
>> +		return false;
> More from Sashiko:
>
>    Does pci_rom_is_data_struct_valid() need to enforce a minimum safe
>    size for data_len?
>
>    If a malformed device advertises a small data_len (e.g., 12 bytes),
>    validation passes here, but the subsequent reads in
>    pci_get_rom_size() for PCI_ROM_IMAGE_LEN and
>    PCI_ROM_LAST_IMAGE_INDICATOR could access unmapped memory past the
>    ROM boundary.
OK, what would be a suitable min value here? 
PCI_ROM_LAST_IMAGE_INDICATOR? I think this value needs to work for both 
new and legacy devices.
>
>> +	signature = readl(pds);
>> +	if (signature == PCI_ROM_DATA_STRUCT_SIGNATURE)
>> +		return true;
> Seems like it would be nicer to check the signature first, before
> checking the data_len.  If the signature is bad, we log a hint about
> what went wrong, but we don't log anything if data_len is bad.
OK, changed in v12.
>> +	pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
>> +		 PCI_ROM_DATA_STRUCT_SIGNATURE, signature);
>> +	return false;
>> +}
>> +
>>   /**
>>    * pci_get_rom_size - obtain the actual size of the ROM image
>>    * @pdev: target PCI device
>> @@ -99,38 +187,27 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>>   			       size_t size)
>>   {
>>   	void __iomem *image;
>> -	int last_image;
>>   	unsigned int length;
>> +	bool last_image;
>>   
>>   	image = rom;
>>   	do {
>>   		void __iomem *pds;
>> -		/* Standard PCI ROMs start out with these bytes 55 AA */
>> -		if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
>> -			pci_info(pdev, "Invalid PCI ROM header signature: expecting %#06x, got %#06x\n",
>> -				 PCI_ROM_IMAGE_SIGNATURE, readw(image));
>> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, true))
>>   			break;
>> -		}
>> +
>>   		/* get the PCI data structure and check its "PCIR" signature */
>>   		pds = image + readw(image + PCI_ROM_POINTER_TO_DATA_STRUCT);
>> -		if (readl(pds) != PCI_ROM_DATA_STRUCT_SIGNATURE) {
>> -			pci_info(pdev, "Invalid PCI ROM data signature: expecting %#010x, got %#010x\n",
>> -				 PCI_ROM_DATA_STRUCT_SIGNATURE, readl(pds));
>> +		if (!pci_rom_is_data_struct_valid(pdev, pds, rom, size))
>>   			break;
>> -		}
>> +
>>   		last_image = readb(pds + PCI_ROM_LAST_IMAGE_INDICATOR) &
>>   				   PCI_ROM_LAST_IMAGE_INDICATOR_BIT;
>>   		length = readw(pds + PCI_ROM_IMAGE_LEN);
>>   		image += length * PCI_ROM_IMAGE_SECTOR_SIZE;
>> -		/* Avoid iterating through memory outside the resource window */
>> -		if (image >= rom + size)
>> +
>> +		if (!pci_rom_is_header_valid(pdev, image, rom, size, last_image))
>>   			break;
> More from Sashiko.  I'm not sure about this one.
>
>    Does this log a false-positive warning when processing the final
>    image?
>
>    When last_image is true, the image pointer is advanced to the end of
>    the ROM and passed into pci_rom_is_header_valid().
>
>    Because last_image is passed as true to the helper, the signature
>    check will fail and log an invalid header signature error for a
>    perfectly valid device instead of gracefully finishing the loop.
I rename the "last_image" param of pci_rom_is_header_valid() to 
"expect_valid", and add a !last_image check here to print "No more 
image" instead of "Invalid sig". Best Regards, Guixin Liu
>> -		if (!last_image) {
>> -			if (readw(image) != PCI_ROM_IMAGE_SIGNATURE) {
>> -				pci_info(pdev, "No more image in the PCI ROM\n");
>> -				break;
>> -			}
>> -		}
>>   	} while (length && !last_image);
>>   
>>   	/* never return a size larger than the PCI resource window */
>> -- 
>> 2.32.0.3.g01195cf9f
>>

