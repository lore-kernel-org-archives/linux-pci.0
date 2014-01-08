Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:40385 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751456AbaAHGzw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2014 01:55:52 -0500
Date: Wed, 8 Jan 2014 12:25:35 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: pcie designware question
Message-ID: <20140108065535.GC2689@pratyush-vbox>
References: <3E54258959B69E4282D79E01AB1F32B70465DDAD@DFLE11.ent.ti.com>
 <CAErSpo67jb3MhvoiWKtgymjoz-E3xreRuec8NsO_Mfo7QTiHFw@mail.gmail.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189F96BAC51@EAPEX1MAIL1.st.com>
 <52B46E4D.6020805@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <52B46E4D.6020805@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 21, 2013 at 12:20:29AM +0800, Murali Karicheri wrote:
> On 12/19/2013 11:21 PM, Mohit KUMAR DCG wrote:
> >>> I have reviewed the designware.c code and the glue logic driver
> >>> pci-exynos.c and couldn't understand few things.
> >>>
> >>> 1. Our pcie ss is based on designware core and following addresses are
> >>> not listed in our IP's  data manual. Where is defined? It does show
> >>> the rest of the offsets defined in  drivers/pci/host/designware.c and
> >>>
> >>> #define PCIE_ATU_VIEWPORT               0x900
> >>> #define PCIE_ATU_REGION_INBOUND         (0x1 << 31)
> >>> #define PCIE_ATU_REGION_OUTBOUND        (0x0 << 31)
> >>> #define PCIE_ATU_REGION_INDEX1          (0x1 << 0)
> >>> #define PCIE_ATU_REGION_INDEX0          (0x0 << 0)
> >>> #define PCIE_ATU_CR1                    0x904
> >>> #define PCIE_ATU_TYPE_MEM               (0x0 << 0)
> >>> #define PCIE_ATU_TYPE_IO                (0x2 << 0)
> >>> #define PCIE_ATU_TYPE_CFG0              (0x4 << 0)
> >>> #define PCIE_ATU_TYPE_CFG1              (0x5 << 0)
> >>> #define PCIE_ATU_CR2                    0x908
> >>> #define PCIE_ATU_ENABLE                 (0x1 << 31)
> >>> #define PCIE_ATU_BAR_MODE_ENABLE        (0x1 << 30)
> >>> #define PCIE_ATU_LOWER_BASE             0x90C
> >>> #define PCIE_ATU_UPPER_BASE             0x910
> >>> #define PCIE_ATU_LIMIT                  0x914
> >>> #define PCIE_ATU_LOWER_TARGET           0x918
> >>> #define PCIE_ATU_BUS(x)                 (((x) & 0xff) << 24)
> >>> #define PCIE_ATU_DEV(x)                 (((x) & 0x1f) << 19)
> >>> #define PCIE_ATU_FUNC(x)                (((x) & 0x7) << 16)
> >>> #define PCIE_ATU_UPPER_TARGET           0x91C
> > - These are Synopsys specific port logic registers. You can find these registers at offset 0x200
> >   under port logic registers section in Synpsys PCIe DM.  There can be minor difference in the name
> > convention as it is called 'iATU Viewport Register' in controller version3.70 and 'iATU Index Register'
> >   in version 4.11.
> > By the way which version of IP manual you are referring?
> >
> >
> Mohit,
> 
> I have checked with our hardware team and they confirmed that ATU 
> registers are not implemented in our PCIE

Which PCIe designware IP version you are using? At least since version 3.71
support of viewport is available in IP. Older version was handling
address translation using side band signals implemented through
vendor specific application registers. May be your case is also
similar.

> SS. So we need to have  a way to disable this in the core driver so 
> that  we can handle it in our glue layer driver.
> But this will be a regression on the existing driver. How do we handle this?

May be you can add rd/wr_other_conf in struct pcie_host_ops. 
Change designware driver to handle vendor specific rd/wr_other_conf,
if it exists, else use generic rd/wr_other_conf.

In your vendor specific rd/wr_other_conf handler you can implement
translation using your application registers.

Regards
Pratyush
> 
> Murali
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
