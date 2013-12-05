Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:18324
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756294Ab3LEAo6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Dec 2013 19:44:58 -0500
From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
To: Marek Vasut <marex@denx.de>
CC: Jingoo Han <jg1.han@samsung.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Frank Li' <lznuaa@gmail.com>, 'Harro Haan' <hrhaan@gmail.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Srikanth T Shivanand' <ts.srikanth@samsung.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>,
	'Yinghai Lu' <yinghai@kernel.org>
Subject: RE: [PATCH 2/7] [RFC] PCI: imx6: remove outbound io/mem ATU region
 mapping
Date: Thu, 5 Dec 2013 00:44:54 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D47C9FA@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1385500248-6551-1-git-send-email-marex@denx.de>
 <201311281856.10139.marex@denx.de>
 <0E83723C55F66F43A6041464FE31119D47BDD2@039-SN2MPN1-013.039d.mgd.msft.net>
 <201312040852.01269.marex@denx.de>
In-Reply-To: <201312040852.01269.marex@denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek:



> -----Original Message-----
> From: Marek Vasut [mailto:marex@denx.de]
> Sent: Wednesday, December 04, 2013 3:52 PM
> To: Zhu Richard-R65037
> Cc: Jingoo Han; 'Tim Harvey'; 'Pratyush Anand'; linux-arm-
> kernel@lists.infradead.org; linux-pci@vger.kernel.org; 'Bjorn Helgaas'; 'Frank
> Li'; 'Harro Haan'; 'Mohit KUMAR DCG'; 'Sascha Hauer'; 'Sean Cross'; 'Shawn
> Guo'; 'Siva Reddy Kallam'; 'Srikanth T Shivanand'; 'Troy Kisky'; 'Yinghai Lu'
> Subject: Re: [PATCH 2/7] [RFC] PCI: imx6: remove outbound io/mem ATU region
> mapping
> 
> On Wednesday, December 04, 2013 at 06:49:55 AM, Richard Zhu wrote:
> > Hi Marek:
> >
> > Best Regards
> > Richard Zhu
> >
> > > -----Original Message-----
> > > From: Marek Vasut [mailto:marex@denx.de]
> > > Sent: Friday, November 29, 2013 1:56 AM
> > > To: Jingoo Han
> > > Cc: 'Tim Harvey'; 'Pratyush Anand';
> > > linux-arm-kernel@lists.infradead.org;
> > > linux-pci@vger.kernel.org; 'Bjorn Helgaas'; 'Frank Li'; 'Harro
> > > Haan'; 'Mohit KUMAR DCG'; Zhu Richard-R65037; 'Sascha Hauer'; 'Sean
> > > Cross'; 'Shawn Guo'; 'Siva Reddy Kallam'; 'Srikanth T Shivanand';
> > > 'Troy Kisky'; 'Yinghai Lu' Subject: Re: [PATCH 2/7] [RFC] PCI: imx6:
> > > remove outbound io/mem ATU region mapping
> > >
> > > Dear Jingoo Han,
> > >
> > > > On Wednesday, November 27, 2013 5:44 PM, Marek Vasut wrote:
> > > > > Wednesday, November 27, 2013 1:30 PM, Pratyush Anand wrote:
> > > > > > On Wed, Nov 27, 2013 at 05:10:43AM +0800, Marek Vasut wrote:
> > > > > > > From: Tim Harvey <tharvey@gateworks.com>
> > > > > > >
> > > > > > > The IMX6 iATU is used for address translation between the
> > > > > > > AXI bus address space and PCI address space.  This is used
> > > > > > > for type0 and
> > > > > > > type1 config cycles but is not necessary for outbound io/mem
> > > > > > > regions.
> > > > > > >
> > > > > > > This patch removes the calls that inappropriately
> > > > > > > re-configures the ATU viewport for outbound memory and IO
> > > > > > > after config cycles and removes them altogether as they are not
> necessary.
> > > > > >
> > > > > > Yes, they are not necessary for all the cases where
> > > > > > translation is one to one. So so for sure all the platform
> > > > > > till now introduced should work.
> > > > > > But, what about a platform where memory translation is not one
> > > > > > to one?
> > > > > >
> > > > > > Existing code should work with all sort of memory translation
> > > > > > on a platform having atleast two viewports capable of
> > > > > > programming any type of outbound transaction.
> > > > >
> > > > > Full ACK, that's why it's called RFC.
> > > > >
> > > > > > > This resolves issues with PCI devices behind switches and
> > > > > > > has been tested with a Gige device behind a PLX PEX860x switch.
> > > > > > > More testing is needed for other configurations.
> > > > > >
> > > > > > I do not understand if MX6 has 4 Outbound Viewport then how
> > > > > > this patch helps?
> > > > > > -- PCI devices behind switches would not have been working
> > > > > > because
> > > > > > CFG1 transaction would not have been correct.
> > > > > > -- It works with this patch. This patch changes viewport for
> > > > > > CFG1 from
> > > > > > 1 to 0.
> > > > > > -- Can it be possible that MX6 has some restriction on
> > > > > > viewport programming capability. I mean,like only viewport0
> > > > > > can be programmed for CFG0/1?
> > > > >
> > > > > Tim ?
> > > > >
> > > > > Here is the MX6 datasheet [1], the section 48.3.9.1.1 and
> > > > > 48.3.9.1.2 describe the iATU configuration on MX6. My
> > > > > understanding from this description is that the MX6 has 4
> > > > > inbound and 4 outbound iATU regions. Am I wrong ?
> > > >
> > > > The numbers of inbound and outbound are hardware-configurable features.
> > > > Thus, these numbers  can be confirmed by Freescale  hardware engineers.
> > > > How about asking Freescale hardware engineers, if possible?
> > >
> > > Richard is on the CC. Richard, can you please confirm those?
> >
> > [Richard] One Pericom PI7C9X2G303EL pcie switch, and two pcie ep
> > deivces(one is intel e1000e nic, the other is one xhci device) are
> > tested on imx6q sabresd board. Without removing outbound io/mem
> > regions view map during the cfg0/1 read/write cycle, both of these
> > devices can't work well at my side. Works well after remove them
> > during the cfg0/1 read/write cycles.
> > Same to Tim's situation about switch implementation.
> 
> Thanks Richard! I am just wondering what kind of conclusion can we draw from
> this. Let me reiterate what we have:
> 
> - i.MX6 has 4 inbound and 4 outbound iATU regions, is that correct, Richard?
> - If we program the iATU regions, the i.MX6 PCIe doesn't work with switch.
> 
> Is there some special sause to the iATU on MX6 maybe ?
[Richard] welcome, it's correct, imx6 pcie has 4 inbount and 4 outbound iATU regions.
Imx6 pcie doesn't work with switch if the following view switches are not removed in
The cfg0/1 read/write cycles.

@@ -516,9 +560,11 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
        if (bus->parent->number == pp->root_bus_nr) {
                dw_pcie_prog_viewport_cfg0(pp, busdev);
                ret = cfg_read(pp->va_cfg0_base + address, where, size, val);
+               // dw_pcie_prog_viewport_mem_outbound(pp);
        } else {
                dw_pcie_prog_viewport_cfg1(pp, busdev);
                ret = cfg_read(pp->va_cfg1_base + address, where, size, val);
+               // dw_pcie_prog_viewport_io_outbound(pp);
        }

        return ret;
@@ -537,9 +583,11 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
        if (bus->parent->number == pp->root_bus_nr) {
                dw_pcie_prog_viewport_cfg0(pp, busdev);
                ret = cfg_write(pp->va_cfg0_base + address, where, size, val);
+               // dw_pcie_prog_viewport_mem_outbound(pp);
        } else {
                dw_pcie_prog_viewport_cfg1(pp, busdev);
                ret = cfg_write(pp->va_cfg1_base + address, where, size, val);
+               // dw_pcie_prog_viewport_io_outbound(pp);
        }

        return ret;

Best Regards
Richard Zhu


