Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:46056 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932703AbeEaPkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 May 2018 11:40:42 -0400
Cc: <Austin.Bolen@dell.com>, <Shyam.Iyer@dell.com>,
        <keith.busch@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: <Alex_Gagniuc@Dellteam.com>
To: <okaya@codeaurora.org>, <mr.nuke.me@gmail.com>,
        <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
Date: Thu, 31 May 2018 15:29:23 +0000
Message-ID: <4e0611c872054e768daa96b302651db3@ausx13mps321.AMER.DELL.COM>
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
 <28004506-24f0-6d10-2d1e-074e0483d2f9@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/31/2018 10:28 AM, Sinan Kaya wrote:=0A=
> On 5/31/2018 11:05 AM, Alexandru Gagniuc wrote:=0A=
>> +static void pcie_max_link_cap(struct pci_dev *dev, enum pci_bus_speed *=
speed,=0A=
>> +				enum pcie_link_width *width)=0A=
>> +{=0A=
>> +	uint32_t lnkcap;=0A=
>> +=0A=
>> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);=0A=
>> +=0A=
>> +	*speed =3D pcie_link_speed[lnkcap & PCI_EXP_LNKCAP_SLS];=0A=
>> +	*width =3D (lnkcap & PCI_EXP_LNKCAP_MLW) >> PCI_EXP_LNKCAP_MLW_SHIFT;=
=0A=
>> +}=0A=
>> +=0A=
>> +static void pcie_cur_link_sta(struct pci_dev *dev, enum pci_bus_speed *=
speed,=0A=
>> +				enum pcie_link_width *width)=0A=
>> +{=0A=
>> +	uint16_t lnksta;=0A=
>> +=0A=
>> +	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);=0A=
>> +	*speed =3D pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];=0A=
>> +	*width =3D (lnksta & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;=
=0A=
>> +}=0A=
>> +=0A=
>> +static const char *pcie_bus_speed_name(enum pci_bus_speed speed)=0A=
>> +{=0A=
>> +	switch (speed) {=0A=
>> +	case PCIE_SPEED_2_5GT:=0A=
>> +		return "2.5 GT/s";=0A=
>> +	case PCIE_SPEED_5_0GT:=0A=
>> +		return "5.0 GT/s";=0A=
>> +	case PCIE_SPEED_8_0GT:=0A=
>> +		return "8.0 GT/s";=0A=
>> +	default:=0A=
>> +		return "unknown";=0A=
>> +	}=0A=
>> +}=0A=
> =0A=
> I thought Bjorn added some functions to retrieve this now.=0A=
=0A=
Hmm. I couldn't find them.=0A=
=0A=
Alex=0A=
=0A=
