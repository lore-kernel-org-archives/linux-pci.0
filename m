Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A588DC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 10:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2722186A
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 10:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dqSIQZt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbfCAKLo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:11:44 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:46448 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731669AbfCAKLn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Mar 2019 05:11:43 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id B70BC10C13CD;
        Fri,  1 Mar 2019 02:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551435103; bh=ICDNW4VQZoul+57Ghn0P0TwvCDr+ZjW2AsOBMzO+HqA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=dqSIQZt8atUH7TwauHN1MvmyI1xVRI8Ep5xzgunDqU6Sl+gMd68W54Id44TDOWJjh
         n0wN4NwrGcyYPuyZ9lcDXTndS2lrhwbjcTIGizRkW1lKrs/StmjNw9KnbgF37HBMHF
         3exmkDXdWLL2z5aVL4TWmBlYHcrayNohxIHUSUdgn1VPdW9Y3w0dfbH24OU42UKI5R
         erLRfqSg1UYE/wlV14rdXlWyQS9LQYX4YoVwYTNJ5IODfeyddyD/btv7/+SdnGV06R
         CuXUgYRtNRt1lop3Mw6wAwfwRz2sGK1BkfJDazVkuDcrYrqaeY6T6DwVYnfiLuQ7hc
         +SGf4fVMC1UNw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3A484A0069;
        Fri,  1 Mar 2019 10:11:42 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 1 Mar 2019 02:11:42 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 1 Mar 2019 11:10:19 +0100
Received: from [10.107.19.132] (10.107.19.132) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 1 Mar 2019 11:10:19 +0100
Subject: Re: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly
 disabled
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>
References: <20190227165219.31911-1-l.stach@pengutronix.de>
 <20190228132936.GA17873@e107981-ln.cambridge.arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <3c088f9c-8def-4ef1-e810-d68a63348b30@synopsys.com>
Date:   Fri, 1 Mar 2019 10:10:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190228132936.GA17873@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.132]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/02/2019 13:29, Lorenzo Pieralisi wrote:
> On Wed, Feb 27, 2019 at 05:52:19PM +0100, Lucas Stach wrote:
>> Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
>> hierarchical API) the MSI init claims one of the controller IRQs as a
>> chained IRQ line for the MSI controller. On some designs, like the i.MX6,
>> this line is shared with a PCIe legacy IRQ. When the line is claimed for
>> the MSI domain, any device trying to use this legacy IRQs will fail to
>> request this IRQ line.
>>
>> As MSI and legacy IRQs are already mutually exclusive on the DWC core,
>> as the core won't forward any legacy IRQs once any MSI has been enabled,
>> users wishing to use legacy IRQs already need to explictly disable MSI
>> support (usually via the pci=nomsi kernel commandline option). To avoid
>> any issues with MSI conflicting with legacy IRQs, just skip all of the
>> DWC MSI initalization, including the IRQ line claim, when MSI is disabled.
>>
>> Fixes: c5925afbc58
>>        (PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API)
>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> Tested-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I request Gustavo's ACK to proceed, thanks.
> 
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 29a05759a294..f4a8494f616b 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -433,7 +433,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>  	if (ret)
>>  		pci->num_viewport = 2;
>>  
>> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> +	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
>>  		/*
>>  		 * If a specific SoC driver needs to change the
>>  		 * default number of vectors, it needs to implement
>> -- 
>> 2.20.1
>>

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
