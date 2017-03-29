Return-Path: <SRS0=US7a=3G=amd.com=Kelly.Zytaruk@kernel.org>
Return-Path: <SRS0=US7a=3G=amd.com=Kelly.Zytaruk@kernel.org>
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Alex Williamson
	<alex.williamson@redhat.com>
CC: Bjorn Helgaas <helgaas@kernel.org>
Subject: Having problems resetting a PCI device
Date: Wed, 29 Mar 2017 20:03:33 +0000
Message-ID: <DM2PR12MB00780139E84F5B961AD4AB6CFE350@DM2PR12MB0078.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

I have a PCI device that is sitting behind a bridge.=20

Under certain reproducible circumstances the PCI device will become inactiv=
e. Reading the PCI config space returns all 0xFFFFFFFF.

The bridge appears to still be functional. Reading the status from the brid=
ge I see a Fatal Error due to a Surprise Down event.

I am trying to figure out how to bring the device back online.

I tried toggling the secondary bus reset bit of the Bridge Control Register=
 but it doesn't appear to make any difference. I still see 0xFFFFFFFF in th=
e device config space.

I provided a pci_error_handler but the error_detected() function is not get=
ting called.

Given that these two methods are not helping me out what other choices do I=
 have to either reset the PCI device or hot-plug the device from a kernel d=
river. Or some other method of bring the device back to life.

Note that I am running Linux 4.8 in dom0 on Xen (if that makes a difference=
).

Thanks,
Kelly
