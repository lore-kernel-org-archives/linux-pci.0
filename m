Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36201 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964831AbbJ0QVH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 27 Oct 2015 12:21:07 -0400
Date: Tue, 27 Oct 2015 11:20:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [PATCH v4 1/4] PCI: designware: Use common LTSSM_STATE_MASK
 definition
Message-ID: <20151027162056.GA16564@localhost>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151021184250.28724.41928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151027151542.GF8660@localhost>
 <CAOMZO5CYTd+VKj8h6iP_g1A_OAHuFYhM=-wfS5+PzshkbFFnyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5CYTd+VKj8h6iP_g1A_OAHuFYhM=-wfS5+PzshkbFFnyg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 27, 2015 at 02:05:17PM -0200, Fabio Estevam wrote:
> Hi Bjorn,
> 
> On Tue, Oct 27, 2015 at 1:15 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > [+cc Minghuan]
> >
> > On Wed, Oct 21, 2015 at 01:42:50PM -0500, Bjorn Helgaas wrote:
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> Add a common #define for LTSSM_STATE_MASK and use it in all the
> >> DesignWare-based drivers.
> >>
> >> Note that this changes LTSSM_STATE_MASK from 6 bits (0x3f) to 5 bits (0x1f)
> >> for i.MX6 and Layerscape.  We believe this is safe for all DesignWare-based
> >> PCIe cores.
> >
> > OK, DesignWare experts, what's the story on this LTSSM_STATE_MASK?
> >
> > Minghuan says Layerscape requires a mask of 0x3f and it actually uses
> > states 0x20, 0x21, 0x22, and 0x23:
> >
> > MH> Our LTSSM mask is 0x3f because it includes the following states:
> > MH> 0x20 S_RCVRY_EQ0
> > MH> 0x21 S_RCVRY_EQ1
> > MH> 0x22 S_RCVRY_EQ2
> > MH> 0x23 S_RCVRY_EQ3
> >
> > MH> And I checked DesignWare Cores PCI Express Controller Databook
> > MH> v4.21a and found the following descriptor:
> >
> > MH> [5:0]: smlh_ltssm_state: LTSSM current state. Encoding is defined in workspace/src/include/cxpl_defs.vh
> >
> > MH> So could we use the mask 0x3f for all SoCs?
> >
> > I couldn't find the "DesignWare Cores PCI Express Controller Databook
> > v4.21a", but I do see the Keystone mask (sec 3.9.11 of
> > http://www.ti.com/lit/ug/sprugs6d/sprugs6d.pdf) is definitely only 5
> > bits, but that's clearly a TI register, not a generic DesignWare
> > register.
> >
> > So it looks like a mistake to make a common LTSSM_STATE_MASK
> > definition.  It looks like this is something with some variation and
> > we shouldn't make assumptions about it being common.
> 
> Yes, what if we keep the original behaviour: define a common
> LTSSM_STATE_MASK as 0x3f and then add KS_LTSSM_STATE_MASK as 0x1f for
> Keystone only?
> 
> >
> > Now I'm concerned that the LTSSM state definitions I put in
> > drivers/pci/host/pcie-designware.h might not actually apply to
> > everything derived from DW.  For example, the Layerscape S_RCVRY
> > states appear to be Layerscape-specific.
> >
> > I don't want to put misleading stuff in
> > drivers/pci/host/pcie-designware.h if it's not really generic.  Better
> > to have it in the individual drivers, with a prefix that indicates
> > that it applies to that driver, e.g., KS_LTSSM_MASK, LS_LTSSM_MASK,
> > etc.
> 
> The LTSSM states we put in drivers/pci/host/pcie-designware.h are from
> 0-1f, so they are common.

Well, maybe.  Are those states documented in the DesignWare spec?  I
don't want to put things in pcie-designware.h that are only common by
accident or even by convention.  We should only put things there if
they are documented things that users of that IP can rely on.

LTSSM_MASK is documented in the TI Keystone spec, so its definition
probably belongs in pci-keystone-dw.c.  The same TI spec also contains
LTSSM state definitions, so I suspect they're in the same boat --
things that might accidentally be the same across devices, but they
don't *have* to be.

So I'm going to drop the following patches from my tree for now:

  1ad5fdbc8410 PCI: designware: Add LTSSM state definitions
  b09464f77dd2 PCI: designware: Use common LTSSM_STATE_L0 definition
  fa15c15fd95d PCI: designware: Use common LTSSM_STATE_RCVRY_LOCK definition
  4788fe6ebf45 PCI: designware: Use common LTSSM_STATE_MASK definition

We can add pieces back if they make sense.  If we add things to shared
files like pcie-designware.h, I'd like a reference to the DW spec that
justifies the sharing.

Bjorn
