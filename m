Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38191 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbbIJMkD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 08:40:03 -0400
Received: by wiclk2 with SMTP id lk2so21541334wic.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2015 05:40:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1620C569@lhreml503-mbs>
References: <1441817460-174811-1-git-send-email-gabriele.paoloni@huawei.com>
 <CAErSpo6d_65oCez7fUBLLpYAiA8F8vj5V4j3gkvMVMsNobpfrg@mail.gmail.com> <EE11001F9E5DDD47B7634E2F8A612F2E1620C569@lhreml503-mbs>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 10 Sep 2015 07:39:42 -0500
Message-ID: <CAErSpo5+7cBWLbqVNfq2_+MbY+aL3_Q8n6mBQejGzy29bk7new@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 10, 2015 at 6:26 AM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]

>> I think there was a separate patch for the pcie-spear13xx.c bug,
>> wasn't there?  At least, I don't see that fix in *this* patch.
>>
>
> From your previous comments:
> ********
> *2) Pratyush, this one's for you :)  spear13xx_pcie_establish_link()
> *   calls dw_pcie_cfg_read() and dw_pcie_cfg_write() several times like
> *   this:
> *
> *    dw_pcie_cfg_read(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, ...)
> *    dw_pcie_cfg_write(pp->dbi_base, exp_cap_off + PCI_EXP_DEVCTL, 4, ...)
> ********
>
> I think that the implementation of dw_pcie_cfg_read() and
> dw_pcie_cfg_write() that I proposed in this patch is compatible with
> the previous calls in pcie-spear13xx.c. So the calls in pcie-spear13xx.c
> were buggy for the previous implementations of the functions; with
> the reworked functions there is no need to modify the function calls
> in pcie-spear13xx.c...do you agree?

Oh, I see, I didn't read it closely enough, but you're probably right.
What I would probably do is apply Pratyush's fix first, then apply
your patch on top.  That way we can do the spear13xx bug fix by itself
(which should be a fairly obviously-correct patch), then your
interface change (which would be extended to touch all the calls
including spear13xx and be similarly obviously correct).  I think that
would make it a bit easier for future changelog archaeologists.

Bjorn
