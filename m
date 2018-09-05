Return-Path: <SRS0=KSw6=LT=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=KSw6=LT=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 5 Sep 2018 20:01:06 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: Add ACS quirk for Intel 300 series"
Message-ID: <20180905170106.GO2283@lahna.fi.intel.com>
References: <20180905110954.61990-1-mika.westerberg@linux.intel.com>
 <20180905165526.GK107892@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905165526.GK107892@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 05, 2018 at 02:09:54PM +0300, Mika Westerberg wrote:
> > This reverts commit f154a718e6cc0d834f5ac4dc4c3b174e65f3659e.
> > 
> > It turns out that errata "PCH PCIe* Controller Root Port (ACSCTLR)
> > Appear As Read Only" has been fixed in 300 series chipsets even if the
> > datasheet [1] claims otherwise. To make ACS working properly on 300
> > series root ports, revert the faulty commit.
> 
> So just to confirm, f154a718e6cc ("PCI: Add ACS quirk for Intel 300
> series") was done based on the faulty datasheet, right?
> 
> If somebody actually reported a problem with a 300 series chipset, and
> f154a718e6cc resolved it, we wouldn't want to revert it.  But I don't see
> anything like that in the f154a718e6cc changelog, so I assume it was just
> based on the faulty datasheet.

Yes, that's correct. I used the information in the datasheet and that
turned out to be wrong.
