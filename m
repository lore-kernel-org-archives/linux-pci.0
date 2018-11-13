Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7592C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 06:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E8A21780
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 06:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E8A21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeKMQS0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:18:26 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:56246 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeKMQS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 11:18:26 -0500
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.83])
        by lucky1.263xmail.com (Postfix) with ESMTP id C50F834A;
        Tue, 13 Nov 2018 14:21:39 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.37] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 7C00C393;
        Tue, 13 Nov 2018 14:21:37 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: marc.zyngier@arm.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <d2ef6efd7acfb22dda8987551cc4788d>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 1430BPOH70;
        Tue, 13 Nov 2018 14:21:38 +0800 (CST)
Cc:     shawn.lin@rock-chips.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFC PATCH] PCI: designware: Skip allocating own MSI domain if
 using external MSI domain
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
References: <1540435647-134674-1-git-send-email-shawn.lin@rock-chips.com>
 <9a724bae-e886-8c11-4b02-e67009cc387c@synopsys.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <9416423f-8073-67e7-fced-b641b3920c6f@rock-chips.com>
Date:   Tue, 13 Nov 2018 14:21:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <9a724bae-e886-8c11-4b02-e67009cc387c@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

On 2018/11/13 13:45, Gustavo Pimentel wrote:
> Hi Shawn,
> 
> I'd suggest to change the designware by dwc on the patch title.
> 

Ok.

> On 25/10/2018 03:47, Shawn Lin wrote:
>> On some platform, external MSI domain is using instead of the one
>> created by designware driver. For instance, if using GIC-V3-ITS
>> as a MSI domain, we only need set msi-map in the devicetree but
>> never need any bit in the designware driver to handle MSI stuff.
>> So skip allocating its own MSI domain for that case.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 29a0575..39254b1 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -278,6 +278,10 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>>   		return -ENOMEM;
>>   	}
>>   
>> +	/* Rely on the external MSI domain */
>> +	if (device_property_read_bool(dev, "msi-map"))
>> +		return 0;
>> +
> 
> I would suggest to read this property only in the init of the host and
> configuring it in a Boolean variable to be created in the pp structure and use
> it to verify the feature presence or not.
> 

Will do.

>>   	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
>>   						   &dw_pcie_msi_domain_info,
>>   						   pp->irq_domain);
>> @@ -433,7 +437,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>   	if (ret)
>>   		pci->num_viewport = 2;
>>   
>> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> +	if (IS_ENABLED(CONFIG_PCI_MSI) &&
>> +	    !device_property_read_bool(dev, "msi-map")) {
> 
> You could use the previous boolean variable here also.
> 
>>   		/*
>>   		 * If a specific SoC driver needs to change the
>>   		 * default number of vectors, it needs to implement
>>
> 
> You should protect the dw_pcie_free_msi(), since it uses the pp->msi_domain and
> pp->msi_irq also, maybe using the boolean variable also.

Yeah, will fix.

Thanks for your comment.

> 
> Regards,
> Gustavo
> 
> 
> 

