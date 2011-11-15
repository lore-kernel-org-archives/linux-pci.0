Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33788 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891Ab1KOAuq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Nov 2011 19:50:46 -0500
Message-ID: <1321318169.21206.72.camel@pasglop>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <dwg@au1.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	"Christian Benvenuti (benve)" <benve@cisco.com>,
	chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de,
	"Aaron Fabbri (aafabbri)" <aafabbri@cisco.com>,
	B08248@freescale.com, B07421@freescale.com, avi@redhat.com,
	konrad.wilk@oracle.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Date: Tue, 15 Nov 2011 11:49:29 +1100
In-Reply-To: <20111115000505.GA5035@truffala.fritz.box>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <184D23435BECB444AB6B9D4630C8EC8302D5FE38@XMB-RCD-303.cisco.com>
	 <1321034647.2682.98.camel@bling.home>
	 <184D23435BECB444AB6B9D4630C8EC8302D603A9@XMB-RCD-303.cisco.com>
	 <1321311540.17169.122.camel@bling.home>
	 <20111115000505.GA5035@truffala.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2011-11-15 at 11:05 +1100, David Gibson wrote:
> Being strict, or at least enforcing strictness, requires that the
> infrastructure track all the maps, so that the unmaps can be
> matching.  This is not a natural thing with the data structures you
> want for all IOMMUs.  For example on POWER, the IOMMU (aka TCE table)
> is a simple 1-level pagetable.  One pointer with a couple of
> permission bits per IOMMU page.  Handling oddly overlapping operations
> on that data structure is natural, enforcing strict matching of maps
> and unmaps is not and would require extra information to be stored by
> vfio.  On POWER, the IOMMU operations often *are* a hot path, so
> manipulating those structures would have a real cost, too. 

In fact they are a very hot path even. There's no way we can afford the
cost of tracking per page mapping/unmapping (other than bumping the page
count on a page that's currently mapped or via some debug-only feature).

Cheers,
Ben.


