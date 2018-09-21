Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF4FECE562
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EED1208A3
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 09:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EED1208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbeIUPRj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:17:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59466 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUPRi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 11:17:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D9A118A;
        Fri, 21 Sep 2018 02:29:39 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01CA33F5C0;
        Fri, 21 Sep 2018 02:29:36 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:29:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Douglas <adouglas@cadence.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: remove unnecessary check of device_type == pci
Message-ID: <20180921092930.GA20641@e107981-ln.cambridge.arm.com>
References: <20180829183440.13601-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829183440.13601-1-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 29, 2018 at 01:34:40PM -0500, Rob Herring wrote:
> PCI host drivers have already matched on compatible strings, so checking
> device_type is redundant. Also, device_type is considered deprecated for
> FDT though we've still been requiring it for PCI hosts as it is useful
> for finding PCI buses.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alan Douglas <adouglas@cadence.com>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pci-host-common.c   | 8 --------
>  drivers/pci/controller/pcie-cadence-host.c | 7 -------
>  drivers/pci/controller/pcie-mobiveil.c     | 7 -------
>  drivers/pci/controller/pcie-xilinx-nwl.c   | 9 ---------
>  drivers/pci/controller/pcie-xilinx.c       | 7 -------
>  5 files changed, 38 deletions(-)

Hi Michal,

are you OK with these changes ?

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d8f10451f273..c742881b5061 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -58,9 +58,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct pci_ecam_ops *ops)
>  {
> -	const char *type;
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
>  	struct pci_host_bridge *bridge;
>  	struct pci_config_window *cfg;
>  	struct list_head resources;
> @@ -70,12 +68,6 @@ int pci_host_common_probe(struct platform_device *pdev,
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	type = of_get_property(np, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
> -
>  	of_pci_check_probe_only();
>  
>  	/* Parse and map our Configuration Space windows */
> diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
> index ec394f6a19c8..97e251090b4f 100644
> --- a/drivers/pci/controller/pcie-cadence-host.c
> +++ b/drivers/pci/controller/pcie-cadence-host.c
> @@ -235,7 +235,6 @@ static int cdns_pcie_host_init(struct device *dev,
>  
>  static int cdns_pcie_host_probe(struct platform_device *pdev)
>  {
> -	const char *type;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct pci_host_bridge *bridge;
> @@ -268,12 +267,6 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  	rc->device_id = 0xffff;
>  	of_property_read_u16(np, "device-id", &rc->device_id);
>  
> -	type = of_get_property(np, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
>  	pcie->reg_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(pcie->reg_base)) {
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index a939e8d31735..77052a0712d0 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -301,13 +301,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  	struct platform_device *pdev = pcie->pdev;
>  	struct device_node *node = dev->of_node;
>  	struct resource *res;
> -	const char *type;
> -
> -	type = of_get_property(node, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
>  
>  	/* map config resource */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index fb32840ce8e6..81538d77f790 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -777,16 +777,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
>  			     struct platform_device *pdev)
>  {
>  	struct device *dev = pcie->dev;
> -	struct device_node *node = dev->of_node;
>  	struct resource *res;
> -	const char *type;
> -
> -	/* Check for device type */
> -	type = of_get_property(node, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
>  	pcie->breg_base = devm_ioremap_resource(dev, res);
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 7b1389d8e2a5..9bd1a35cd5d8 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -574,15 +574,8 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
>  	struct device *dev = port->dev;
>  	struct device_node *node = dev->of_node;
>  	struct resource regs;
> -	const char *type;
>  	int err;
>  
> -	type = of_get_property(node, "device_type", NULL);
> -	if (!type || strcmp(type, "pci")) {
> -		dev_err(dev, "invalid \"device_type\" %s\n", type);
> -		return -EINVAL;
> -	}
> -
>  	err = of_address_to_resource(node, 0, &regs);
>  	if (err) {
>  		dev_err(dev, "missing \"reg\" property\n");
> -- 
> 2.17.1
> 
