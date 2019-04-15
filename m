Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E82CC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57BD20645
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dmnWBnnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfDOLgb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:36:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4545 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfDOLga (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:36:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb46cc10000>; Mon, 15 Apr 2019 04:36:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 04:36:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 04:36:28 -0700
Received: from [10.24.192.241] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 11:36:24 +0000
Subject: Re: [PATCH 22/30] PCI: tegra: Access endpoint config only if PCIe
 link is up
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-23-mmaddireddy@nvidia.com>
 <20190411201535.GS256045@google.com>
 <e721e7f4-85c9-bee1-7131-12e0b7dfc0d1@nvidia.com>
 <20190412145003.GE141472@google.com>
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1039fbf2-24ad-c31c-93d9-663aab74a26a@nvidia.com>
Date:   Mon, 15 Apr 2019 17:06:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412145003.GE141472@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555328194; bh=72hFGltt4zA09krllgfldl+guRoNOyjtR6Hmg+hWMuQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=dmnWBnnNZrs4G/QUTxwj6etwHgk+nFi8BjgyptIE+ceg/UTeHQZLF+vCJfR/IaIxB
         2SEBi+bhTCGU4Z4s2rUu52+7fWGSeKzmKX+bwbsfEHvwMEOLdjleAzQBtywxvbfHFC
         YyaSESCwe7fLhr477aPekkdIEgNlqJzs4cYZJbIHp33HedBrO61PpWajw3kOrl4VkE
         UNhLxEOBcv9TKiDMOCTcVRIaWalm3biaxsIdZaU7e8mzN0UG2YtDxTh7telZmkHNxc
         QPVdsQCUOgnDApbEYQDMtrw+UthoqNAzggoTsKwygkrOU6JdaVLmjqBWzBVKCgXvic
         0j7S7J+5C4vtQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12-Apr-19 8:20 PM, Bjorn Helgaas wrote:
> [+cc Jingoo, Gustavo (dwc maintainers), Ley (altera), Michal (xilinx)]
>
> On Fri, Apr 12, 2019 at 12:30:22PM +0530, Manikanta Maddireddy wrote:
>> On 12-Apr-19 1:45 AM, Bjorn Helgaas wrote:
>>> On Thu, Apr 11, 2019 at 10:33:47PM +0530, Manikanta Maddireddy wrote:
>>>> Add PCIe link up check in config read and write callback functions
>>>> before accessing endpoint config registers.
>>>>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
>>>>  				  int where, int size, u32 *value)
>>>>  {
>>>> +	struct tegra_pcie *pcie = bus->sysdata;
>>>> +	struct pci_dev *bridge;
>>>> +	struct tegra_pcie_port *port;
>>>> +
>>>>  	if (bus->number == 0)
>>>>  		return pci_generic_config_read32(bus, devfn, where, size,
>>>>  						 value);
>>>>  
>>>> +	bridge = pcie_find_root_port(bus->self);
>>>> +
>>>> +	list_for_each_entry(port, &pcie->ports, list)
>>>> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
>>>> +			break;
>>>> +
>>>> +	/* If there is no link, then there is no device */
>>>> +	if (!tegra_pcie_link_status(port)) {
>>> This is racy and you should avoid it if possible.  The link could go down
>>> between calling tegra_pcie_link_status() and issuing the config read/write.
>>>
>>> If your driver is to be reliable, it must be able to handle any bad
>>> consequence of issuing that config read/write anyway, so I think it's
>>> better if it doesn't even bother checking whether the link is up.
>> This change is made based on similar check present in dwc driver
>> dw_pcie_valid_device(), reasons for making this change in Tegra might
>> differ dwc.
> Yes, you won't be surprised to learn that I don't like the similar
> checks in dwc, altera, xilinx, and xilinx-nwl either :)  I raise this
> issue every time I see it, but I can't remember if I've mentioned dwc
> specifically.
>
> We need to either eradicate this pattern of checking for link up, or
> include a comment about why it is absolutely necessary.

This patch is created to address below scenario in our downstream kernel,
1) Our platform has WiFi on one slot and GPU in another.
2) During WiFi OFF, link is put in L2 and it goes through hot reset
when turning ON WiFi (since Tegra doesn't support hot-plug).
3) Whenever x11 server is started it scans the PCIe bus for video devices.
Here PCIe configuration registers of all devices are read to find out
all available video devices.
4) If "x11 server" started with WiFi OFF, then we are seeing "response
decoding error"(Tegra AFI module specific error).

Best solution we came up with is to have link up check in config access
callback functions.

>
>> Intention here is to reduce the number of AER errors when device is
>> falling off the bus or going through hot reset. So racy condition here is
>> OK
> I'm not convinced about this.  The issues you mention need to be
> solved in a generic way, not a tegra-specific way.
>
> We don't want to end up with code that silently avoids the config
> access 99.99% of the time, but once in a blue moon, we lose the race
> (the device stops responding after we've determined the link is up)
> and the access causes a mysterious AER error that we have no way to
> debug.
>
>>>> +		*value = 0xffffffff;
>>>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>>>> +	}
>>>> +
>>>>  	return pci_generic_config_read(bus, devfn, where, size, value);
>>>>  }
