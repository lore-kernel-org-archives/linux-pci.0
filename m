Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:38037
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751520Ab1KQU4j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2011 15:56:39 -0500
Date: Thu, 17 Nov 2011 14:56:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<chrisw@sous-sol.org>, <aik@au1.ibm.com>, <pmac@au1.ibm.com>,
	<dwg@au1.ibm.com>, <joerg.roedel@amd.com>, <agraf@suse.de>,
	<benve@cisco.com>, <aafabbri@cisco.com>, <B08248@freescale.com>,
	<B07421@freescale.com>, <avi@redhat.com>, <kvm@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
Message-ID: <20111117205633.GA16468@schlenkerla.am.freescale.net>
References: <20111103195452.21259.93021.stgit@bling.home>
 <20111111175118.GA6946@phenom.dumpdata.com>
 <1321049456.2682.220.camel@bling.home>
 <20111116165227.GB2793@phenom.dumpdata.com>
 <1321561337.2633.40.camel@x201.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1321561337.2633.40.camel@x201.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 17, 2011 at 01:22:17PM -0700, Alex Williamson wrote:
> On Wed, 2011-11-16 at 11:52 -0500, Konrad Rzeszutek Wilk wrote:
> > On Fri, Nov 11, 2011 at 03:10:56PM -0700, Alex Williamson wrote:
> > What would be the return value if somebody tried to unmask an edge one?
> > Should that be documented here? -ENOSPEC?
> 
> I would assume EINVAL or EFAULT since the user is providing an invalid
> argument/bad address.

EINVAL.  EFAULT is normally only used for when the user passes a bad
virtual memory address to the kernel.  This isn't an address at all, it's
an index that points to an object for which this operation does not make
sense.

-Scott

