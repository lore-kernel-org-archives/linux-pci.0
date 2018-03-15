Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sg2apc01on0130.outbound.protection.outlook.com ([104.47.125.130]:42568
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752337AbeCORzT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Mar 2018 13:55:19 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: RE: [PATCH v4 1/2] PCI: hv: Serialize the present and eject work
 items
Date: Thu, 15 Mar 2018 17:55:03 +0000
Message-ID: <KL1P15301MB00064712309002FB85341ACDBFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006C96F94181FFB93A222D8BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180315170131.GA22134@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180315170131.GA22134@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, March 15, 2018 10:02
> On Thu, Mar 15, 2018 at 02:20:53PM +0000, Dexuan Cui wrote:
> > When we hot-remove the device, we first receive a PCI_EJECT message and
> > then receive a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=
=3D
> 0.
> >
> > The first message is offloaded to 	(), and the second
> > is offloaded to pci_devices_present_work(). Both the paths can be runni=
ng
> > list_del(&hpdev->list_entry), causing general protection fault, because
> > system_wq can run them concurrently.
> >
> > The patch eliminates the race condition.
> >
> > Cc: stable@vger.kernel.org
>=20
> I need to know either what commit you are fixing (ie Fixes: tag - which
> is preferrable) or you tell me which kernel versions we are targeting
> for the stable backport.
>=20
> Thanks,
> Lorenzo

Sorry.  Here I was hesitant to add a "Fixes:" because the bug was there the=
 first day
when the driver was introduced.

Please use
Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft =
Hyper-V VMs")
or=20
Cc: <stable@vger.kernel.org> # v4.6+

Thanks,
-- Dexuan
