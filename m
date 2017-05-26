Return-Path: <SRS0=Jicb=5A=netronome.com=jakub.kicinski@kernel.org>
Return-Path: <SRS0=Jicb=5A=netronome.com=jakub.kicinski@kernel.org>
Date: Fri, 26 May 2017 16:58:20 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Emil Tantilov <emil.s.tantilov@intel.com>,
 Alexander Duyck <alexander.h.duyck@intel.com>, oss-drivers@netronome.com
Subject: Re: [PATCH] pci: iov: use device lock to protect IOV sysfs accesses
Message-ID: <20170526165820.7ec488e3@cakuba.netronome.com>
In-Reply-To: <20170526234726.GD21531@bhelgaas-glaptop.roam.corp.google.com>
References: <20170522225023.14010-1-jakub.kicinski@netronome.com>
	<20170526234726.GD21531@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Fri, 26 May 2017 18:47:26 -0500, Bjorn Helgaas wrote:
> On Mon, May 22, 2017 at 03:50:23PM -0700, Jakub Kicinski wrote:
> > PCI core sets the driver pointer before calling ->probe() and only
> > clears it after ->remove().  This means driver's ->sriov_configure()
> > callback will happily race with probe() and remove(), most likely
> > leading to BUGs, since drivers don't expect this.  
> 
> I guess you're referring to the pci_dev->driver pointer set by
> local_pci_probe(), and this is important because sriov_numvfs_store()
> checks that pointer, right?

Yes, exactly.  I initially thought this is how the safety of sriov
callback may have been ensured, but since the order of
local_pci_probe() and the assignment is what it is, it can't.
