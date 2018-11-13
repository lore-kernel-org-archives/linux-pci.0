Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DECEC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 05:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081AC21780
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 05:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IV+TxZXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081AC21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeKMPqI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:46:08 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:46038 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeKMPqH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 10:46:07 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A01D410C0D9D;
        Mon, 12 Nov 2018 21:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542088180; bh=SO4Ww9QeO9Z5GIBgTVGEDtT2WmJupUrCO/UZzt8CTbw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=IV+TxZXAZap+dijaExUtTPIXWiRN0cn82dMP7hiausdFIfmExR2MjMhB7OueIy4mp
         F1FJjh5kMy5ZZVuov7D5NU5fEiEkQz1QiYdmonQ5Mt5U8iqyoK2wo0jhrVXwQfEiJe
         TuR+uhTdPZ8HL8q9W4VfL1gzpUYpVhDNKw3xM2RocshvhI7RGBlXLZkqJY/v5F0HDM
         IJRPnegcAei987HuN+5XpJG85tSDunbG2/ZI5DEKCQE+VLNnO80KQ4HuL18Om8j57o
         aHxWJ2dkfK0/aRAV8qL0tGibBE9vJtIK6hZcdUpLJgd5Lb9tycFwzDffVELZRmf5UU
         VxU6JqSsPMrIA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 824165304;
        Mon, 12 Nov 2018 21:49:40 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 12 Nov 2018 21:49:40 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 06:49:38 +0100
Received: from [10.4.120.44] (10.4.120.44) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 06:49:37 +0100
Subject: Re: [RFC PATCH] PCI: designware: Skip allocating own MSI domain if
 using external MSI domain
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <1540435647-134674-1-git-send-email-shawn.lin@rock-chips.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <9a724bae-e886-8c11-4b02-e67009cc387c@synopsys.com>
Date:   Tue, 13 Nov 2018 05:45:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540435647-134674-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.4.120.44]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shawn,

I'd suggest to change the designware by dwc on the patch title.

On 25/10/2018 03:47, Shawn Lin wrote:
> On some platform, external MSI domain is using instead of the one
> created by designware driver. For instance, if using GIC-V3-ITS
> as a MSI domain, we only need set msi-map in the devicetree but
> never need any bit in the designware driver to handle MSI stuff.
> So skip allocating its own MSI domain for that case.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a0575..39254b1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -278,6 +278,10 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  		return -ENOMEM;
>  	}
>  
> +	/* Rely on the external MSI domain */
> +	if (device_property_read_bool(dev, "msi-map"))
> +		return 0;
> +

I would suggest to read this property only in the init of the host and
configuring it in a Boolean variable to be created in the pp structure and use
it to verify the feature presence or not.

>  	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
>  						   &dw_pcie_msi_domain_info,
>  						   pp->irq_domain);
> @@ -433,7 +437,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (ret)
>  		pci->num_viewport = 2;
>  
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +	if (IS_ENABLED(CONFIG_PCI_MSI) &&
> +	    !device_property_read_bool(dev, "msi-map")) {

You could use the previous boolean variable here also.

>  		/*
>  		 * If a specific SoC driver needs to change the
>  		 * default number of vectors, it needs to implement
> 

You should protect the dw_pcie_free_msi(), since it uses the pp->msi_domain and
pp->msi_irq also, maybe using the boolean variable also.

Regards,
Gustavo
