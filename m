Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47512 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab3LTPm4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Dec 2013 10:42:56 -0500
Message-ID: <52B46577.8040607@ti.com>
Date: Fri, 20 Dec 2013 10:42:47 -0500
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
> Hello Murali,
>
>> ---> Cut <-----
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
Mohit,

Thanks for the reply. I will check with my hardware team. The device 
spec seem to miss this info or this is
not applicable for our PCIE SS.

> -----> Cut <-----
>>> 4. What is the base address variable used to access RC's application
>>> register space? dbi_base in struct pcie_port ? Also I am assuming this
>>> is used for accessing this space from internal CPU bus and cfg0_base and
>> cfg1_base for accessing it from pci bus. Is this right?
> - DBI Space: This space is used to read/write own PCI Configuration Header,
>   Capability and Port Logic (PL) Registers
>   ELBI space: These are completely platform (Spear/Exynosys ...) specific application registers.
> Configuration/IO/Memory space: These addresses can be used in viewport programming to
>   generate different type of outbound transaction.
>
> Regards
> Mohit
Does the core driver use 1 to 1 mapping or  use real address translation?
In the description below by glue driver, I mean the driver for platform
specific wrapper around the designware PCIE core and core driver is the
designware driver.

The PCIE ss in our documentation has application registers at
offset 0x0 of the PCIE cfg memory map of the CPU, 0x1000 is the RC's
config space and 0x2000 is the EP's config space and 0x3000 is the
Downstream IO space. The CPU base address of config space is
0x21800000.The PCIE data space of the DBI is at address 0x50000000
(256M). Each config space is having a size of 4K (0x1000). How do I
setup the DT bindings for this? If there is a mail thread that already
discussed this, please send me a link.

 From your response, I gather dbi_base should be pointing to the RC's
io mapped config space base address (0x21801000). The code in
core driver is assigning cfg0_base to the io mapped address of DT's
configuration space CPU address and cfg1_base to cfg0_base + size/2.

So I need to pass the base of RC's CPU address to CPU address of
the configuration space in DT binding. So EP's CPU address will be mapped
to 0x21802000 assuming a size of 0x2000. Also I need to handle the
application register base internal to my glue driver. Does the following
make sense?


/* Configuration space */
ranges = <0x00000800 0 0x21801000 0x50000000 0 0x0002000
/* downstream I/O */
0x81000000 0 00x50002000 0 0x0010000
/* non-prefetchable memory */
0x82000000 0 0x50012000 0x50012000 0 0xffef000>;

Also For interrupt handling (MSI and Legacy), there is part of the code
to be implemented in the glue driver and part is already in designware
core driver. Is this correct assumption? In our implementation, there
are 4 Host IRQ lines for A,B,C and D interrupt lines and 8 MSI IRQ lines
each multiplexing 4 of the MSI vectors. This code seems to be specific
to the glue driver.

Is there an example DT binding to do this mapping?

Thanks

Murali

