Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:54625
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751642Ab2JENI7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Oct 2012 09:08:59 -0400
Date: Fri, 5 Oct 2012 15:08:57 +0200
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Andreas Hartmann <andihartmann@01019freenet.de>,
	<kvm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: vfio: missing patch in linux 3.6
Message-ID: <20121005130857.GX4009@amd.com>
References: <506DA799.5090603@01019freenet.de>
 <1349364399.2759.42.camel@ul30vt.home>
 <20121004161421.GV4009@amd.com>
 <1349368080.2759.52.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1349368080.2759.52.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 04, 2012 at 10:28:00AM -0600, Alex Williamson wrote:
> There are a couple questions in the link above.  Since the devices don't
> expose a PCIe capability, we probably need to add a check to look at the
> upstream device and verify we're not on a legacy bus where ACS can't be
> enforced.

You can certainly do that, but for existing hardware (with an AMD IOMMU)
this check would never be true. These devices are always on a seperate
south-bridge chip which is connected to the north-bridge via PCIe. So
the topology where you find these devices is always the same in an AMD
IOMMU system.

> Then there's the general question of whether the confirmation
> of no peer-to-peer applies to every case where we might see this device
> (some of them seem to have history that pre-dates this specific package
> implementation) or do we need to try to identify specific package
> properties in addition to just a device ID?

The device ids are kept the same to maintain compatability with older
software. Besides that, my statement about the peer-2-peer safety is
true for all south-bridges that you can find in an AMD IOMMU capable
system.

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

