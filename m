Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0938BC04EB9
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C155320661
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C155320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeLEJyt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:54:49 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:58258 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeLEJyt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2018 04:54:49 -0500
Received: from [10.18.29.147] (10.18.29.147) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 5 Dec 2018
 17:55:00 +0800
Subject: Re: [PATCH v6 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yue Wang <yue.wang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1542876836-191355-1-git-send-email-hanjie.lin@amlogic.com>
 <1542876836-191355-3-git-send-email-hanjie.lin@amlogic.com>
 <20181203164150.GA11855@e107981-ln.cambridge.arm.com>
 <20181203225731.GE207198@google.com>
 <1bc8f5bd-6f69-4867-89ca-e5a611da9136@amlogic.com>
 <20181204120034.GA25842@e107981-ln.cambridge.arm.com>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <b914e35b-f77e-1e42-333f-b5030121cc53@amlogic.com>
Date:   Wed, 5 Dec 2018 17:55:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204120034.GA25842@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.147]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018/12/4 20:00, Lorenzo Pieralisi wrote:
> On Tue, Dec 04, 2018 at 06:40:55PM +0800, Hanjie Lin wrote:
>>
>>
>> On 2018/12/4 6:57, Bjorn Helgaas wrote:
>>> On Mon, Dec 03, 2018 at 04:41:50PM +0000, Lorenzo Pieralisi wrote:
>>>> On Thu, Nov 22, 2018 at 04:53:54PM +0800, Hanjie Lin wrote:
>>>>
>>>> [...]
>>>>
>>>>> +static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>>>>> +				  u32 *val)
>>>>> +{
>>>>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>> +
>>>>> +	/*
>>>>> +	 * there is a bug of MESON AXG pcie controller that software can not
>>>>> +	 * programe PCI_CLASS_DEVICE register, so we must return a fake right
>>>>> +	 * value to ensure driver could probe successfully.
>>>>> +	 */
>>>>> +	if (where == PCI_CLASS_REVISION) {
>>>>> +		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
>>>>> +		/* keep revision id */
>>>>> +		*val &= PCI_CLASS_REVISION_MASK;
>>>>> +		*val |= PCI_CLASS_BRIDGE_PCI << 16;
>>>>> +		return PCIBIOS_SUCCESSFUL;
>>>>> +	}
>>>>
>>>> As I said before, this looks broken. If this code (or other drivers with
>>>> the same broken assumptions, eg dwc/pcie-qcom.c) carries out a, say,
>>>> byte sized config access of eg PCI_CLASS_DEVICE you will get junk out of
>>>> it according to your comment above.
>>>>
>>>> I would like to pick Bjorn's brain on this to see what we can really do
>>>> to fix this (and other) drivers.
>>>
>>>   - Check to see whether you're reading anything in the 32-bit dword at
>>>     offset 0x08.
>>>
>>>   - Do the 32-bit readl().
>>>
>>>   - Insert the correct Sub-Class and Base Class code (you also throw
>>>     away the Programming Interface; not sure why that is)
>>>
>>>   - If you're reading something smaller than 32 bits, mask & shift as
>>>     needed.  pci_bridge_emul_conf_read() does something similar that
>>>     you might be able to copy.
>>>
>>> Out of curiosity, what code depends on PCI_CLASS_BRIDGE_PCI?  There
>>> are several places in the kernel that currently depend on it, but I
>>> think several of them *should* be checking dev->hdr_type to identify a
>>> type 1 header instead.
>>>
>>> Bjorn
>>>
>>> .
>>>
>>
>> Yes, it would be broken in particular scenes(eg: read 1 or 2 bytes from 0xa/PCI_CLASS_DEVICE)
>> that I didn't considered.
>>  
>> As your suggestion, I consider some code below may help this issue:
>> 1, First call dw_pcie_read() help to read 1/2/4 bytes from register,
>>    request all other *size* bytes will return error and dw_pcie_read()
>>    will also check register alignment.
>>  
>> 2, If dw_pcie_read() return success and *where* is 0x8/PCI_CLASS_DEVICE or 0xa/PCI_CLASS_REVISION,
>>    we may need to correct class code.
>>    As PCI_CLASS_REVISION is two-bytes register, so only when read 4 bytes from 0x8/PCI_CLASS_DEVICE
>>    or read 2 bytes from 0xa/PCI_CLASS_REVISION we should correct the class code.
>>  
>> ps: read 1 byte from 0xa/PCI_CLASS_REVISION or 0xb will get incorrect value.
> 
> You can fix this too.
> 
>> static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>>                 u32 *val)
>> {
>>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>         int ret;
>>
>>         ret = dw_pcie_read(pci->dbi_base + where, size, val);
>>         if (ret != PCIBIOS_SUCCESSFUL)
>>                 return ret;
>>
>>         /*
>>         * there is a bug of MESON AXG pcie controller that software can not
>>         * programe PCI_CLASS_DEVICE register, so we must return a fake right
> 
> "There is a bug in the MESON AXG pcie controller whereby software cannot
> programme the PCI_CLASS_DEVICE register, so we must fabricate the return
> value in the config accessors."
> 

Ok, it's more clear :)

>>         * value to ensure driver could probe successfully.
>>         */
>>         if (where == PCI_CLASS_REVISION && size == 4)
>>                 *val = (PCI_CLASS_BRIDGE_PCI << 16) | (*val & 0xffff);
>>         else if (where == PCI_CLASS_DEVICE && size == 2)
>>                 *val = PCI_CLASS_BRIDGE_PCI;
> 
> You can further filter it with (where & 0x1) == PCI_CLASS_DEVICE
> and handle the size accordingly, so that even a byte access would
> work, for completeness.
> 
> Lorenzo
>

Of course, I will add process to handle one-byte access from 0xa/0xb register 
in next-version.

thanks.

hanjie
 
>>         return PCIBIOS_SUCCESSFUL;
>> }
>>
>> 3, We must ensure class is PCI_CLASS_BRIDGE_PCI except right hdr_type,
>>    or pci_setup_device() will get failed: 
>>
>>    ...
>>    class = pci_class(dev);
>>    dev->revision = class & 0xff;
>>    dev->class = class >> 8; /* upper 3 bytes */ 
>>    ....
>>    switch (dev->hdr_type) { /* header type */
>>    ... 
>>    case PCI_HEADER_TYPE_BRIDGE: /* bridge header */
>>       if (class != PCI_CLASS_BRIDGE_PCI)  /* class must be PCI_CLASS_BRIDGE_PCI  */
>>          goto bad; 
>>
>>
>> thanks.
>>
>> hanjie
> 
> .
> 
