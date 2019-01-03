Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A137EC43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 18:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B16217F5
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 18:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RmLSqRz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfACSFU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:05:20 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:36118 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfACSFU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2019 13:05:20 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D0C4810C0853;
        Thu,  3 Jan 2019 10:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546538719; bh=AoXhByQIzXiw2g0fcRTGkSnnNYQvtybPDCJ54bUcIWw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=RmLSqRz1m3xXk5kV2MCLBZjfrRq0mCogDSVvjjsIECzQ5b4qgs08n0DjfLqGgEswn
         VeRCe88do5mVcEeyUf6KWVqPUU7T2uJoLfVwKn9zn43LDy+cv15cScfd/CNmNftPNV
         DNhHNN2y1a2+/HALmksdZiZVrnZt2AVtt9kdYUQhuh4suQXwHk6mttyRMDENGurUCt
         RSveo3vJIfnDceAirJJPtPwl+qpQH+9CGTyYVVtO1Rv33QDEtwBj2bSwyEOq8sbSQh
         4p0uObs2D242r9owDyQKNpLDyaXPvZJERGyRbkOFqQW3J1qBpxnqzZqsYcsBL3Tk+6
         nfIexTp7mLwgQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 94F2D53B8;
        Thu,  3 Jan 2019 10:05:19 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 3 Jan 2019 10:05:19 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 3 Jan 2019 19:05:17 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 3 Jan 2019 19:05:16 +0100
Subject: Re: [RFC 4/6] dma: Add Synopsys eDMA IP PCIe glue-logic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <b3cf38fc1cb81f9f14df96e2332e612e23ebf918.1544610287.git.gustavo.pimentel@synopsys.com>
 <20181212132528.GT10650@smile.fi.intel.com>
 <e77540c3-0715-667a-8494-2f442b347b06@synopsys.com>
 <20190103173559.GW10650@smile.fi.intel.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <de035ea0-59c2-71a8-83ef-2f8859e6abfc@synopsys.com>
Date:   Thu, 3 Jan 2019 18:00:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190103173559.GW10650@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/01/2019 17:35, Andy Shevchenko wrote:
> On Thu, Dec 13, 2018 at 02:40:40PM +0000, Gustavo Pimentel wrote:
>> On 12/12/2018 13:25, Andy Shevchenko wrote:
>>> On Wed, Dec 12, 2018 at 12:13:24PM +0100, Gustavo Pimentel wrote:
> 
>>> It seems this driver somehow written as a copy-paste of existing pieces w/o good reasons to do such.
>>
> 
> (1)
> 
>> What do you mean? It's true I relied on existing drivers to develop this
>> solution, but is not it supposed to be so?
> 
> See below.
> 
>>>> +enum dw_edma_pcie_bar {
>>>> +	BAR_0,
>>>> +	BAR_1,
>>>> +	BAR_2,
>>>> +	BAR_3,
>>>> +	BAR_4,
>>>> +	BAR_5
>>>> +};
>>>
>>> Why do you need this at all?
>>
>> See my answer below.
>>
>>>
>>>> +static const struct dw_edma_pcie_data snps_edda_data = {
>>>> +	// eDMA registers location
>>>> +	.regs_bar			= BAR_0,
>>>> +	.regs_off			= 0x1000,	//   4 KBytes
>>>> +	// eDMA memory linked list location
>>>> +	.ll_bar				= BAR_2,
>>>> +	.ll_off				= 0,		//   0 KBytes
>>>> +	.ll_sz				= 0x20000,	// 128 KBytes
>>>> +	// Other
>>>> +	.version			= 0,
>>>> +	.mode				= EDMA_MODE_UNROLL,
>>>> +};
>>>
>>> Huh? Isn't this 
>>
>> The eDMA is a hardware block (with requires some configuration) accessible
>> through a PCIe EndPoint, unfortunately there isn't any way for now (at least)
>> through an PCIe capability for instance to detect those configurations
>> automatically, therefore the only way to pass that configuration is to associate
>> it to PCIe Vendor(0x16c3) and Device (0xedda) Id.
>>
>> To interact with eDMA hardware block the driver needs to access the eDMA
>> registers and the only way to do it is through PCIe mapping. In this those
>> registers will be available on BAR 0, with a offset of 4KB from the start.
>>
>> The driver also requires a memory space (RAM) to create a linked list
>> descriptors and pass the first descriptor address to the eDMA hardware block so
>> that it can start performing the transfer autonomously. Once again this memory
>> space is provide through PCIe on BAR 2. This linked list space is in the
>> beginning and it's restricted to a size of 128KB.
>>
>> Since this eDMA hardware block (more specifically eDMA registers) can evolve in
>> the future, I choosed to put here a version in order to have a driver that can
>> be easily adaptable and reusable without much effort.
> 
> (2)
> 
>>>> +	err = pci_try_set_mwi(pdev);
>>>> +	if (err) {
>>>> +		dev_err(dev, "%s DMA memory write invalidate\n",
>>>> +			pci_name(pdev));
>>>> +		return err;
>>>> +	}
>>>
>>> Are you sure you need this?
>>
>> I'm not sure, probably not. I saw using this being use on /dma/dw/pci.c driver.
>> I'll test without it.
> 
> That's exactly the point what I referred to in (1) above.
> Looks like here is cargo-cult programming done without understanding why.
> I dunno how many other cases in the driver like this.

I understand your point of view and I agree with it and that's one of several
reasons why I launched this patch series as a RFC, to acquire some feedback and
expertise from more seniors developers about this matter.

> 
>>>> +	dev_info(dev, "Mode:\t%s\n",
>>>> +		 dw->mode == EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
>>>> +
>>>
>>>
>>>> +	dev_info(dev, "Registers:\tBAR=%u, off=0x%.16llx B, addr=0x%.8lx\n",
>>>> +		 pdata->regs_bar, pdata->regs_off,
>>>> +		 (unsigned long) dw->regs);
>>>
>>> Oh, no, don't do casting when printing something. In only rare cases it's needed, not here.
>>
>> I've put the cast to remove the following warning:
>>
>> drivers/dma/dw-edma/dw-edma-pcie.c:138:15:  warning: format ‘%lx’ expects
>> argument of type ‘long unsigned int’, but argument 6 has type ‘void *’
> 
> ...and as I said this is wrong. Please, find suitable specifiers for your case.

You were right, I corrected that in the meantime (fixed on RFC v3)

> 
>>>> +	if (pdev->msi_cap && pdev->msi_enabled) {
>>>> +		cap_off = pdev->msi_cap + PCI_MSI_FLAGS;
>>>> +		pci_read_config_word(pdev, cap_off, &flags);
>>>> +		if (flags & PCI_MSI_FLAGS_ENABLE) {
>>>> +			cap_off = pdev->msi_cap + PCI_MSI_ADDRESS_LO;
>>>> +			pci_read_config_dword(pdev, cap_off, &addr_lo);
>>>> +
>>>> +			if (flags & PCI_MSI_FLAGS_64BIT) {
>>>> +				cap_off = pdev->msi_cap + PCI_MSI_ADDRESS_HI;
>>>> +				pci_read_config_dword(pdev, cap_off, &addr_hi);
>>>> +				cap_off = pdev->msi_cap + PCI_MSI_DATA_64;
>>>> +			} else {
>>>> +				addr_hi = 0;
>>>> +				cap_off = pdev->msi_cap + PCI_MSI_DATA_32;
>>>> +			}
>>>> +
>>>> +			dw->msi_addr = addr_hi;
>>>> +			dw->msi_addr <<= 32;
>>>> +			dw->msi_addr |= addr_lo;
>>>> +
>>>> +			pci_read_config_dword(pdev, cap_off, &(dw->msi_data));
>>>> +			dw->msi_data &= 0xffff;
>>>> +
>>>> +			dev_info(dev,
>>>> +				 "MSI:\t\taddr=0x%.16llx, data=0x%.8x, nr=%d\n",
>>>> +				 dw->msi_addr, dw->msi_data, pdev->irq);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (pdev->msix_cap && pdev->msix_enabled) {
>>>> +		u32 offset;
>>>> +		u8 bir;
>>>> +
>>>> +		cap_off = pdev->msix_cap + PCI_MSIX_FLAGS;
>>>> +		pci_read_config_word(pdev, cap_off, &flags);
>>>> +
>>>> +		if (flags & PCI_MSIX_FLAGS_ENABLE) {
>>>> +			cap_off = pdev->msix_cap + PCI_MSIX_TABLE;
>>>> +			pci_read_config_dword(pdev, cap_off, &offset);
>>>> +
>>>> +			bir = offset & PCI_MSIX_TABLE_BIR;
>>>> +			offset &= PCI_MSIX_TABLE_OFFSET;
>>>> +
>>>> +			reg = pcim_iomap_table(pdev)[bir];
>>>> +			reg += offset;
>>>> +
>>>> +			addr_lo = readl(reg + PCI_MSIX_ENTRY_LOWER_ADDR);
>>>> +			addr_hi = readl(reg + PCI_MSIX_ENTRY_UPPER_ADDR);
>>>> +			dw->msi_addr = addr_hi;
>>>> +			dw->msi_addr <<= 32;
>>>> +			dw->msi_addr |= addr_lo;
>>>> +
>>>> +			dw->msi_data = readl(reg + PCI_MSIX_ENTRY_DATA);
>>>> +
>>>> +			dev_info(dev,
>>>> +				 "MSI-X:\taddr=0x%.16llx, data=0x%.8x, nr=%d\n",
>>>> +				 dw->msi_addr, dw->msi_data, pdev->irq);
>>>> +		}
>>>> +	}
>>>
>>> What is this? Why?
>>
>> I need to find the PCIe interrupt vector address and value (either for MSI or
>> MSI-X, depends what the system has selected) in order to configure eDMA later to
>> generate the (done or abort) interruptions.
> 
> It seems rather hackish way to do something which should be done by PCI/driver core.
> But perhaps Bjorn and others familiar with PCI endpoint facility can share more.
> Also this applies to (2) above.

Hum, I didn't found anything till now. However I'll ask Bjorn.

> 
>>>> +	if (!pdev->msi_enabled && !pdev->msix_enabled) {
>>
>> I'm not finding it. Can you tell me what it is?
>>
>> Note: pci_msi_enabled() on msi.c returns if MSI has not been disabled by the
>> command-line option pci=nomsi
> 
> Can you look a bit more carefully? For example, assume that 'dev' (sub)prefix
> in the name of function would tell something about scope of application.
> 
> pci_dev_...() ?

The function is pci_dev_msi_enabled(), I've found it meanwhile (fixed on RFC
v3). Thanks for the input.

> 
>>> There is a helper from PCI core for this.
> 

Thanks for the feedback.

Gustavo
