Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:49271 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbaKDLof convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Nov 2014 06:44:35 -0500
Date: Tue, 4 Nov 2014 11:44:28 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Simon Horman <horms@verge.net.au>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [RFC PATCH 2/2] arm: pcibios: move to generic PCI domains
Message-ID: <20141104114428.GA11102@e106497-lin.cambridge.arm.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
 <b095e031880c44f0b79c8c42bc8d7bd5@SIXPR06MB0639.apcprd06.prod.outlook.com>
 <CAErSpo7R5V1MeDSg+9-+CqVbk_vDn6pRsNwFQS9L97Fkw=7nDA@mail.gmail.com>
 <08260858dd004e4881e7fbd4b23ea795@SIXPR06MB0639.apcprd06.prod.outlook.com>
 <20141103232625.GA22642@verge.net.au>
MIME-Version: 1.0
In-Reply-To: <20141103232625.GA22642@verge.net.au>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 03, 2014 at 11:26:25PM +0000, Simon Horman wrote:
> On Fri, Oct 31, 2014 at 05:04:49PM +0000, Phil Edworthy wrote:
> > Hi Bjorn,
> > 
> > On 31 October 2014 16:37, Bjorn wrote:
> > > On Fri, Oct 31, 2014 at 7:43 AM, Phil Edworthy
> > > <phil.edworthy@renesas.com> wrote:
> > > > Hi Lorenzo,
> > > >
> > > > On 30 October 2014 11:45, Lorenzo wrote:
> > > >> Most if not all ARM PCI host controller device drivers either ignore the
> > > >> domain field in the pci_sys_data structure or just increment it every
> > > >> time a host controller is probed, using it as a domain counter.
> > > >>
> > > >> Therefore, instead of relying on pci_sys_data to stash the domain number
> > > >> in a standard location, ARM pcibios code can be moved to the newly
> > > >> introduced generic PCI domains code, implemented in commits:
> > > >>
> > > >> commit 41e5c0f81d3e676d671d96a0a1fafb27abfbd9
> > > >> ("of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr()")
> > > >>
> > > >> commit 670ba0c8883b576d0aec28bd7a838358a4be1
> > > >> ("PCI: Add generic domain handling")
> > > >>
> > > >> In order to assign a domain number dynamically, the ARM pcibios defines
> > > >> the function, called by core PCI code:
> > > >>
> > > >> void pci_bus_assign_domain_nr(...)
> > > >>
> > > >> that relies on a DT property to define the domain number or falls back to
> > > >> a counter; its usage replaces the current domain assignment code in PCI
> > > >> host controllers present in the kernel.
> > > >>
> > > >> Cc: Arnd Bergmann <arnd@arndb.de>
> > > >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > > >> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > > >> Cc: Jingoo Han <jg1.han@samsung.com>
> > > >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > >> Cc: Russell King <linux@arm.linux.org.uk>
> > > >> Cc: Mohit Kumar <mohit.kumar@st.com>
> > > >> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > >
> > > > This patch fixes a current problem with R-Car devices where there is an
> > > > internal PCI bridge and an external PCIe bridge on the devices. Both drivers
> > > > work independently but need to be on different domains. Just needed to
> > > enable
> > > > PCI_DOMAINS along with this.
> > > > I've done basic testing that the internal PCI and external PCIe work at the
> > > > same time.
> > > 
> > > Hi Phil,
> > > 
> > > Thanks for testing this.  Can you give me some more guidance on where
> > > you'd like to see this merged?  Until your comment about this fixing a
> > > current problem on R-Car, I probably would have considered this to be
> > > a cleanup and enhancement and hence material for v3.19.  But if R-Car
> > > is actually broken and this fixes it, maybe this should go in for
> > > v3.18 instead.
> > I don’t think its urgent as most of our customers use LTSI kernels, e.g. v3.10.
> > Renesas typically provide out-of-tree BSPs with upstream code back ported, along
> > with other patches. Simon Horman (Renesas maintainer, cc'd) generally handles
> > the back ports, so I'll defer to his opinion.
> 
> Hi Phil,
> 
> from my point of view it would be best if this went into -stable if it is a
> fix. However, as you point out, from a customer point of view it shouldn't
> be a big deal as they should get backports via our LTSI kernel regardless of
> if the patch goes through stable or not.

Unfortunately this patch depends on a series that only got in in v3.18-rc1, so
I don't think -stable is a workable target.

Best regards,
Liviu

> 
> > > If it is currently broken, is there a point where it broke?  I assume
> > > it used to work at one time.  If there's a commit that broke it, it
> > > would be nice to reference that in the changelog and explain exactly
> > > what was broken and how this fixes it.
> > Both the internal PCI and external PCIe drivers work on their own, but have
> > never worked at the same time. I think it was just unfortunate timing when I
> > added the PCIe driver. At that time, the internal PCI driver didn’t have the
> > relevant DT nodes for the board I was using so I didn't see any conflicts.
> > 
> > Thanks
> > Phil
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

