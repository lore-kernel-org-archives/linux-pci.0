Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:50722 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966120Ab2EQDuz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 May 2012 23:50:55 -0400
Date: Thu, 17 May 2012 13:37:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: benh@kernel.crashing.org, aik@ozlabs.ru, joerg.roedel@amd.com,
	dwmw2@infradead.org, chrisw@sous-sol.org, agraf@suse.de,
	benve@cisco.com, aafabbri@cisco.com, B08248@freescale.com,
	B07421@freescale.com, avi@redhat.com, konrad.wilk@oracle.com,
	kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	bhelgaas@google.com
Subject: Re: [PATCH 03/13] iommu: IOMMU groups for VT-d and AMD-Vi
Message-ID: <20120517033714.GE22069@truffala.fritz.box>
References: <20120511222148.30496.68571.stgit@bling.home>
 <20120511225548.30496.34428.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120511225548.30496.34428.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2012 at 04:55:48PM -0600, Alex Williamson wrote:
> Add back group support for AMD & Intel.  amd_iommu already tracks
> devices and has init and uninit routines to manage groups.
> intel-iommu does this on the fly, so we make use of the notifier
> support built into iommu groups to create and remove groups.

Looks ok to me.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
