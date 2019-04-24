Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D83C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 03:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77032148D
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 03:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jrK/qVwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfDXDv1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:51:27 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2740 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfDXDv1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 23:51:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbfdd240000>; Tue, 23 Apr 2019 20:51:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 20:51:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Apr 2019 20:51:25 -0700
Received: from [10.24.192.71] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 03:51:22 +0000
Subject: Re: [PATCH V2 22/28] PCI: tegra: Access endpoint config only if PCIe
 link is up
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-23-mmaddireddy@nvidia.com>
 <20190423202430.GC14616@google.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <5043c67a-1d21-efcd-63ca-7feb270f9fb0@nvidia.com>
Date:   Wed, 24 Apr 2019 09:21:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423202430.GC14616@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556077861; bh=v9UhaADVrB75zyky5hzko6RyxR5voXXu4xBkZ6xzJY4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=jrK/qVwaITn/aJf2MRsFtFRoxwl0KfOIAdNpULS6wVR2uWR21581xU0M/yD2iKYWj
         uTp+xxFGyK9V+WpmKg+NnTHZ5joa5++C39lEIGTL2FgPDujTc5M7f6Zn39OoVJbeII
         4qbf4zW61J6cZHRMBNmzJqnH2S9f9LnwKHtpJiZIGKHdLZwvDqvugTurXYJeFIiHZF
         z+K0zZ6eohVNZxVCIN3Fxqp4LNhnIvXRMNXxeyQzsG5cXlezCK6VCcGzw9cmzGz84u
         I+/TTOe8uCMIJxKYiNL6/TBU1AgEPn7e5iwIdfaC+4stc9+KwgH0jjBBErFWKUPFvm
         H/Vnkj+KLDYuQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 24-Apr-19 1:54 AM, Bjorn Helgaas wrote:
> On Tue, Apr 23, 2019 at 02:58:19PM +0530, Manikanta Maddireddy wrote:
>> Add PCIe link up check in config read and write callback functions
>> before accessing endpoint config registers.
> I mentioned before:
>
>   We need to either eradicate this pattern of checking for link up, or
>   include a comment about why it is absolutely necessary.
>
> I still think this check should be unnecessary, but if you really
> think you need it, at least add the comment.
Sorry, I missed to add comment in V2. I will take care of it in V3.


Manikanta

>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V2: Change tegra_pcie_link_status() to tegra_pcie_link_up()
>>
>>  drivers/pci/controller/pci-tegra.c | 38 ++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 8ba71e314b1b..05586672a221 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -428,6 +428,14 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
>>  	return readl(pcie->pads + offset);
>>  }
>>  
>> +static bool tegra_pcie_link_up(struct tegra_pcie_port *port)
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
>> @@ -493,20 +501,50 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
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
>> +	if (!tegra_pcie_link_up(port)) {
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
>> +	if (!tegra_pcie_link_up(port))
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>>  	return pci_generic_config_write(bus, devfn, where, size, value);
>>  }
>>  
>> -- 
>> 2.17.1
>>

