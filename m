Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:34097 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdEaMqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2017 08:46:31 -0400
Subject: Re: [PATCH 1/8] pci: adding new irq api to pci-designware
To: Lucas Stach <l.stach@pengutronix.de>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1496142978.git.jpinto@synopsys.com>
 <e0ab2d597306a9df4c955f7761273f4538657e26.1496142978.git.jpinto@synopsys.com>
 <1496234001.30073.19.camel@pengutronix.de>
CC: <bhelgaas@google.com>, <marc.zyngier@arm.com>,
        <m-karicheri2@ti.com>, <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <niklas.cassel@axis.com>, <jesper.nilsson@axis.com>,
        <wangzhou1@hisilicon.com>, <gabriele.paoloni@huawei.com>,
        <svarbanov@mm-sol.com>, <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <62787214-b4d2-5a6b-99a5-df406140cf86@synopsys.com>
Date: Wed, 31 May 2017 13:46:23 +0100
MIME-Version: 1.0
In-Reply-To: <1496234001.30073.19.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Lucas,

Às 1:33 PM de 5/31/2017, Lucas Stach escreveu:
> Am Dienstag, den 30.05.2017, 12:32 +0100 schrieb Joao Pinto:
>> This patch adds the new interrupt api to pcie-designware, keeping the old
>> one. Although the old API is still available, pcie-designware initiates
>> with the new one.
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>> ---
> [...]
>> @@ -378,17 +593,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>  
>>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>  		if (!pp->ops->msi_host_init) {
>> -			pp->irq_domain = irq_domain_add_linear(dev->of_node,
>> -						MAX_MSI_IRQS, &msi_domain_ops,
>> -						&dw_pcie_msi_chip);
>> -			if (!pp->irq_domain) {
>> -				dev_err(dev, "irq domain init failed\n");
>> -				ret = -ENXIO;
>> +			ret = of_property_read_u32(np, "num-vectors",
>> +						   &pp->num_vectors);
>> +			if (ret)
>> +				pp->num_vectors = 1;
> 
> This adds a DT property without documentation. That's a strong no-go.
> 

yep, indeed I forgot to merge this into the patch tree. Going to check this in
the next patch version.

> Why do you even need this property? The number of vectors available can
> be inferred from the compatible, so there is no need to push this into
> the DT. A fallback of only 1 vector if the property doesn't exist is
> also pretty limiting. The old implementation allowed for at least 32
> vectors, with most of the core implementations probably allowing much
> more in hardware.

The hardware supports up to 256, but the current driver is set for a maximum of
32. I suggest we remove MAX_MSI_IRQS and MAX_MSI_CTRLS, and calculate the
maximum number of controllers according to the num_vectors value: Ctrls =
num_vectors / 32, removing the hardcoded limitation from the driver.
What do you think?

> 
> Regards,
> Lucas
> 

Thanks and regards,

Joao
