Return-Path: <SRS0=kr+q=HS=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=kr+q=HS=linux.intel.com=mika.westerberg@kernel.org>
Date: Sun, 29 Apr 2018 10:03:34 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Intel 300 series chipset
Message-ID: <20180429070334.GU2173@lahna.fi.intel.com>
References: <20180427104423.2203-1-mika.westerberg@linux.intel.com>
 <20180427181024.GE8199@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180427181024.GE8199@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2018 at 01:10:24PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 27, 2018 at 01:44:23PM +0300, Mika Westerberg wrote:
> > Intel 300 series chipset still has the same ACS issue than the previous
> > generations so extend the ACS quirk to cover it as well.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Applied to pci/virtualization for v4.18, thanks!

Thanks!

> Stable tag here, too?

Fine by me.
