Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0048.outbound.protection.outlook.com ([104.47.38.48]:12211
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732937AbeHARyC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Aug 2018 13:54:02 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Date: Wed, 1 Aug 2018 16:07:32 +0000
Message-ID: <BL0PR02MB48498160C3F18B81DC1ED6C1A52D0@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20180731224706.GO45322@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180731224706.GO45322@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> Subject: Re: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
>=20
> On Thu, Jul 12, 2018 at 08:15:19PM +0530, Bharat Kumar Gogada wrote:
> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
> > This bit is required for forwarding errors reported by EP devices to
> > upstream device.
> > This patch enables SERR# for Type-1 PCI device.
>=20
> This does seem broken.
>=20
> Figure 6-3 in PCIe r4.0, sec 6.2.6, would be a helpful reference to inclu=
de in
> the commit log.
Yes, will include it.
>=20
> Semi-related question: there are about 40 drivers that call
> pci_enable_pcie_error_reporting() and
> pci_disable_pcie_error_reporting().  I see that the PCI core calls
> pci_enable_pcie_error_reporting() for Root Ports and Switch Ports in this
> path:
>=20
>   aer_probe                     # for root ports only
>     aer_enable_rootport
>       set_downstream_devices_error_reporting
>         set_device_error_reporting
>           if (ROOT_PORT || UPSTREAM || DOWNSTREAM)
>             pci_enable_pcie_error_reporting
>         pci_walk_bus(..., set_device_error_reporting)
>=20
> But the core doesn't call pci_enable_pcie_error_reporting() for endpoints=
.  I
> wonder why not.  Could we?  And then remove the calls from those drivers?
Yes, enabling error reporting on endpoints by AER driver makes sense as thi=
s is=20
not an optional feature like AER capability.=20
> If PCI_EXP_AER_FLAGS should only be set if the driver is prepared, the
> pci_driver.err_handler would be a good hint.
> But I suspect we could do something sensible and at least report errors e=
ven
> if the driver doesn't have err_handler callbacks.
Yes, at least reporting errors irrespective of err_handler is acceptable.=20
As you mentioned not all drivers are calling pci_enable_pcie_error_reportin=
g ,
if AER service enable's this independent of err_handler,
this would be useful for old endpoint device drivers which are not calling =
this.
PCI_EXP_AER_FLAGS can be set if pci_dev.driver independent of err_handler.
>=20
> On MIPS Octeon, it looks like pcibios_plat_dev_init() does already set
> PCI_EXP_AER_FLAGS for every device.
>=20
> But this question is obviously far beyond the scope of this current patch=
.
>=20
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
> >  1 files changed, 23 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
> > a2e8838..943e084 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct
> pci_dev *dev)
> >  	if (!dev->aer_cap)
> >  		return -EIO;
> >
> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
> > +	    dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
>=20
> I think this test needs to be refined a little bit.  If the kernel happen=
s to be
> built with CONFIG_ACPI=3Dy but the current platform doesn't support ACPI,=
 we
> still want to set PCI_BRIDGE_CTL_SERR, don't we?
Agreed, will refine it and resend.

Thanks,
Bharat
