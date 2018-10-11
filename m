Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A103C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAACE21477
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 11:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAACE21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJKTZv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:25:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13619 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726908AbeJKTZu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 15:25:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 38FC4B639D36D;
        Thu, 11 Oct 2018 19:58:50 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Thu, 11 Oct 2018
 19:58:48 +0800
Subject: Re: [PATCH] PCI/portdrv: Enable error reporting on managed ports
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
References: <1536085989-2956-1-git-send-email-jonathan.derrick@intel.com>
 <20181009175632.GB5906@bhelgaas-glaptop.roam.corp.google.com>
 <1539114641.8364.34.camel@intel.com>
 <20181009231915.GC5906@bhelgaas-glaptop.roam.corp.google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hch@lst.de" <hch@lst.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <f16ca9d1-0c78-da00-77e0-c9915782239f@huawei.com>
Date:   Thu, 11 Oct 2018 19:58:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181009231915.GC5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

> commit 15a6711649915ca3e9d1086dc88ff4b616b99aac
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Oct 9 17:25:25 2018 -0500
>
>     PCI/AER: Enable reporting for ports enumerated after AER driver registration
>
>     Previously we enabled AER error reporting only for Switch Ports that were
>     enumerated prior to registering the AER service driver.  Switch Ports
>     enumerated after AER driver registration were left with error reporting
>     disabled.
>
>     A common order, which works correctly, is that we enumerate devices before
>     registering portdrv and the AER driver:
>
>       - Enumerate all the devices at boot-time
>
>       - Register portdrv and bind it to all Root Ports and Switch Ports, which
>         disables error reporting for these Ports
>
>       - Register AER service driver and bind it to all Root Ports, which
>         enables error reporting for the Root Ports and any Switch Ports below
>         them
>
>     But if we enumerate devices *after* registering portdrv and the AER driver,
>     e.g., if a host bridge driver is loaded as a module, error reporting is not
>     enabled correctly:
>
>       - Register portdrv and AER driver (this happens at boot-time)
>
>       - Enumerate a Root Port
>
>       - Bind portdrv to Root Port, disabling its error reporting
>
>       - Bind AER service driver to Root Port, enabling error reporting for it
>         and its children (none, since we haven't enumerated them yet)
>
>       - Enumerate Switch Port below the Root Port
>
>       - Bind portdrv to Switch Port, disabling its error reporting
>
>       - AER service driver doesn't bind to Switch Ports, so error reporting
>         remains disabled
>
>     Hot-adding a Switch fails similarly: error reporting is enabled correctly
>     for the Root Port, but when the Switch is enumerated, the AER service
>     driver doesn't claim it, so there's nothing to enable error reporting for
>     the Switch Ports.
>
>     Change the AER service driver so it binds to *all* PCIe ports, including
>     Switch Upstream and Downstream Ports.  For Switch Ports, enable AER error
>     reporting.
>
>     Link: https://lore.kernel.org/linux-pci/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com
>     Based-on-patch-by: Jon Derrick <jonathan.derrick@intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 90b53abf621d..fe6c16461367 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1316,12 +1316,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>  	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
>  	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
>
> -	/*
> -	 * Enable error reporting for the root port device and downstream port
> -	 * devices.
> -	 */
> -	set_downstream_devices_error_reporting(pdev, true);
> -

Delete the code will also disable error reporting for the root port as
the portdrv to Root Port has disabled its error reporting,
so need to enable enable error reporting for the root port.
+pci_enable_pcie_error_reporting(pdev);

The patch looks good to me except this.

Thanks
Dongdong.

>  	/* Enable Root Port's interrupt in response to error messages */
>  	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
>  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> @@ -1378,10 +1372,17 @@ static void aer_remove(struct pcie_device *dev)
>   */
>  static int aer_probe(struct pcie_device *dev)
>  {
> +	struct pci_dev *pdev = dev->port;
> +	int type = pci_pcie_type(pdev);
>  	int status;
>  	struct aer_rpc *rpc;
>  	struct device *device = &dev->device;
>
> +	if (type == PCI_EXP_TYPE_UPSTREAM || type == PCI_EXP_TYPE_DOWNSTREAM) {
> +		pci_enable_pcie_error_reporting(pdev);
> +		return 0;
> +	}
> +
>  	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
>  	if (!rpc) {
>  		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
> @@ -1439,7 +1440,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>
>  static struct pcie_port_service_driver aerdriver = {
>  	.name		= "aer",
> -	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
> +	.port_type	= PCIE_ANY_PORT,
>  	.service	= PCIE_PORT_SERVICE_AER,
>
>  	.probe		= aer_probe,
>
> .
>

