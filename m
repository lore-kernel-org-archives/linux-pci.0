Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0210.outbound.protection.outlook.com ([207.46.163.210]:17331
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030242AbaDJUDb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 16:03:31 -0400
From: Stuart Yoder <stuart.yoder@freescale.com>
To: Kim Phillips <Kim.Phillips@freescale.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"tech@virtualopensystems.com" <tech@virtualopensystems.com>,
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	"christoffer.dall@linaro.org" <christoffer.dall@linaro.org>
Subject: RE: [PATCH] driver core: platform: add device binding path
 'driver_override'
Date: Thu, 10 Apr 2014 20:03:15 +0000
Message-ID: <52375b57e4b8493a8563aca98b7ba041@DM2PR03MB352.namprd03.prod.outlook.com>
References: <20140404201818.14389.86188.stgit@bling.home>
 <20140408204726.7a8f4cd6fbd05d0464720b30@freescale.com>
In-Reply-To: <20140408204726.7a8f4cd6fbd05d0464720b30@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Kim Phillips [mailto:kim.phillips@freescale.com]
> Sent: Tuesday, April 08, 2014 8:47 PM
> To: Alex Williamson; gregkh@linuxfoundation.org
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; kvm@vger.kernel.org;
> konrad.wilk@oracle.com; Yoder Stuart-B08248; libvir-list@redhat.com;
> iommu@lists.linux-foundation.org; tech@virtualopensystems.com;
> kvmarm@lists.cs.columbia.edu; linux-kernel@vger.kernel.org; Guenter
> Roeck; christoffer.dall@linaro.org
> Subject: [PATCH] driver core: platform: add device binding path
> 'driver_override'
> 
> Needed by platform device drivers, such as the vfio-platform driver [1],
> in order to bypass the existing OF, ACPI, id_table and name string
> matches,
> and successfully be able to be bound to any device, like so:
> 
> echo vfio-platform >
> /sys/bus/platform/devices/fff51000.ethernet/driver_override
> echo fff51000.ethernet >
> /sys/bus/platform/devices/fff51000.ethernet/driver/unbind
> echo fff51000.ethernet > /sys/bus/platform/drivers_probe
> 
> This mimics "PCI: Introduce new device binding path using
> pci_dev.driver_override" [2], which is an interface enhancement
> for more deterministic PCI device binding, e.g., when in the
> presence of hotplug.
> 
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1402.1/00177.html
> [2] http://lists-archives.com/linux-kernel/28030441-pci-introduce-new-
> device-binding-path-using-pci_dev-driver_override.html
> 
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---

Reviewed-by: Stuart Yoder <stuart.yoder@freescale.com>
