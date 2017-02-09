Return-Path: <SRS0=k3+F=ZW=intel.com=ashok.raj@kernel.org>
Return-Path: <SRS0=k3+F=ZW=intel.com=ashok.raj@kernel.org>
Date: Thu, 9 Feb 2017 10:23:28 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Christoph Hellwig <hch@lst.de>, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Keith Busch <keith.busch@intel.com>, ashok.raj@intel.com
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170209182328.GB77900@otc-nc-03>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170209040648.GA1304@wunner.de>
 <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Thanks Bjorn,

With the fixes below, managed add remove via sysfs seems to work on my
SKX system. 

I'm not familiar with runtime PM aspects, just started looking into it 
after this one. There seems some interactions with ASPM and how we handle 
devices that support ARI for e.g.

For hotplug, we have a good set of tests to check coverage. That matrix
might need to be expanded for runtime PM interactions.

Cheers,
Ashok

On Thu, Feb 09, 2017 at 09:09:50AM -0600, Bjorn Helgaas wrote:
> [+cc Ashok, Keith]
> 
> > 
> > https://patchwork.kernel.org/patch/9557113/
> > https://patchwork.kernel.org/patch/9562007/
> 
> I don't think we've gotten to the root cause of the problem yet,
> and I don't want to throw in fixes at the last minute without a better
> understanding of it.
> 
> PCIe hotplug hardware is not very complicated, it hasn't changed in
> many years, and at least for the Intel hardware in question, is
> generally pretty well-tested with Windows.  So I want to be careful
> about asserting that this new piece of hardware is broken.
> 
> I think pciehp is unnecessarily complicated, and we do have known
> synchronization issues with it, e.g., [1] [2].  It seems possible that
> if we poked a little deeper, we would find that the hardware is
> actually working correctly and the real problem is in pciehp.
> 
> That's why I've been trying to have a conversation about how we
> interpret the spec and how we could remove PM and pciehp from the
> picture and experiment directly with setpci.
> 
> [1] https://lkml.kernel.org/r/1481317564-18045-1-git-send-email-ashok.raj@intel.com
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=117561
