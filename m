Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35870 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbbISDDx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 23:03:53 -0400
Received: by vkgp185 with SMTP id p185so3892375vkg.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2015 20:03:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150918204625.GL25767@google.com>
References: <1441964307-126942-1-git-send-email-gabriele.paoloni@huawei.com>
	<1441964307-126942-3-git-send-email-gabriele.paoloni@huawei.com>
	<20150918204625.GL25767@google.com>
Date: Sat, 19 Sep 2015 08:33:52 +0530
Message-ID: <CAHM4w1nWNj-Ws0CiYt2vGCa4V7XJsjjwHRSkgdpVSCPmdeARqA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	zhudacai@hisilicon.com, Zhang Jukuo <zhangjukuo@huawei.com>,
	qiuzhenfa@hisilicon.com, Liguozhu <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 19, 2015 at 2:16 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Sep 11, 2015 at 05:38:26PM +0800, Gabriele Paoloni wrote:
>> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>>
>> This patch changes the implementation of dw_pcie_cfg_read() and
>> dw_pcie_cfg_write() to improve the function usage from the callers
>> perspective.
>> Currently the callers are obliged to pass the 32bit aligned address
>> of the register that contains the field of the PCI header that they
>> want to read/write; also they have to pass the offset of the field
>> in that register. This is quite tricky to use as the callers are
>> obliged to sum the PCI header base address to the field offset
>> masked to retrieve the 32b aligned register address.
>>
>> With the new API the callers have to pass the base address of the
>> PCI header and the offset corresponding to the field they intend to
>> read/write.
>>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>
>
>>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>>  {
>> +     addr += (where & ~0x3);
>>       *val = readl(addr);
>> +     where &= 3;
>>
>>       if (size == 1)
>> -             *val = (*val >> (8 * (where & 3))) & 0xff;
>> +             *val = (*val >> (8 * where)) & 0xff;
>>       else if (size == 2)
>> -             *val = (*val >> (8 * (where & 3))) & 0xffff;
>> +             *val = (*val >> (8 * where)) & 0xffff;
>>       else if (size != 4)
>>               return PCIBIOS_BAD_REGISTER_NUMBER;
>>
>> @@ -96,12 +98,14 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>>
>>  int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
>>  {
>> +     addr += where;
>> +
>>       if (size == 4)
>>               writel(val, addr);
>>       else if (size == 2)
>> -             writew(val, addr + (where & 2));
>> +             writew(val, addr);
>>       else if (size == 1)
>> -             writeb(val, addr + (where & 3));
>> +             writeb(val, addr);
>>       else
>>               return PCIBIOS_BAD_REGISTER_NUMBER;
>
> I just noticed the asymmetry between dw_pcie_cfg_read() and
> dw_pcie_cfg_write(): in dw_pcie_cfg_read() we always do 32-bit reads and
> mask out the parts we won't want, but in dw_pcie_cfg_write() we do 8-, 16-,
> or 32-byte writes.
>
> That was there even before your patch, but I wonder why.  Either both
> should work the same way, or there should be a comment explaining why they
> are different.
>
> Jingoo, Pratyush?

As I said earlier, I just vaguely remember that there was some issue
with a SOC in reading non word aligned addresses.
(1) I do not have any reference for it and (2) even if some where
there could be such issue they can always have platform specific
accessor . So I support your idea and both read and write can be made
symmetric.
