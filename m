Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA8CC43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B925120864
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G9Mv143x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B925120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406409AbeKWEPc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:15:32 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:43260 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeKWEPc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Nov 2018 23:15:32 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7261010C1438;
        Thu, 22 Nov 2018 09:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542908111; bh=eBr5EApXuPPB9pes/3/JjjL6evykjjpTrj6tTeL0N7I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=G9Mv143x0uI2/bYGkCZCJWLvoAQC0OJqI6uPEME/pSLQo2oJVjNCM6apqGLco4Twd
         G0SZPdf6RJZGMD2vqz/U/TGjb4QRxslu3A5peEWwESENlA1SEFeQmfrero8BKopgn+
         YixOJkMQnn48pfwIQKxl/F0xjrxXBszr1tHTMreC3s+3Dg0ZyunbbQXegCwgF9x66C
         pWBIF8oVO9A3wvH1Gu6ij3XRDt6rZr4ONnx8bEd4wLgwQj3OWK3IR4961A0WJnqSJh
         fATixUlTPZPv4NqSFfgCsGD5ll8XeTp4u472VeinEJ4fe8PSpzPVRx1/ajcqUSryVo
         P16wWFs9F/xAQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4BC993CD6;
        Thu, 22 Nov 2018 09:35:11 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 22 Nov 2018 09:35:11 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 22 Nov 2018 18:35:09 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 22 Nov 2018 18:35:09 +0100
Subject: Re: [PATCH] PCI: dwc: Remove 3-bit right rotation on MSI-X table
 offset address calculation
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <a9c24a70e23dbc5a2d0300452588dc6a0b5e218a.1542903868.git.gustavo.pimentel@synopsys.com>
 <20181122170846.GB17826@e107981-ln.cambridge.arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <bae11891-4a6e-3b30-196d-c138ef493ff8@synopsys.com>
Date:   Thu, 22 Nov 2018 17:31:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181122170846.GB17826@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 22/11/2018 17:08, Lorenzo Pieralisi wrote:
> On Thu, Nov 22, 2018 at 05:24:28PM +0100, Gustavo Pimentel wrote:
>> Remove 3-bit right rotation on MSI-X table offset address calculation on
>> dw_pcie_ep_raise_msix_irq().
>>
>> By default, the offset address of the MSI-X table is zero, so that even with a
>> 3-bit right rotation, the computed result would still be zero, so still valid.
>>
>> Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware-ep.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 1e7b022..cdb2005 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -440,7 +440,6 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>  	tbl_offset = dw_pcie_readl_dbi(pci, reg);
>>  	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
>>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>> -	tbl_offset >>= 3;
> 
> This looks wrong.>
> - If tlb_offset is always 0 there would no point reading it (but I think
>   that's a completely wrong assumption)
> - If tlb_offset can be != 0 you are introducing a bug

That is the bug. I misunderstood the spec and I though that was required to
perform 3-bit right rotation. Since my setup during the developing had the MSI-X
table offset set to zero, this bug passed undetected. Now that my current setup
has a MSI-X table offset different from zero I was able to detect this bug.

> 
>>  	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
>>  	bar_addr_upper = 0;
>> @@ -466,8 +465,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>  
>>  	iounmap(msix_tbl);
>>  
>> -	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
>> +	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT) {
>> +		dev_err(pci->dev, "MSI-X entry ctrl set\n");
> 
> Unrelated change.

Ups, that's right. It's just a debug message in case of error.
Do you prefer a patch version 2 with the description including this debug
message or do you prefer a second patch only with this debug message?

Gustavo

> 
> Lorenzo
> 
>>  		return -EPERM;
>> +	}
>>  
>>  	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
>>  				  epc->mem->page_size);
>> -- 
>> 2.7.4
>>

