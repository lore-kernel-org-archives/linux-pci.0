Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:20544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeGROMW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jul 2018 10:12:22 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: "poza@codeaurora.org" <poza@codeaurora.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>
Subject: RE: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Date: Wed, 18 Jul 2018 13:34:20 +0000
Message-ID: <BL0PR02MB4849C990B8C0822ECA45746AA5530@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <b5ba83a0fd8694905528f740a186b891@codeaurora.org>
 <BL0PR02MB4849D9F256912CC9B869A20EA5580@BL0PR02MB4849.namprd02.prod.outlook.com>
 <3bd31b729f9f335fcd906a8164c0a4cb@codeaurora.org>
In-Reply-To: <3bd31b729f9f335fcd906a8164c0a4cb@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On 2018-07-13 19:25, Bharat Kumar Gogada wrote:
> >> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
> >> > This bit is required for forwarding errors reported by EP devices
> >> > to upstream device.
> >> > This patch enables SERR# for Type-1 PCI device.
> >> >
> >> > Signed-off-by: Bharat Kumar Gogada
> <bharat.kumar.gogada@xilinx.com>
> >> > ---
> >> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
> >> >  1 files changed, 23 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
> >> > a2e8838..943e084 100644
> >> > --- a/drivers/pci/pcie/aer.c
> >> > +++ b/drivers/pci/pcie/aer.c
> >> > @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct
> >> > pci_dev
> >> > *dev)
> >> >  	if (!dev->aer_cap)
> >> >  		return -EIO;
> >> >
> >> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> >> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> >> > +		u16 control;
> >> > +
> >> > +		/*
> >> > +		 * A Type-1 PCI bridge will not forward ERR_ messages
> >> coming
> >> > +		 * from an endpoint if SERR# forwarding is not enabled.
> >> > +		 */
> >> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> >> &control);
> >> > +		control |=3D PCI_BRIDGE_CTL_SERR;
> >> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> >> > +	}
> >> > +
> >> >  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> >> > PCI_EXP_AER_FLAGS);  }
> >> > EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> >> > @@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct
> >> > pci_dev *dev)
> >> >  	if (pcie_aer_get_firmware_first(dev))
> >> >  		return -EIO;
> >> >
> >> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> >> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
> >> > +		u16 control;
> >> > +
> >> > +		/* Clear SERR Forwarding */
> >> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
> >> &control);
> >> > +		control &=3D ~PCI_BRIDGE_CTL_SERR;
> >> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> >> > +	}
> >> > +
> >> >  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> >> >  					  PCI_EXP_AER_FLAGS);
> >> >  }
> >>
> >>
> >> Should this configuration no be set by Firmware ? why should Linux
> >> dictate it ?
> > Hi Oza, Can you please let us know why this should be set by firmware ?
> > Spec clearly states ERR_CORR,ERR_FATAL/NON FATAL will be forwarded
> > only if this bit is set.
> > If linux AER service is being enabled without checking/setting this
> > bit, then AER service will not do anything even ERR_* is seen on link.
> >
> > Regards,
> > Bharat
>=20
>=20
> The ERR_* to be forwarded or not to be forwarded could be decision of the
> platform.
> hence I think it is best left to firmware to decide if it want to enable =
this for
> particular platform.
>=20
I'm not aware of other platforms, can you please give an example of a platf=
orm=20
how it decides to set this in firmware ?

> although,
> There are 2 cases
> Hotplug capable bridge and otherwise.

Yes, what about an RP which supports only AER but doesn't support Hotplug ?
If we have this patch we can set this bit without firmware also.
>=20
> 1) If Firmware sets them, I do not think during enumeraion linux will loo=
se
> those settings.=20

> 2) I do not see any integration of hotplug with AER currently, so if the =
PCIe
> switch is plugged into Hotplug capable RP, I am not very sure if this fun=
ctions
> get called.
>=20
> Keith, Lukas and Bjorn any comments ?
Hi all, do you have any inputs on this ?

Regards,
Bharat
