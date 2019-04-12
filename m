Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7099C10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 07:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBCA2186A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 07:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ggTuFHs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDLHAo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:00:44 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17020 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfDLHAo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 03:00:44 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb037970000>; Fri, 12 Apr 2019 00:00:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 12 Apr 2019 00:00:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 12 Apr 2019 00:00:42 -0700
Received: from [10.24.70.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Apr
 2019 07:00:37 +0000
Subject: Re: [PATCH 22/30] PCI: tegra: Access endpoint config only if PCIe
 link is up
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-23-mmaddireddy@nvidia.com>
 <20190411201535.GS256045@google.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <e721e7f4-85c9-bee1-7131-12e0b7dfc0d1@nvidia.com>
Date:   Fri, 12 Apr 2019 12:30:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411201535.GS256045@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555052439; bh=MpsOimB47y+QR33ZCHHbM0UmWE91PUFxyjoj8Etagew=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=ggTuFHs3lYol80jmSegi+ert2CdhkGmkW/796S+nVkcwtmPzpFwxlygy/19oSee7O
         f+jCptv/Gt5RQsjb+NW/VJ+3sbJ9US0ysiIhHc7bb+GFOaCCqCtJn+rBFz3KAW0Yd6
         zKd5elNLbbkvyuI4S4Teb6Qyp+w99Qi2aWKzV7RNbiPZcjcVVDZtCDRekyRtNdhMIL
         f3mMy0LowsNEG+UAk5dRu2itI+iIUxOAW6MHZpPHCSM26Bq2Er9ZP7IGAJERCz/bxC
         e4cdfxqAlPShI2jZKnn1cRHyg+cdFz7ylzV7y1DvRzi9kifeR8xA3AmIPpoVXW8JZC
         41AhILpL9X0Zg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12-Apr-19 1:45 AM, Bjorn Helgaas wrote:
> On Thu, Apr 11, 2019 at 10:33:47PM +0530, Manikanta Maddireddy wrote:
>> Add PCIe link up check in config read and write callback functions
>> before accessing endpoint config registers.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index d08a63132c77..c050687020f0 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -426,6 +426,14 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
>>  	return readl(pcie->pads + offset);
>>  }
>>  
>> +static bool tegra_pcie_link_status(struct tegra_pcie_port *port)
> Most drivers call this *_pcie_link_up().  It would be better if tegra
> followed that convention.
OK, I will update it in next version.
>
>> +{
>> +	u32 value;
>> +
>> +	value = readl(port->base + RP_LINK_CONTROL_STATUS);
>> +	return !!(value & RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE);
>> +}
>> +
>>  /*
>>   * The configuration space mapping on Tegra is somewhat similar to the ECAM
>>   * defined by PCIe. However it deviates a bit in how the 4 bits for extended
>> @@ -491,20 +499,50 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
>>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
>>  				  int where, int size, u32 *value)
>>  {
>> +	struct tegra_pcie *pcie = bus->sysdata;
>> +	struct pci_dev *bridge;
>> +	struct tegra_pcie_port *port;
>> +
>>  	if (bus->number == 0)
>>  		return pci_generic_config_read32(bus, devfn, where, size,
>>  						 value);
>>  
>> +	bridge = pcie_find_root_port(bus->self);
>> +
>> +	list_for_each_entry(port, &pcie->ports, list)
>> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
>> +			break;
>> +
>> +	/* If there is no link, then there is no device */
>> +	if (!tegra_pcie_link_status(port)) {
> This is racy and you should avoid it if possible.  The link could go down
> between calling tegra_pcie_link_status() and issuing the config read/write.
>
> If your driver is to be reliable, it must be able to handle any bad
> consequence of issuing that config read/write anyway, so I think it's
> better if it doesn't even bother checking whether the link is up.
This change is made based on similar check present in dwc driver

dw_pcie_valid_device(), reasons for making this change in Tegra might

differ dwc.

Intention here is to reduce the number of AER errors when device is

falling off the bus or going through hot reset. So racy condition here

is OK

>> +		*value = 0xffffffff;
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +	}
>> +
>>  	return pci_generic_config_read(bus, devfn, where, size, value);
>>  }
>>  
>>  static int tegra_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
>>  				   int where, int size, u32 value)
>>  {
>> +	struct tegra_pcie *pcie = bus->sysdata;
>> +	struct tegra_pcie_port *port;
>> +	struct pci_dev *bridge;
>> +
>>  	if (bus->number == 0)
>>  		return pci_generic_config_write32(bus, devfn, where, size,
>>  						  value);
>>  
>> +	bridge = pcie_find_root_port(bus->self);
>> +
>> +	list_for_each_entry(port, &pcie->ports, list)
>> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
>> +			break;
>> +
>> +	/* If there is no link, then there is no device */
>> +	if (!tegra_pcie_link_status(port))
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>>  	return pci_generic_config_write(bus, devfn, where, size, value);
>>  }
>>  
>> -- 
>> 2.17.1
>>
