Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A536C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 06:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BC620843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 06:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pdy2y4kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfDWGL3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:11:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15200 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWGL3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 02:11:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbeac950000>; Mon, 22 Apr 2019 23:11:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Apr 2019 23:11:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Apr 2019 23:11:27 -0700
Received: from [10.25.75.193] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 06:11:21 +0000
Subject: Re: [PATCH V3 04/16] PCI: dwc: Perform dbi regs write lock towards
 the end
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20190416192730.15681-1-vidyas@nvidia.com>
 <20190416192730.15681-5-vidyas@nvidia.com>
 <305100E33629484CBB767107E4246BBB0A22C127@de02wembxa.internal.synopsys.com>
 <20190422154608.6e6f8ae3@xhacker.debian>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <f0b5973a-b7a5-ac59-06d6-fdce71fda03d@nvidia.com>
Date:   Tue, 23 Apr 2019 11:41:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422154608.6e6f8ae3@xhacker.debian>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555999893; bh=DXlOvuZYSdUB+yHdA5IR4gKX5pBtQSwNt7fKtc0Xups=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pdy2y4kbl2u46CjtnSmDv3q9OwtcfmZ6aH1MdXfIPuA6AzWXhc6KE3cy0R426sN23
         K8x8OOsPwF6RRxOgSMLveqGfLEfD1T9IdKP/zIxPSUK8tEhs8YdYhLay3bEtwByvNR
         Yb/EJuQuIM6LBQwYNhEOTq0CPJ54vAb6eVrolFd6+fodnZGC1oTwIs79OPyHhjqhWV
         fL3qGpgWpxhspS/DTiDtuTTmB2Bf1ub1z4mfMa45vPfow/y0FYeTiqrOKjI7sh1Nh/
         lwQH0fUPA/T1GsSEnKdm6ka3brJ8gDyq2ShYW+IX1UKK7qdNTfIm4Ixx7b3200jpBD
         mXHHEb5ndo0Bw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/22/2019 1:24 PM, Jisheng Zhang wrote:
> On Wed, 17 Apr 2019 09:56:33 +0000 Gustavo Pimentel wrote:
> 
>>
>> On Tue, Apr 16, 2019 at 20:27:18, Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>>> Remove multiple write enable and disable sequences of dbi registers as
>>> Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
>>> DBI write-lock enable bit thereby not allowing any further writes to BAR-0
>>> register in config space to take place. Hence disabling write permission
>>> only towards the end.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>> Changes since [v2]:
>>> * None
>>>
>>> Changes since [v1]:
>>> * None
>>>
>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 2a5332e5ccfa..c0334c92c1a6 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -683,7 +683,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>>        val &= 0xffff00ff;
>>>        val |= 0x00000100;
>>>        dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
>>> -     dw_pcie_dbi_ro_wr_dis(pci);
>>>
>>>        /* Setup bus numbers */
>>>        val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
>>> @@ -723,8 +722,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>>
>>>        dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>>>
>>> -     /* Enable write permission for the DBI read-only register */
>>> -     dw_pcie_dbi_ro_wr_en(pci);
>>>        /* Program correct class for RC */
>>>        dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
>>>        /* Better disable write permission right after the update */
>>> --
>>> 2.17.1
>>
>> This setup sequence was written by Jingoo Han, let's check if he did this
>> by some particular reason.
>> Jingoo do you remember why you wrote the code like this?
> 
> FWICT, enabling RO writeable in the setup sequence is introduced in
> commit d91dfe5054d4 ("PCI: dwc: Enable write permission for Class Code,
> Interrupt Pin updates"). The Reason why not towards the end maybe
> only enable the RO writeable when necessary.
In that case, my patch shouldn't cause any issue and if any it would avoid
few writes to speed up the process. So, in my opinion, it is a good to go change.
Please let me know if you have disagree with me on this.

> 
> thanks
> 

