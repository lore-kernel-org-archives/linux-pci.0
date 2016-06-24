Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57275 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbcFXGu0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 24 Jun 2016 02:50:26 -0400
Date: Fri, 24 Jun 2016 07:50:28 +0100
From: Will Deacon <will.deacon@arm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pci: Add support for unbinding the generic PCI host
 controller
Message-ID: <20160624065028.GG29165@arm.com>
References: <57698276.6050606@siemens.com>
 <20160622060638.GY29165@arm.com>
 <576C1CF6.7020804@siemens.com>
 <20160624061238.GD29165@arm.com>
 <576CD58C.5020900@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <576CD58C.5020900@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 24, 2016 at 08:39:08AM +0200, Jan Kiszka wrote:
> On 2016-06-24 08:12, Will Deacon wrote:
> > On Thu, Jun 23, 2016 at 07:31:34PM +0200, Jan Kiszka wrote:
> >> On 2016-06-22 08:06, Will Deacon wrote:
> >>>   - The probe path seems to have some stateful operations outside of PCI
> >>>     resources. For example, kzalloc'ing the bus_range resource in
> >>>     of_pci_get_host_bridge_resources. Do we need to clean these up
> >>>     explicitly?
> >>>
> >>>   - Similarly, we don't seem to tear-down the config space mappings and
> >>>     data structures for that, so we leak VA space afaict.
> >>>
> >>
> >> Good points. But to my understanding, everything is released
> >> automatically on pci_remove_root_bus because all the resources are
> >> registered with the bus which takes care of them during destruction. And
> >> if I trace the release, I find this e.g.
> >>
> >> ...
> >> devres_release_all() {
> >>   _raw_spin_lock_irqsave();
> >>   release_nodes() {
> >>     _raw_spin_unlock_irqrestore();
> >>     devm_action_release() {
> >>       gen_pci_unmap_cfg() {
> > 
> > Ah, thanks for investigating that -- I completely missed the explicit
> > devm_ callback. That resolves my concern about the config space mappings,
> > but I still don't understand what happens to the resources allocated
> > in of_pci_get_host_bridge_resources. It looks like they should actually
> > be freed within that function, since pci_add_resource{_offset} copy the
> > resources into their own resource_entries anyway.
> > 
> > Am I missing something?
> 
> Tracing kmalloc and kfree in addition, it seems you are right. But then
> we already have leaks in the code in case the setup fails somewhere in
> the middle, no? gen_pci_init only releases the resource list on errors,
> but not bus_range. And pci_host_common_probe does non of both if
> pci_scan_root_bus fails. Anything else?

Yeah, it's a right old mess. of_pci_get_host_bridge_resources even cleans
up after itself, but gen_pci_init can fail in other ways and then doesn't
clean up properly.

I wonder why of_pci_get_host_bridge_resources can't just use devm_kzalloc.

Will
