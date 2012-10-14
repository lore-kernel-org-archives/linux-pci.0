Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout0.freenet.de ([195.4.92.90]:51851 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754448Ab2JNPJ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 14 Oct 2012 11:09:58 -0400
Message-ID: <507AD532.7000707@01019freenet.de>
Date: Sun, 14 Oct 2012 17:07:30 +0200
From: Andreas Hartmann <andihartmann@01019freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "Roedel, Joerg" <Joerg.Roedel@amd.com>,
	Andreas Hartmann <andihartmann@01019freenet.de>,
	kvm@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: vfio: missing patch in linux 3.6
References: <506DA799.5090603@01019freenet.de> <1349364399.2759.42.camel@ul30vt.home> <20121004161421.GV4009@amd.com> <1349368080.2759.52.camel@ul30vt.home> <20121005130857.GX4009@amd.com>
In-Reply-To: <20121005130857.GX4009@amd.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Roedel, Joerg wrote:
> On Thu, Oct 04, 2012 at 10:28:00AM -0600, Alex Williamson wrote:
>> There are a couple questions in the link above.  Since the devices don't
>> expose a PCIe capability, we probably need to add a check to look at the
>> upstream device and verify we're not on a legacy bus where ACS can't be
>> enforced.
> 
> You can certainly do that, but for existing hardware (with an AMD IOMMU)
> this check would never be true. These devices are always on a seperate
> south-bridge chip which is connected to the north-bridge via PCIe. So
> the topology where you find these devices is always the same in an AMD
> IOMMU system.
> 
>> Then there's the general question of whether the confirmation
>> of no peer-to-peer applies to every case where we might see this device
>> (some of them seem to have history that pre-dates this specific package
>> implementation) or do we need to try to identify specific package
>> properties in addition to just a device ID?
> 
> The device ids are kept the same to maintain compatability with older
> software. Besides that, my statement about the peer-2-peer safety is
> true for all south-bridges that you can find in an AMD IOMMU capable
> system.

http://news.gmane.org/find-root.php?group=gmane.linux.kernel.pci&article=16422

I think, Joerg wrote clearly that there is no problem any more to apply
this patch. I run it since a long time meanwhile without any problem.
Please, why aren't these patches applied?


Thanks,
kind regards,
Andreas Hartmann
