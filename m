Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:37284 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752328AbaAUDxu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2014 22:53:50 -0500
Date: 20 Jan 2014 22:53:49 -0500
Message-ID: <20140121035349.14201.qmail@science.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: acooks@gmail.com, linux@horizon.com
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
Cc: alex.williamson@redhat.com, iommu@lists.linux-foundation.org,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <CAJtEV7YBr69iHHFZ7PNzZH_Hhu5HuM0ifOnzhr+GyzGqgErT4g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> It only works on Intel IOMMUs, and sort of duplicates the functionality
>> of your quirk.
>>
>> Obviously, I hate the duplication and would like to fold them together,
>> but there are a few fundamental differences.

> Hang on! The existing quirk only worked for vfio groups last time I
> checked and didn't actually solve the problem for using the device on
> the host.

I'd believe there are additional differences I haven't figured out,
but it sure seems similar enough to be potentially mergeable.

I want to either do that, or understand the differences well enough
to explain them in a comment and tell future coders which should
be used in whatr circumstances.

> Alex had done a bunch of work to support requester id quirks (see
> http://marc.info/?l=linux-pci&m=137357663626523&w=3), but that seems
> blocked.

Thank you for this pointer.  If only I understood it better, :-(

>> - Marvell SATA controllers which exist only as devid 00.0, but generate
>>   request devids of 00.1.  (The latter function might be PATA support
>>   on chips which support that.)

> No, I can prove that both .0 and .1 are used on the 9172 controller,
> depending on which of the two SATA port(s) is(are) in use. If you have
> the same hardware, I suggest you verify this.

Thank you for the confirmation (that's a second thing that makes Alex's
current solution incompatible), but I wasn't trying to imply that they
didn't also generate DMA as .0; I was just saying that the only function
which shows up in PCI config space and thus has a struct pci_dev allocated
for it is .0.

I was trying to draw attention to the fact that there is no struct pci_dev
for .1 which can be used for Alex's interface.

>> But I'm not quite sure what the locking rules are on the whole swap_pci_ref
>> business.  Or if the Ricoh devices have to be handled more carefully
>> because multiple functions need to arbitrate over the IOMMU tables
>> for function 0.

> The Ricoh firewire function simply uses the wrong requester ID. The
> other functions work correctly. Remapping only the firewire specific
> function of the multifunction device (as in my patch) fixes the
> problem.

Good to know, but can function 0 generate DMA that we need to worry about?
(I believe it's an SD host controller, 1180:e822.)

That's what I was worried about.  Both devices trying to do IOMMU mapping
at the same time and stepping on each other.
