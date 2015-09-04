Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32816 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486AbbIDGGZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2015 02:06:25 -0400
Received: by vkbf67 with SMTP id f67so608462vkb.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2015 23:06:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150903205943.GJ829@google.com>
References: <1440079113-165527-1-git-send-email-gabriele.paoloni@huawei.com>
	<20150903205943.GJ829@google.com>
Date: Fri, 4 Sep 2015 11:36:23 +0530
Message-ID: <CAHM4w1mRg2K49H3jD4oEcEY91Y-TbNA-C4tjwppDuQwi05yrVA@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: fix dw_pcie_cfg_write
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	zhudacai@hisilicon.com, Zhang Jukuo <zhangjukuo@huawei.com>,
	qiuzhenfa@hisilicon.com, Liguozhu <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,


On Fri, Sep 4, 2015 at 2:29 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Aug 20, 2015 at 09:58:33PM +0800, Gabriele Paoloni wrote:
>> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>>
>> Currently in dw_pcie_cfg_write() if the input size is 2 bytes
>> the address offset is wrongly calculated as we mask also bit0
>> of "where" input parameter. Instead we should mask all bits of
>> "where" except bit0 and bit1.
>
> I think there are two problems in this area:
>
> 1) Most calls of dw_pcie_cfg_write() are of the form:
>
>     dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, ...)
>     dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3), where, ...)
>
>    This is needlessly repetitive because the caller has to mention
>    "where" twice and do the masking itself.  We could simply pass
>    "pp->dbi_base" and "where" and let dw_pcie_cfg_write() do all the
>    required masking internally.

I think just by passing "pp->dbi_base" and "where"  we can not take
care of all cases. For example, if I have to read PCI_CACHE_LINE_SIZE
(8 bit value at offset 0x0C), I will have to pass "pp->dbi_base" +
PCI_CACHE_LINE_SIZE, 1

So, I think User of this function will need to pass "addr","size" and
"val", where
"addr"  as "pp->dbi_base" + "where"
"size" and "val" as it is.

one more thing IIRC, there was some discussion (however I am unable to
find any reference), and not sure if it is still true with any
platform:  issues with non word aligned PCI register read.
If a platform is not able to read non word aligned register correctly,
then in that case we will have to pass where and size both :(

>
> 2) Pratyush, this one's for you :)  spear13xx_pcie_establish_link()
>    calls dw_pcie_cfg_read() and dw_pcie_cfg_write() several times like
>    this:
>
>     dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, ...)
>     dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, ...)
>
>    I think these are incorrect because dw_pcie_cfg_read() and
>    dw_pcie_cfg_write() don't add anything to the "addr" argument
>    ("pp->dbi_base" in this case) except the 0-3 byte select offset, so
>    they use the correct alignment, but access the wrong registers.

hummm..so for sure the version which was up-streamed has never been
tested with buggy gen1 card and with any endpoint which would have
generated a read request of more than 128 bytes :( .. Will correct.

Thanks a lot for pointing this out :-)

~Pratyush
