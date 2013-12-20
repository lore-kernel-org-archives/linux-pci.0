Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50213 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357Ab3LTQUj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Dec 2013 11:20:39 -0500
Message-ID: <52B46E4D.6020805@ti.com>
Date: Fri, 20 Dec 2013 11:20:29 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: pcie designware question
References: <3E54258959B69E4282D79E01AB1F32B70465DDAD@DFLE11.ent.ti.com> <CAErSpo67jb3MhvoiWKtgymjoz-E3xreRuec8NsO_Mfo7QTiHFw@mail.gmail.com> <2CC2A0A4A178534D93D5159BF3BCB66189F96BAC51@EAPEX1MAIL1.st.com>
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189F96BAC51@EAPEX1MAIL1.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/19/2013 11:21 PM, Mohit KUMAR DCG wrote:
>>> I have reviewed the designware.c code and the glue logic driver
>>> pci-exynos.c and couldn't understand few things.
>>>
>>> 1. Our pcie ss is based on designware core and following addresses are
>>> not listed in our IP's  data manual. Where is defined? It does show
>>> the rest of the offsets defined in  drivers/pci/host/designware.c and
>>>
>>> #define PCIE_ATU_VIEWPORT               0x900
>>> #define PCIE_ATU_REGION_INBOUND         (0x1 << 31)
>>> #define PCIE_ATU_REGION_OUTBOUND        (0x0 << 31)
>>> #define PCIE_ATU_REGION_INDEX1          (0x1 << 0)
>>> #define PCIE_ATU_REGION_INDEX0          (0x0 << 0)
>>> #define PCIE_ATU_CR1                    0x904
>>> #define PCIE_ATU_TYPE_MEM               (0x0 << 0)
>>> #define PCIE_ATU_TYPE_IO                (0x2 << 0)
>>> #define PCIE_ATU_TYPE_CFG0              (0x4 << 0)
>>> #define PCIE_ATU_TYPE_CFG1              (0x5 << 0)
>>> #define PCIE_ATU_CR2                    0x908
>>> #define PCIE_ATU_ENABLE                 (0x1 << 31)
>>> #define PCIE_ATU_BAR_MODE_ENABLE        (0x1 << 30)
>>> #define PCIE_ATU_LOWER_BASE             0x90C
>>> #define PCIE_ATU_UPPER_BASE             0x910
>>> #define PCIE_ATU_LIMIT                  0x914
>>> #define PCIE_ATU_LOWER_TARGET           0x918
>>> #define PCIE_ATU_BUS(x)                 (((x) & 0xff) << 24)
>>> #define PCIE_ATU_DEV(x)                 (((x) & 0x1f) << 19)
>>> #define PCIE_ATU_FUNC(x)                (((x) & 0x7) << 16)
>>> #define PCIE_ATU_UPPER_TARGET           0x91C
> - These are Synopsys specific port logic registers. You can find these registers at offset 0x200
>   under port logic registers section in Synpsys PCIe DM.  There can be minor difference in the name
> convention as it is called 'iATU Viewport Register' in controller version3.70 and 'iATU Index Register'
>   in version 4.11.
> By the way which version of IP manual you are referring?
>
>
Mohit,

I have checked with our hardware team and they confirmed that ATU 
registers are not implemented in our PCIE
SS. So we need to have  a way to disable this in the core driver so 
that  we can handle it in our glue layer driver.
But this will be a regression on the existing driver. How do we handle this?

Murali


