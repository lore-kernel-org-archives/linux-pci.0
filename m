Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45397 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172Ab2HTUpF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Aug 2012 16:45:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1T3YqN-0003DS-PN
	for linux-pci@vger.kernel.org; Mon, 20 Aug 2012 22:45:04 +0200
Received: from zccy01cs103.houston.hp.com ([15.211.201.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 22:45:03 +0200
Received: from craig.hada by zccy01cs103.houston.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 22:45:03 +0200
To: linux-pci@vger.kernel.org
From: Craig Hada <craig.hada@hp.com>
Subject: Re: [PATCH v2] intel-iommu: Default to non-coherent for domains unattached to iommus
Date: Mon, 20 Aug 2012 20:39:34 +0000 (UTC)
Message-ID: <loom.20120820T222037-283@post.gmane.org>
References: <20111112002421.10875.8307.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson <alex.williamson <at> redhat.com> writes:

> 
> domain_update_iommu_coherency() currently defaults to setting domains
> as coherent when the domain is not attached to any iommus.  This
> allows for a window in domain_context_mapping_one() where such a
> domain can update context entries non-coherently, and only after
> update the domain capability to clear iommu_coherency.
> 
> This can be seen using KVM device assignment on VT-d systems that
> do not support coherency in the ecap register.  When a device is
> added to a guest, a domain is created (iommu_coherency = 0), the
> device is attached, and ranges are mapped.  If we then hot unplug
> the device, the coherency is updated and set to the default (1)
> since no iommus are attached to the domain.  A subsequent attach
> of a device makes use of the same dmar domain (now marked coherent)
> updates context entries with coherency enabled, and only disables
> coherency as the last step in the process.
> @@ -560,7 +560,9 @@ static void domain_update_iommu_coherency(struct 
dmar_domain *domain)
>  {
>  	int i;
> 
> -	domain->iommu_coherency = 1;
> +	i = find_first_bit(&domain->iommu_bmp, g_num_of_iommus);
> +
> +	domain->iommu_coherency = i < g_num_of_iommus ? 1 : 0;
> 
>  	for_each_set_bit(i, &domain->iommu_bmp, g_num_of_iommus) {
>  		if (!ecap_coherent(g_iommus[i]->ecap)) {
> 
> 

I'm running into this same problem on two HP systems while testing pass 
through mode. Both systems are running the iommu in non-coherent mode and it 
does not appear there is a way to change it in BIOS. I applied the above code 
change to my 3.5 kernel and the original problem has gone away but now I'm 
getting a fault 6 on a PTE entry.

DMAR:[DMA Read] Request device [00:1e.0] fault addr 1000
DMAR:[fault reason 06] PTE Read access is not set

Is anyone working on a fix for this problem?

-Craig

