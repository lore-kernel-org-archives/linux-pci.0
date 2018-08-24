Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: "poza@codeaurora.org" <poza@codeaurora.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>
Subject: RE: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
Date: Fri, 24 Aug 2018 12:13:24 +0000
Message-ID: <BL0PR02MB4849845E4161CDC9BE391EB2A5360@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1533826657-24552-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <2f53b7dd9c1464f40b10217eb64d511e@codeaurora.org>
In-Reply-To: <2f53b7dd9c1464f40b10217eb64d511e@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
>=20
> On 2018-08-09 20:27, Bharat Kumar Gogada wrote:
> > As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages will be
> > forwarded from the secondary interface to the primary interface, if
> > the SERR# Enable bit in the Bridge Control register is set.
> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
> > This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
> >  1 files changed, 23 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
> > a2e8838..4fb0d24 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -343,6 +343,20 @@ int pci_enable_pcie_error_reporting(struct
> > pci_dev
> > *dev)
> >  	if (!dev->aer_cap)
> >  		return -EIO;
> >
> > +	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> > +		u16 control;
> > +
> > +		/*
> > +		 * A Type-1 PCI bridge will not forward ERR_ messages
> coming
> > +		 * from an endpoint if SERR# forwarding is not enabled.
> > +		 */
> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> &control);
> > +		if (!(control & PCI_BRIDGE_CTL_SERR)) {
> > +			control |=3D PCI_BRIDGE_CTL_SERR;
> > +			pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
> control);
> > +		}
> > +	}
> > +
> >  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> > PCI_EXP_AER_FLAGS);  }
> > EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> > @@ -352,6 +366,15 @@ int pci_disable_pcie_error_reporting(struct
> > pci_dev *dev)
> >  	if (pcie_aer_get_firmware_first(dev))
> >  		return -EIO;
> >
> > +	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> > +		u16 control;
> > +
> > +		/* Clear SERR Forwarding */
> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> &control);
> > +		control &=3D ~PCI_BRIDGE_CTL_SERR;
> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> > +	}
> > +
> >  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> >  					  PCI_EXP_AER_FLAGS);
> >  }
>=20
>=20
> Hi Bjorn,
>=20
> I made some comments on patchv1., same I am putting it across here.
>=20
> what about hot-plug case ?
> should not aer_init() call pci_enable_pcie_error_reporting() for all the
> downstream pci_dev ?
> and remove all the calls from drivers..
> aer_init will be called for each device (pci_dev) while pciehp does re-
> enumeration.
> so probable we might want to call pci_enable_pcie_error_reporting() but
> that dictates the design where AER framework is taking decision to enable
> error reporting on behalf of drivers as well.
> but thats fine I think, if drivers do not want to participate then they h=
ave to
> call  pci_disable_pcie_error_reporting explicitly.
> does this make sense ?
>=20
Hi Bjorn,
Can you please comment on this.

Bharat
