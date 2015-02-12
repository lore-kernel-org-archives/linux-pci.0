Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57910 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932069AbbBLDhE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Feb 2015 22:37:04 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	jiang.liu@linux.intel.com
Subject: Re: [PATCH] drivers: of: pci: remove duplicate kfree in of_pci_get_host_bridge_resources
Date: Thu, 12 Feb 2015 05:00:09 +0100
Message-ID: <7358500.qEktYExvcf@vostro.rjw.lan>
In-Reply-To: <20150211225057.GA16317@google.com>
References: <1423630715-23568-1-git-send-email-lorenzo.pieralisi@arm.com> <20150211225057.GA16317@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, February 11, 2015 04:50:57 PM Bjorn Helgaas wrote:
> On Wed, Feb 11, 2015 at 04:58:35AM +0000, Lorenzo Pieralisi wrote:
> > Commit d2be00c0fb5a ("of/pci: Free resources on failure in
> > of_pci_get_host_bridge_resources()") fixed the error code path in
> > of_pci_get_host_bridge_resources() by adding code that runs through the
> > resources list to free all resources in it and then calls kfree on the
> > bus_range resource pointer to complete the memory deallocation.
> > Since the bus_range resource is added to the resources list through
> > pci_add_resource, the resource_list_for_each_entry loop in the error
> > exit path frees it already and freeing it anew could trigger a double
> > free, hence this patch removes the superfluos kfree call on the bus_range
> > resource.
> > 
> > Fixes: d2be00c0fb5a ("of/pci: Free resources on failure in of_pci_get_host_bridge_resources()")
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Reported-by: Jiang Liu <jiang.liu@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> 
> I applied this to for-linus, and will ask Linus to put it in before
> v3.20-rc1, thanks!
> 
> Rafael, I applied d2be00c0fb5a, where the bug originally came from, but I
> see that you fixed it with 5c493df25a0d and the fix got lost because of an
> incorrect merge resolution.  So if you'd rather take this, just let me
> know.

That really should go through your tree I think.  I attempted to fix it, but
failed to do that correctly, so effectively that doesn't count ...

Rafael

