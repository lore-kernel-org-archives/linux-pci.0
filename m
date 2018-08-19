Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeHSF3N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Aug 2018 01:29:13 -0400
Date: Sat, 18 Aug 2018 21:19:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: poza@codeaurora.org, Thomas Tai <thomas.tai@oracle.com>,
        bhelgaas@google.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 05:05:30PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-16 at 16:51 +1000, Benjamin Herrenschmidt wrote:
> > No, this is wrong and not the intent of the error handling.
> > 
> > You seem to be applying PCIe specific concepts brain-farted at Intel
> > that are way way away from what we care about in practice and in Linux.
> > 
> > > e.g.  some driver handle errors ERR_NONFATAL or FATAL in similar ways
> > > e.g.
> > > ioat_pcie_error_detected();  calls  ioat_shutdown(); in case of 
> > > ERR_NONFATAL
> > > otherwise ioat_shutdown() in case of ERR_FATAL.
> > 
> > Since when the error handling callbacks even have the concept of FATAL
> > vs. non-fatal ? This doesn't appear anyhwhere in the prototype of the
> > struct pci_error_handlers and shouldn't.
> 
> Ugh... I just saw the changes you did to Documentation/PCI/pci-error-
> recovery.txt and I would very much like to revert those !
> 
> Bjorn, you shouldn't let changes to the PCI error handling through
> without acks from us, it looks like we didn't notice (we can't possibly
> monitor all lists).

Sorry, they were certainly very visible on linux-pci, but I should
have added you to cc if you weren't there already.  Please update
MAINTAINERS if it's incomplete or out of date (I can't possibly know
who might be interested in every change).

> Bjorn, please revert all of those changes.

Please send the appropriate patches and we'll go from there.
