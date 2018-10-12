Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E44C43441
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93562086A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 08:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93562086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJLPr2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:47:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54897 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727370AbeJLPr1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 11:47:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F31ED4620B4E;
        Fri, 12 Oct 2018 16:16:05 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Fri, 12 Oct 2018
 16:16:04 +0800
Subject: Re: [PATCH v3] PCI/AER: Enable reporting for ports enumerated after
 AER driver registration
To:     Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <153927123657.40414.9802241131940995491.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153927157816.40414.5263399018962087014.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20181011155715.GD11034@localhost.localdomain>
CC:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <f7aa5fe9-4c59-cb93-d1ba-baba60442874@huawei.com>
Date:   Fri, 12 Oct 2018 16:16:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181011155715.GD11034@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2018/10/11 23:57, Keith Busch 写道:
> On Thu, Oct 11, 2018 at 08:26:18AM -0700, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Previously we enabled AER error reporting only for Switch Ports that were
>> enumerated prior to registering the AER service driver.  Switch Ports
>> enumerated after AER driver registration were left with error reporting
>> disabled.
>>
>> A common order, which works correctly, is that we enumerate devices before
>> registering portdrv and the AER driver:
>>
>>   - Enumerate all the devices at boot-time
>>
>>   - Register portdrv and bind it to all Root Ports and Switch Ports, which
>>     disables error reporting for these Ports
>>
>>   - Register AER service driver and bind it to all Root Ports, which
>>     enables error reporting for the Root Ports and any Switch Ports below
>>     them
>>
>> But if we enumerate devices *after* registering portdrv and the AER driver,
>> e.g., if a host bridge driver is loaded as a module, error reporting is not
>> enabled correctly:
>>
>>   - Register portdrv and AER driver (this happens at boot-time)
>>
>>   - Enumerate a Root Port
>>
>>   - Bind portdrv to Root Port, disabling its error reporting
>>
>>   - Bind AER service driver to Root Port, enabling error reporting for it
>>     and its children (there are no children, since we haven't enumerated
>>     them yet)
>>
>>   - Enumerate Switch Port below the Root Port
>>
>>   - Bind portdrv to Switch Port, disabling its error reporting
>>
>>   - AER service driver doesn't bind to Switch Ports, so error reporting
>>     remains disabled
>>
>> Hot-adding a Switch fails similarly: error reporting is enabled correctly
>> for the Root Port, but when the Switch is enumerated, the AER service
>> driver doesn't claim it, so there's nothing to enable error reporting for
>> the Switch Ports.
>>
>> Change the AER service driver so it binds to *all* PCIe Ports, including
>> Switch Upstream and Downstream Ports.  Enable AER error reporting for all
>> these Ports, but not for any children.
>>
>> Link: https://lore.kernel.org/linux-pci/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com
>> Based-on-patch-by: Jon Derrick <jonathan.derrick@intel.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pci/pcie/aer.c |   16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 90b53abf621d..c40c6607849b 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1316,12 +1316,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>>  	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
>>  	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
>>
>> -	/*
>> -	 * Enable error reporting for the root port device and downstream port
>> -	 * devices.
>> -	 */
>> -	set_downstream_devices_error_reporting(pdev, true);
>> -
>>  	/* Enable Root Port's interrupt in response to error messages */
>>  	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
>>  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
>> @@ -1378,10 +1372,17 @@ static void aer_remove(struct pcie_device *dev)
>>   */
>>  static int aer_probe(struct pcie_device *dev)
>>  {
>> +	struct pci_dev *pdev = dev->port;
>> +	int type = pci_pcie_type(pdev);
>>  	int status;
>>  	struct aer_rpc *rpc;
>>  	struct device *device = &dev->device;
>>
>> +	if (type == PCI_EXP_TYPE_UPSTREAM || type == PCI_EXP_TYPE_DOWNSTREAM) {
>> +		pci_enable_pcie_error_reporting(pdev);
>> +		return 0;
>> +	}
>
> I think we need to either return an error in this case so that the
> pcie_device won't be eligable for the .remove() callback, or add a
> similiar type check in aer_remove().
>

It seems aer_root_reset() also will be called for downstream port(err.c driver->reset_link(dev)),
but aer_root_reset is only for root port.

static struct pcie_port_service_driver aerdriver = {
	.name		= "aer",
	.port_type	= PCIE_ANY_PORT,
	.service	= PCIE_PORT_SERVICE_AER,

	.probe		= aer_probe,
	.remove		= aer_remove,
	.reset_link	= aer_root_reset,
};

Thanks,
Dongdong
> .
>

