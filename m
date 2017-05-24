Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032657AbdEXVVO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 May 2017 17:21:14 -0400
Date: Wed, 24 May 2017 16:21:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
        CQ Tang <cq.tang@intel.com>,
        Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] PCI: Save properties required to handle FLR for
 replay purposes.
Message-ID: <20170524212109.GA2794@bhelgaas-glaptop.roam.corp.google.com>
References: <1494441543-8216-1-git-send-email-ashok.raj@intel.com>
 <20170523203322.GA15055@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170523203322.GA15055@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 03:33:22PM -0500, Bjorn Helgaas wrote:
> On Wed, May 10, 2017 at 11:39:02AM -0700, Ashok Raj wrote:
> > From: CQ Tang <cq.tang@intel.com>
> > 
> > Requires: https://patchwork.kernel.org/patch/9593891
> 
> I'm not sure what the status of the patch above is.  I acked it, but it's
> part of a 30-patch IOMMU series, so I expect it to be merged via an IOMMU
> tree.
> 
> In any case, it's not in v4.12-rc1, so I can't apply *this* patch yet.

Ashok or CQ, would you mind reposting this when the patch it depends
on has been merged?  I'm going to drop it from patchwork for now since
I can't do anything with it, and that means it will completely
disappear from my to-do list.

Bjorn
