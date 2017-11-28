Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753128AbdK1O5u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Nov 2017 09:57:50 -0500
Date: Tue, 28 Nov 2017 08:57:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [Question] Unsupported Request During PCI Enumeration
Message-ID: <20171128145748.GD11228@bhelgaas-glaptop.roam.corp.google.com>
References: <26340670-2744-b2e0-eed7-eb8e0ad2bc84@huawei.com>
 <20171128003208.GB11228@bhelgaas-glaptop.roam.corp.google.com>
 <c1235398-9a80-b4f3-94c9-3686651259fc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <c1235398-9a80-b4f3-94c9-3686651259fc@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 28, 2017 at 11:59:52AM +0800, Dongdong Liu wrote:
> 在 2017/11/28 8:32, Bjorn Helgaas 写道:
> >On Wed, Nov 22, 2017 at 03:38:59PM +0800, Dongdong Liu wrote:
> >>I found a correctable error when boot linux kernel. The corrected
> >>error is UR (Unsupported Request). It seems that PCIe device will
> >>produce UR during PCIe enumeration.
> >
> >It seems normal to me that UR would be reported during enumeration.
> >During enumeration we don't know what devices are present, so we
> >attempt to read the Vendor ID of each possible device.  If the device
> >doesn't exist, I would expect the upstream switch port to generate a
> >UR completion.  See the implementation notes in PCIe r3.1, sec 2.3.1
> >and sec 2.3.2.
> >
> >Is this what you're seeing?  Do you think this is wrong?
> 
> Yes, lspci -tv is as bleow.
> root@(none)$ lspci -tv
> -[0000:00]-+-00.0-[01-02]--+-00.0  Device 15b3:1015
>            |               \-00.1  Device 15b3:1015
>            \-08.0-[03-09]----00.0-[04-09]--+-04.0-[05]--
>                                            +-05.0-[06-07]--+-00.0  Device 8086:10fb
>                                            |               \-00.1  Device 8086:10fb
>                                            +-08.0-[08]--
>                                            \-09.0-[09]--
> 
> Switch upstream port 03:00.0 and downstream ports 04:04.0,04:08.0,04:09.0
> all have UR. UR will set DevSta (UnsuppReq+) and CESta (NonFatalErr+).
> DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
> CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+

OK, so I think this is what we should expect to see, given how PCIe
works and the current Linux code.  The problem is that the UR errors
that occur as a normal part of enumeration might be reported, which
causes confusion.  They also remain set in the Device Status register,
which means we can't tell whether an unexpected UR occurred *after*
enumeration.

I propose that we either disable UR reporting during enumeration or
clear out the UR errors after enumeration.  That way, when we are
finished with enumeration there should be no errors logged, and we can
get useful information UR errors that occur *after* enumeration.

> >>We have configured _HPX in firmware to make sure UR report is
> >>enabled after calling pci_configure_device().

It's OK for you to supply _HPX, but I would suggest that Linux could
enable UR reporting itself (at least when it enables AER).  This seems
like a generic thing we can do in the kernel without requiring every
platform to supply _HPX.

> >>If I disable UR report by setting Device Control Register
> >>Unsupported Request Reporting Enable to 0 ,it will not report the
> >>correctable error.  But disable UR report is not responsible, so my
> >>question is how to make sure it does not report the correctable
> >>error during enumeration and after enumeration, PCIe device can
> >>report UR correctly ?
> >
> >Per spec, the hardware power-on default is that Unsupported Request
> >Reporting Enable is 0, i.e., UR reporting is disabled.
> >
> >Firmware may enable UR reporting.  It looks like the PCI core enables
> >UR reporting in pci_enable_pcie_error_reporting() when we enable AER
> 
> Yes, enable AER, this will enable UR for RP, UP/DP devices (not include EP devices),
> But current code have a bug for UP/DP as said in
> [RFC PATCH] PCI/portdrv: Fix switch devctrl error report enable.
> https://patchwork.kernel.org/patch/10003757/

Yep, we need to fix that, as well as figure out a way to enable UR
reporting for endpoints.

> aer_enable_rootport
>     set_downstream_devices_error_reporting(root, true)
>       set_device_error_reporting(root, true)
>         pci_enable_pcie_error_reporting
>           pcie_capability_set_word(root, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS)
>         pci_walk_bus(root->subordinate set_device_error_reporting, true)
>           set_device_error_reporting(dev, true)
> static int set_device_error_reporting(struct pci_dev *dev, void *data)
> {
> 	bool enable = *((bool *)data);
> 	int type = pci_pcie_type(dev);
> 
> 	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
> 	    (type == PCI_EXP_TYPE_UPSTREAM) ||
> 	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
> 		if (enable)
> 			pci_enable_pcie_error_reporting(dev);
> 		else
> 			pci_disable_pcie_error_reporting(dev);
> 	}
> 
> 	if (enable)
> 		pcie_set_ecrc_checking(dev);
> 
> 	return 0;
> }
> >(and a few drivers call pci_enable_pcie_error_reporting() directly).
> 
> Yes, a few drivers call pci_enable_pcie_error_reporting(), like intel
> PCIe netcard drivers, but mellanox netcard drivers do not call
> pci_enable_pcie_error_reporting().

> >We do turn off Master Abort reporting in pci_scan_bridge_extend() when
> >scanning below a bridge.  UR reporting during enumeration seems
> >analogous to that, but we don't currently turn it off.
> >
> >Maybe we should turn off UR reporting and restore it afterwards, as we
> >do for PCI_BRIDGE_CTL_MASTER_ABORT?
> 
> Yes, we can configure ACPI _HPX to turn off UR reporting.
> or for DT, just set Device Control Register to turn off UR reporting after
> calling pci_configure_device().
> 
> But as above said, only a few drivers called pci_enable_pcie_error_reporting().
> Some PCIe device drivers do not call pci_enable_pcie_error_reporting(),
> Such devices UR reporting will always be turned off.

I do not think drivers should be calling
pci_enable_pcie_error_reporting() directly.  And I don't think we
should depend on _HPX.  _HPX is intended for *platform-specific*
things, and I don't think this is platform-specific.  And of course,
_HPX only works on ACPI systems, and we want this to work everywhere.

So I think we need a more comprehensive generic solution in Linux.  I
think we need several pieces:

  - Disable UR reporting during enumeration, similar to how we disable
    Master Abort reporting.

  - Restore original UR reporting setting after enumeration.

  - Clear any logged UR errors after enumeration.

  - Enable UR reporting as part of configuring every device, e.g., in
    pci_configure_device() or pci_init_capabilities().

I don't know whether we should enable UR reporting if AER is not
present; we'll have to think about that.  We may also have to
restructure how the AER driver works, because I think it currently
comes into play *after* we call pci_init_capabilities().  There are
probably some ordering issues there.

Bjorn
