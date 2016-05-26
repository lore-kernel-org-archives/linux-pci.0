Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39281 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718AbcEZK65 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 May 2016 06:58:57 -0400
Subject: Re: How to keep PCI-e endpoints and RCs in distinct IOMMU groups?
To: Mitchel Humpherys <mitchelh@codeaurora.org>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Will Deacon <will.deacon@arm.com>
References: <vnkwoa7ty89k.fsf@codeaurora.org>
Cc: Tony Truong <truong@codeaurora.org>, Yan He <yanhe@codeaurora.org>,
	Pratik Patel <pratikp@codeaurora.org>,
	Hamad Kadmany <hkadmany@codeaurora.org>,
	Maya Erez <qca_merez@qca.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5746D6ED.1010305@arm.com>
Date: Thu, 26 May 2016 11:58:53 +0100
MIME-Version: 1.0
In-Reply-To: <vnkwoa7ty89k.fsf@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey Mitch,

On 26/05/16 01:26, Mitchel Humpherys wrote:
> Hey there,
>
> We're experiencing an issue with IOMMU groups and PCI-e devices.  The
> system in question has a WLAN DMA master behind a PCI-e root complex
> which is, in turn, behind an IOMMU.  There are no there devices behind
> the RC.  This is on an ARM platform using the arm-smmu and pci-msm
> drivers (pci-msm is in the MSM vendor tree, sorry...).
>
> What we're observing is that the WLAN endpoint device is being added to
> the same IOMMU group as the root complex device itself.  I don't think
> they should be in the same group though, since they each have different
> BDFs, which, in our system, are translated to different SMMU Stream IDs,
> so their traffic is split onto separate SMMU context banks.  Since their
> traffic is isolated from one other I don't think they need to be in the
> same IOMMU group (as I understand IOMMU groups).
>
> The result is that when the WLAN driver tries to attach to their IOMMU
> it errors out due to the following check in iommu_attach_device:
>
>          if (iommu_group_device_count(group) != 1)
>                  goto out_unlock;
>
> I've come up with a few hacky workarounds:
>
>    - Forcing PCI-e ACS to be "enabled" unconditionally (even though our
>      platform doesn't actually support it).

If the _only_ use of the IOMMU is to allow 32-bit devices to get at 
physically higher RAM without DAC addressing, then perhaps. If system 
integrity matters, though, you're opening up the big hole that Alex 
mentions. I'm reminded of Rob Clark's awesome Fire TV hack for some of 
the dangers of letting DMA-capable devices play together without careful 
supervision...

>    - Call iommu_attach_group instead of iommu_attach_device in the arm64
>      DMA IOMMU mapping layer (yuck).

That's not yuck, that would be correct, except for the arm64 DMA mapping 
code relying on default domains from the IOMMU core and not calling 
iommu_attach anything :/

If you've not picked 921b1f52c942 into the MSM kernel, please do so and 
fix the fallout in whatever other modifications you have. That dodgy 
workaround was only necessary for the brief window between the DMA 
mapping code and the IOMMU core group rework both landing in 4.4, and 
then hung around unused for far too long, frankly.

>    - Don't use the pci_device_group helper at all from the arm-smmu
>      driver.  Just allocate a new group for all PCI-e devices.

See point #1.

> It seems like the proper solution would be to somehow make these devices
> end up in separate IOMMU groups using the existing pci_device_group
> helper, since that might be doing useful stuff for other configurations
> (like detecting the DMA aliasing quirks).
>
> Looking at pci_device_group, though, I'm not sure how we could tell that
> these two devices are supposed to get separated.  I know very little
> about PCI-e so maybe I'm just missing something simple.  The match
> happens in the following loop where we walk up the PCI-e topology:
>
>          /*
>           * Continue upstream from the point of minimum IOMMU granularity
>           * due to aliases to the point where devices are protected from
>           * peer-to-peer DMA by PCI ACS.  Again, if we find an existing
>           * group, use it.
>           */
>          for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
>                  if (!bus->self)
>                          continue;
>
>                  if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
>                          break;
>
>                  pdev = bus->self;
>
>                  group = iommu_group_get(&pdev->dev);
>                  if (group)
>                          return group;
>          }
>
> Why do we do that?  If the devices have different BDFs can't we safely
> say that they're protected from peer-to-peer DMA (assuming no DMA
> aliasing quirks)?  Even as I write that out it seems wrong though since
> the RC can probably do whatever it wants...

Quite ;)

> Maybe the IOMMU framework can't actually know whether the devices should
> be kept in separate groups and we just need to do something custom in
> the arm-smmu driver?

 From my perspective, things are to the contrary - the IOMMU core 
assumes devices should be in separate groups unless it _does_ know 
otherwise, and the ARM SMMU driver is severely lacking in the cases 
where devices do need grouping in ways the core can't discover - I guess 
you've not had the pleasure of watching multiple platform devices on the 
same stream ID blowing up.

I am of course addressing this in my SMMU generic bindings patches (v2 
coming real soon now) - having said which I'm now doing a double-take 
because until that series there are no IOMMU DMA ops for PCI devices and 
no real DMA mapping support for the SMMU, so... how... this would appear 
to be a problem entirely belonging to out-of-tree code :P

Robin.

> Sorry for the novel!  Thanks for any pointers.
>
>
> -Mitch
>

