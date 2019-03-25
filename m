Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB4AC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 15:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF4A20896
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EegELIG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfCYP4n (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:56:43 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:30706 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfCYP4n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 11:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1553529403; x=1585065403;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=G9N+CcWpr2mHPKl4EvR2lWQzdHc7qGWard+TzJVz6YM=;
  b=EegELIG8nFNPr6d1PKPZ2rJtzA3m4ynX0jO2EWIjfYfKFeCnFGePkC5L
   EF1y18idU+EcNlQbn0QahUCihPMv/koWX2E05C/qnfcUG2mEWxRUmIK9F
   EYLq1aq5dPEtvDsbse11LhxK7Q1bKOn2bFWia1/yo4JsXAazhzA63VjBp
   4=;
X-IronPort-AV: E=Sophos;i="5.60,269,1549929600"; 
   d="scan'208";a="795543527"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Mar 2019 15:56:40 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2PFuejn060464
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 25 Mar 2019 15:56:40 GMT
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 25 Mar 2019 15:56:40 +0000
Received: from [10.55.99.41] (10.43.160.180) by EX13D13UWA001.ant.amazon.com
 (10.43.160.136) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 25 Mar
 2019 15:56:36 +0000
Subject: Re: [PATCH] PCI: al: add pcie-al.c
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>, <vaerov@amazon.com>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <zeev@amazon.com>, <ronenk@amazon.com>,
        <barakw@amazon.com>, Talel Shenhar <talel@amazon.com>
References: <1553512040-4453-1-git-send-email-jonnyc@amazon.com>
 <20190325125832.GP251185@google.com>
From:   Jonathan Chocron <jonnyc@amazon.com>
Message-ID: <f2c79fae-d35c-a17f-8b5c-d2404ff067a0@amazon.com>
Date:   Mon, 25 Mar 2019 17:56:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325125832.GP251185@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D08UWC001.ant.amazon.com (10.43.162.110) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/25/19 14:58, Bjorn Helgaas wrote:
> Hi Jonathan,
>
> Looks good to me.  Looks like this hardware is sooooo close to Just
> Working with the generic driver; it's too bad we have to add more ECAM
> quirks, but sometimes life gives us lemons.  Trivial comments below.
> Lorenzo may have additional comments.
>
> The subject should be something like:
>
>    PCI: al: Add Amazon Annapurna Labs PCIe host controller driver
Done.
> On Mon, Mar 25, 2019 at 01:07:20PM +0200, jonnyc@amazon.com wrote:
>> From: Jonathan Chocron <jonnyc@amazon.com>
>>
>> Adding support for Amazon's Annapurna Labs pcie driver.
> s/pcie/PCIe/
>
Done.
>> The HW controller is based on Designware's IP.
>>
>> The HW doesn't support accessing the Root port's config space via
>> ECAM, so we obtain its base address via a PNP0C02 device.
> s/port's/Port's/
Done.
>
> I think you're actually looking for a AMZN0001 device, not a PNP0C02
> device.  Your firmware might have a PNP0C02 _HID and AMZN0001 _CID, but
> that's not relevant here since you're only filtering by AMZN0001.
>
Actually, the _HID is AMZN0001 and the _CID is PNP0C02, so that's why

I used PNP0C02 (to state that it is of this "type"). Please let me know if

you still think it should be changed, so I'll integrate it into v2.

>> Furthermore, the DesignWare PCIe controller doesn't filter out
>> config transactions sent to devices 1 and up on its bus, so they
>> are filtered by the driver.
> Separate paragraphs with blank lines.
Done.
>
>> All subordinate buses do support ECAM access.
>>
>> Implementing specific PCI config access functions involves:
>>   - Adding an init function to obtain the Root Port's base address
>>     from a PNP0C02 device.
> s/PNP0C02/AMZN0001/
>
>>   - Adding a new entry in the mcfg quirk array
>>
>> Co-developed-by: Vladimir Aerov <vaerov@amazon.com>
>> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
>> Signed-off-by: Vladimir Aerov <vaerov@amazon.com>
>> Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
>> ---
>>   MAINTAINERS                          |  6 +++
>>   drivers/acpi/pci_mcfg.c              | 12 +++++
>>   drivers/pci/controller/dwc/Makefile  |  1 +
>>   drivers/pci/controller/dwc/pcie-al.c | 92 ++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-ecam.h             |  1 +
>>   5 files changed, 112 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-al.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 32d444476a90..7a17017f9f82 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11769,6 +11769,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
>>   S:	Supported
>>   F:	drivers/pci/controller/
>>   
>> +PCIE DRIVER FOR ANNAPURNA LABS
>> +M:	Jonathan Chocron <jonnyc@amazon.com>
>> +L:	linux-pci@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/pci/controller/dwc/pcie-al.c
>> +
>>   PCIE DRIVER FOR AMLOGIC MESON
>>   M:	Yue Wang <yue.wang@Amlogic.com>
>>   L:	linux-pci@vger.kernel.org
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index a4e8432fc2fb..b42be067fb83 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -52,6 +52,18 @@ struct mcfg_fixup {
>>   static struct mcfg_fixup mcfg_quirks[] = {
>>   /*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
>>   
>> +#define AL_ECAM(table_id, rev, seg, ops) \
>> +	{ "AMAZON", table_id, rev, seg, MCFG_BUS_ANY, ops }
>> +
>> +	AL_ECAM("GRAVITON", 0, 0, &al_pcie_ops),
>> +	AL_ECAM("GRAVITON", 0, 1, &al_pcie_ops),
>> +	AL_ECAM("GRAVITON", 0, 2, &al_pcie_ops),
>> +	AL_ECAM("GRAVITON", 0, 3, &al_pcie_ops),
>> +	AL_ECAM("GRAVITON", 0, 4, &al_pcie_ops),
>> +	AL_ECAM("GRAVITON", 0, 5, &al_pcie_ops),
>> +	AL_ECAM("GRAVITON", 0, 6, &al_pcie_ops),
>> +	AL_ECAM("GRAVITON", 0, 7, &al_pcie_ops),
>> +
>>   #define QCOM_ECAM32(seg) \
>>   	{ "QCOM  ", "QDF2432 ", 1, seg, MCFG_BUS_ANY, &pci_32b_ops }
>>   
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index 7bcdcdf5024e..1ea773c0070d 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -28,5 +28,6 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>>   # depending on whether ACPI, the DT driver, or both are enabled.
>>   
>>   ifdef CONFIG_PCI
>> +obj-$(CONFIG_ARM64) += pcie-al.o
>>   obj-$(CONFIG_ARM64) += pcie-hisi.o
>>   endif
>> diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
>> new file mode 100644
>> index 000000000000..019497c2c714
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-al.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCIe host controller driver for Amazon's Annapurna Labs IP (used in chips
>> + * such as Graviton and Alpine)
>> + *
>> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
>> + *
>> + * Author: Jonathan Chocron <jonnyc@amazon.com>
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/pci-ecam.h>
>> +#include <linux/pci-acpi.h>
>> +#include "../../pci.h"
>> +
>> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
>> +
>> +struct al_pcie_acpi  {
>> +	void __iomem *dbi_base;
>> +};
>> +
>> +static void __iomem *al_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>> +				     int where)
>> +{
>> +	struct pci_config_window *cfg = bus->sysdata;
>> +	struct al_pcie_acpi *pcie = cfg->priv;
>> +	void __iomem *dbi_base = pcie->dbi_base;
>> +
>> +	if (bus->number == cfg->busr.start) {
>> +		/* The DW PCIe core doesn't filter out transactions to other
>> +		 * devices/functions on the primary bus num, so we do this here.
>> +		 */
> Use usual multi-line comment style:
>
>      /*
>       * text ..
>       */
Done.
>> +		if (PCI_SLOT(devfn) > 0)
>> +			return NULL;
>> +		else
>> +			return dbi_base + where;
>> +	}
>> +
>> +	return pci_ecam_map_bus(bus, devfn, where);
>> +}
>> +
>> +static int al_pcie_init(struct pci_config_window *cfg)
>> +{
>> +	struct device *dev = cfg->parent;
>> +	struct acpi_device *adev = to_acpi_device(dev);
>> +	struct acpi_pci_root *root = acpi_driver_data(adev);
>> +	struct al_pcie_acpi *al_pcie;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	al_pcie = devm_kzalloc(dev, sizeof(*al_pcie), GFP_KERNEL);
>> +	if (!al_pcie)
>> +		return -ENOMEM;
>> +
>> +	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
>> +	if (!res)
>> +		return -ENOMEM;
>> +
>> +	ret = acpi_get_rc_resources(dev, "AMZN0001", root->segment, res);
>> +	if (ret) {
>> +		dev_err(dev, "can't get rc dbi base address for SEG %d\n",
>> +			root->segment);
>> +		return ret;
>> +	}
>> +
>> +	dev_dbg(dev, "Root port dbi res: %pR\n", res);
>> +
>> +	al_pcie->dbi_base = devm_pci_remap_cfg_resource(dev, res);
>> +	if (IS_ERR(al_pcie->dbi_base)) {
>> +		long err = PTR_ERR(al_pcie->dbi_base);
>> +
>> +		dev_err(dev, "couldn't remap dbi base %pR (err:%ld)\n",
>> +			res, err);
>> +		return err;
>> +	}
>> +
>> +	cfg->priv = al_pcie;
>> +
>> +	return 0;
>> +}
>> +
>> +struct pci_ecam_ops al_pcie_ops = {
>> +	.bus_shift    = 20,
>> +	.init         =  al_pcie_init,
>> +	.pci_ops      = {
>> +		.map_bus    = al_pcie_map_bus,
>> +		.read       = pci_generic_config_read,
>> +		.write      = pci_generic_config_write,
>> +	}
>> +};
>> +
>> +#endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
>> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
>> index 29efa09d686b..a73164c85e78 100644
>> --- a/include/linux/pci-ecam.h
>> +++ b/include/linux/pci-ecam.h
>> @@ -56,6 +56,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>>   extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
>>   extern struct pci_ecam_ops xgene_v1_pcie_ecam_ops; /* APM X-Gene PCIe v1 */
>>   extern struct pci_ecam_ops xgene_v2_pcie_ecam_ops; /* APM X-Gene PCIe v2.x */
>> +extern struct pci_ecam_ops al_pcie_ops; /* Amazon Annapurna Labs PCIe */
>>   #endif
>>   
>>   #ifdef CONFIG_PCI_HOST_COMMON
>> -- 
>> 1.9.1
>>

