Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22919C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ED9218EA
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 18:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HeWdD3mB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfAaSGr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:06:47 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:53978 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfAaSGr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 13:06:47 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id BA61B24E0ABF;
        Thu, 31 Jan 2019 10:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548958006; bh=+Ybq7mDzPd9AKNvGLNEjhZqv/vS43csTivUDloM77b8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=HeWdD3mB1tl0fsLQUKHj5K4WV4tf6HA72MpQpT3ViKBPsE9Mo9PHWFPa8Z1hWF58w
         k7MNFe7GQgR+svV4LfUIDc6+xF8E/SK1e0EFRTb6I9PU0Ca4WhU3mEFkkSfjC7iSc4
         m/wgCpJta6HfI69LN2BxJA5ZBxf67duVp9q4foGWhj+U/anI3nshym+cgEDd2tdS/a
         S7jTUFTSqF4muQgPu54NZaEeCanU7c5DbSVDv6zretIPKc6RLTxpOPOUp8K+j0Ua53
         kxSQHkN/WcROR8vh26lOB+INGNvasUEKCZDHaTTY6IK8Ewz7e3efqHQIAiu2RYQtEs
         p8ndI3jh81pLA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AB579A01EA;
        Thu, 31 Jan 2019 18:06:46 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 31 Jan 2019 10:05:55 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 31 Jan 2019 19:05:53 +0100
Received: from [10.225.2.145] (10.225.2.145) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 31 Jan 2019 19:05:53 +0100
Subject: Re: [PATCH 7/9] PCI: dwc: Improve code readability and simplifies
 mask/unmask operations
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
References: <cover.1547631485.git.gustavo.pimentel@synopsys.com>
 <eba21fed997cdf148bc03cb459c12d1a32a77a8f.1547631485.git.gustavo.pimentel@synopsys.com>
 <20190131162259.GB28941@e107981-ln.cambridge.arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <8099f163-afdb-57c8-ae80-9255e5d3b71a@synopsys.com>
Date:   Thu, 31 Jan 2019 18:00:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190131162259.GB28941@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.225.2.145]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31/01/2019 16:22, Lorenzo Pieralisi wrote:
> On Wed, Jan 16, 2019 at 11:14:20AM +0100, Gustavo Pimentel wrote:
>> Improve code readability and simplifies mask/unmask operations by
>> inverting the applied logic (no functional change is intended).
>>
>> Replace variable name from irq_status to irq_mask, since its goal is to
>> keep track of which interuptions are mask or not.
>>
>> Replace bit rotation operation (1 << bit) by BIT(bit), which simplifies
>> code reading.
> 
> Two changes, two patches, I know it is tempting to squash trivial
> changes in one patch but logically that's not correct.

Ok, I'll move 2 replacement bit operation to the next patch since its goal is
only that.
Thanks

Gustavo

> 
> Lorenzo
> 
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Joao Pinto <jpinto@synopsys.com>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
>>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 768e16a..d53e6f7 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -164,9 +164,9 @@ static void dw_pci_bottom_mask(struct irq_data *d)
>>  		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>>  		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>  
>> -		pp->irq_status[ctrl] &= ~(1 << bit);
>> +		pp->irq_mask[ctrl] |= BIT(bit);
>>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>> -				    ~pp->irq_status[ctrl]);
>> +				    pp->irq_mask[ctrl]);
>>  	}
>>  
>>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>> @@ -187,9 +187,9 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
>>  		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>>  		bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>  
>> -		pp->irq_status[ctrl] |= 1 << bit;
>> +		pp->irq_mask[ctrl] &= ~BIT(bit);
>>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>> -				    ~pp->irq_status[ctrl]);
>> +				    pp->irq_mask[ctrl]);
>>  	}
>>  
>>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>> @@ -665,13 +665,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>  
>>  	/* Initialize IRQ Status array */
>>  	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
>> +		pp->irq_mask[ctrl] = ~0;
>>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
>>  					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>> -				    4, ~0);
>> +				    4, pp->irq_mask[ctrl]);
>>  		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
>>  					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>>  				    4, ~0);
>> -		pp->irq_status[ctrl] = 0;
>>  	}
>>  
>>  	/* Setup RC BARs */
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 9943d8c..2790002 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -177,7 +177,7 @@ struct pcie_port {
>>  	struct irq_domain	*msi_domain;
>>  	dma_addr_t		msi_data;
>>  	u32			num_vectors;
>> -	u32			irq_status[MAX_MSI_CTRLS];
>> +	u32			irq_mask[MAX_MSI_CTRLS];
>>  	raw_spinlock_t		lock;
>>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>>  };
>> -- 
>> 2.7.4
>>

