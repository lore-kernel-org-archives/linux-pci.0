Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6468DC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 04:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267442084D
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 04:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rFDr3E6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfBHEd4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:33:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42762 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfBHEd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2019 23:33:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x184XkD2122374;
        Thu, 7 Feb 2019 22:33:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549600426;
        bh=Hs/krZZ/rAyi8TymKF8eRRL6nLOlnXcpunZ/+3IIiJk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rFDr3E6D+Tk/01ivcxLBTw4n5qlXYtuEd1tFsJ32zJPqHTgvewOd4kr6t0B80Fu69
         Uwz/noaFTBqvjrEwgaGV04oNZv4dMKUycbhEQ8zyTtQOWPDbQEdHEh4NNzw7TgqhYh
         MmLw2mUxCKGH54G3nf9mbGCN35QbG+B84l4E++iU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x184XjOH031124
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 22:33:45 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 22:33:45 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 22:33:45 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x184Xgjs016342;
        Thu, 7 Feb 2019 22:33:43 -0600
Subject: Re: [PATCH v2 3/9] PCI: keystone: Add separate functions for
 configuring MSI and legacy interrupt
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-4-kishon@ti.com>
 <20190207154419.GB21111@e107981-ln.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <28bc5a07-3486-6129-7fc9-d37315e34237@ti.com>
Date:   Fri, 8 Feb 2019 10:03:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207154419.GB21111@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 07/02/19 9:14 PM, Lorenzo Pieralisi wrote:
> On Thu, Feb 07, 2019 at 04:39:18PM +0530, Kishon Vijay Abraham I wrote:
>> ks_pcie_get_irq_controller_info() was used to configure both MSI and
>> legacy interrupt. This will prevent MSI or legacy interrupt specific
>> intializations. Add separate functions to configure MSI and legacy
>> interrupts.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 188 +++++++++++-----------
>>  1 file changed, 96 insertions(+), 92 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 4cf9849d5a1d..b1d01751c1af 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -87,11 +87,8 @@ struct keystone_pcie {
>>  	struct dw_pcie		*pci;
>>  	/* PCI Device ID */
>>  	u32			device_id;
>> -	int			num_legacy_host_irqs;
>> -	int			legacy_host_irqs[PCI_NUM_INTX];
>>  	struct			device_node *legacy_intc_np;
>>  
>> -	int			num_msi_host_irqs;
>>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
>>  	int			num_lanes;
>>  	u32			num_viewport;
>> @@ -201,14 +198,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
>>  	return dw_pcie_allocate_domains(pp);
>>  }
>>  
>> -static void ks_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
>> -{
>> -	int i;
>> -
>> -	for (i = 0; i < PCI_NUM_INTX; i++)
>> -		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), 0x1);
>> -}
>> -
>>  static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
>>  				      int offset)
>>  {
>> @@ -490,17 +479,6 @@ static int __init ks_pcie_dw_host_init(struct keystone_pcie *ks_pcie)
>>  
>>  	ks_pcie->app = *res;
>>  
>> -	/* Create legacy IRQ domain */
>> -	ks_pcie->legacy_irq_domain =
>> -			irq_domain_add_linear(ks_pcie->legacy_intc_np,
>> -					      PCI_NUM_INTX,
>> -					      &ks_pcie_legacy_irq_domain_ops,
>> -					      NULL);
>> -	if (!ks_pcie->legacy_irq_domain) {
>> -		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
>> -		return -EINVAL;
>> -	}
>> -
>>  	return dw_pcie_host_init(pp);
>>  }
>>  
>> @@ -624,85 +602,117 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>>  	chained_irq_exit(chip, desc);
>>  }
>>  
>> -static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
>> -					   char *controller, int *num_irqs)
>> +static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
>>  {
>> -	int temp, max_host_irqs, legacy = 1, *host_irqs;
>>  	struct device *dev = ks_pcie->pci->dev;
>> -	struct device_node *np_pcie = dev->of_node, **np_temp;
>> -
>> -	if (!strcmp(controller, "msi-interrupt-controller"))
>> -		legacy = 0;
>> -
>> -	if (legacy) {
>> -		np_temp = &ks_pcie->legacy_intc_np;
>> -		max_host_irqs = PCI_NUM_INTX;
>> -		host_irqs = &ks_pcie->legacy_host_irqs[0];
>> -	} else {
>> -		np_temp = &ks_pcie->msi_intc_np;
>> -		max_host_irqs = MAX_MSI_HOST_IRQS;
>> -		host_irqs =  &ks_pcie->msi_host_irqs[0];
>> -	}
>> +	struct device_node *np = ks_pcie->np;
>> +	struct device_node *intc_np;
>> +	int irq_count;
>> +	int irq;
>> +	int ret;
>> +	int i;
> 
> Nit: all int can be in one line.

Okay.
> 
>> -	/* interrupt controller is in a child node */
>> -	*np_temp = of_get_child_by_name(np_pcie, controller);
>> -	if (!(*np_temp)) {
>> -		dev_err(dev, "Node for %s is absent\n", controller);
>> -		return -EINVAL;
>> -	}
>> +	if (!IS_ENABLED(CONFIG_PCI_MSI))
>> +		return 0;
>>  
>> -	temp = of_irq_count(*np_temp);
>> -	if (!temp) {
>> -		dev_err(dev, "No IRQ entries in %s\n", controller);
>> -		of_node_put(*np_temp);
>> +	intc_np = of_get_child_by_name(np, "msi-interrupt-controller");
>> +	if (!intc_np) {
>> +		dev_WARN(dev, "msi-interrupt-controller node is absent\n");
> 
> I do not think you can justify a backtrace for this error path, so
> convert it to a dev_warn() please.

Sure.
> 
>>  		return -EINVAL;
>>  	}
>>  
>> -	if (temp > max_host_irqs)
>> -		dev_warn(dev, "Too many %s interrupts defined %u\n",
>> -			(legacy ? "legacy" : "MSI"), temp);
>> +	irq_count = of_irq_count(intc_np);
>> +	if (!irq_count) {
>> +		dev_err(dev, "No IRQ entries in msi-interrupt-controller\n");
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>>  
>> -	/*
>> -	 * support upto max_host_irqs. In dt from index 0 to 3 (legacy) or 0 to
>> -	 * 7 (MSI)
>> -	 */
>> -	for (temp = 0; temp < max_host_irqs; temp++) {
>> -		host_irqs[temp] = irq_of_parse_and_map(*np_temp, temp);
>> -		if (!host_irqs[temp])
>> -			break;
>> +	if (irq_count > MAX_MSI_HOST_IRQS) {
>> +		dev_warn(dev, "Too many MSI interrupt lines defined %u\n",
>> +			 irq_count);
>> +		irq_count = MAX_MSI_HOST_IRQS;
>>  	}
>>  
>> -	of_node_put(*np_temp);
>> +	for (i = 0; i < irq_count; i++) {
>> +		irq = irq_of_parse_and_map(intc_np, i);
>> +		if (!irq) {
>> +			ret = -EINVAL;
>> +			goto err;
>> +		}
>> +		ks_pcie->msi_host_irqs[i] = irq;
>>  
>> -	if (temp) {
>> -		*num_irqs = temp;
>> -		return 0;
>> +		irq_set_chained_handler_and_data(irq, ks_pcie_msi_irq_handler,
>> +						 ks_pcie);
>>  	}
>>  
>> -	return -EINVAL;
>> +	of_node_put(intc_np);
>> +	return 0;
>> +
>> +err:
>> +	of_node_put(intc_np);
>> +	return ret;
>>  }
>>  
>> -static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
>> +static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>>  {
>> +	struct device *dev = ks_pcie->pci->dev;
>> +	struct irq_domain *legacy_irq_domain;
>> +	struct device_node *np = ks_pcie->np;
>> +	struct device_node *intc_np;
>> +	int irq_count;
>> +	int irq;
>> +	int ret;
>>  	int i;
>>  
>> -	/* Legacy IRQ */
>> -	for (i = 0; i < ks_pcie->num_legacy_host_irqs; i++) {
>> -		irq_set_chained_handler_and_data(ks_pcie->legacy_host_irqs[i],
>> +	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
>> +	if (!intc_np) {
>> +		dev_WARN(dev, "legacy-interrupt-controller node is absent\n");
> 
> Likewise.

Okay.

Thanks
Kishon
