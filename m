Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54446 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755656AbbJ2TuN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 15:50:13 -0400
Date: Thu, 29 Oct 2015 14:50:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iov: Update virtfn_max_buses to validate offset and
 stride
Message-ID: <20151029195010.GB19083@localhost>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205215.14626.93504.stgit@localhost.localdomain>
 <20151028163216.GA2927@localhost>
 <20151028184324.GA10008@localhost>
 <5631424A.7010408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5631424A.7010408@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 28, 2015 at 02:46:50PM -0700, Alexander Duyck wrote:
> On 10/28/2015 11:43 AM, Bjorn Helgaas wrote:
> >On Wed, Oct 28, 2015 at 11:32:16AM -0500, Bjorn Helgaas wrote:

> >Here's my new proposal:
> >
> >   static int compute_max_vf_buses(struct pci_dev *dev)
> >   {
> >           struct pci_sriov *iov = dev->sriov;
> >           int nr_virtfn, busnr, rc = 0;
> >
> >           for (nr_virtfn = iov->total_VFs; nr_virtfn; nr_virtfn--) {
> >                   pci_iov_set_numvfs(dev, nr_virtfn);
> >                   if (!iov->offset || (nr_virtfn > 1 && !iov->stride)) {
> >                           rc = -EIO;
> >                           goto out;
> >                   }
> >
> >                   busnr = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
> >                   if (busnr > iov->max_VF_buses)
> >                           iov->max_VF_buses = busnr;
> >           }
> >
> >   out:
> >           pci_iov_set_numvfs(dev, 0);
> >           return rc;
> >   }
> >
> 
> This looks good to me.  In theory you could save yourself a pair of
> MMIO reads at the end of the loop by just writing numvfs without the
> offset and stride read, but this should work.

True.  It's called once per device at boot-time, so it's not a hot path,
and I think it's worth two unnecessary MMIO reads to make it easier to
analyze: there's exactly one place that updates PCI_SRIOV_NUM_VF, and that
place always updates our caches of PCI_SRIOV_VF_OFFSET and
PCI_SRIOV_VF_STRIDE.

Bjorn
