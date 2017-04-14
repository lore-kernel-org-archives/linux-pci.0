Return-Path: <SRS0=sVE/=3W=chromium.org=mka@kernel.org>
Return-Path: <SRS0=sVE/=3W=chromium.org=mka@kernel.org>
Date: Fri, 14 Apr 2017 12:36:05 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mason <slash.tmp@free.fr>,
	Grant Grundler <grundler@chromium.org>,
	Greg Hackmann <ghackmann@google.com>,
	Michael Davidson <md@google.com>
Subject: Re: [PATCH v2] PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant
Message-ID: <20170414193605.GN28657@google.com>
References: <20170411175658.58512-1-mka@chromium.org>
 <20170414154340.GA5864@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170414154340.GA5864@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

El Fri, Apr 14, 2017 at 10:43:40AM -0500 Bjorn Helgaas ha dit:

> On Tue, Apr 11, 2017 at 10:56:58AM -0700, Matthias Kaehlcke wrote:
> > A 64-bit value is not needed since a PCI ROM address consists in 32 bits.
> > This fixes a clang warning about "implicit conversion from 'unsigned
> > long' to 'u32'".
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - Define PCI_ROM_ADDRESS_MASK as a 32-bit constant instead of using a cast
> > - Updated commit message
> > 
> >  include/uapi/linux/pci_regs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 634c9c44ed6c..fff521c9458c 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -114,7 +114,7 @@
> >  #define PCI_SUBSYSTEM_ID	0x2e
> >  #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
> >  #define  PCI_ROM_ADDRESS_ENABLE	0x01
> > -#define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
> > +#define PCI_ROM_ADDRESS_MASK	(~0x7ffU)
> 
> Does this mean we can remove the "(u32)" casts in __pci_read_base() and
> pci_std_update_resource()?

Indeed

> If so, can you do that in the same patch?

Will do

Matthias
