Return-Path: <SRS0=9kPM=AX=suse.de=jroedel@kernel.org>
Return-Path: <SRS0=9kPM=AX=suse.de=jroedel@kernel.org>
Date: Fri, 22 Sep 2017 19:51:53 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Add dummy for pci_acs_enabled() if CONFIG_PCI=n to
 fix iommmu build
Message-ID: <20170922175153.phtxn5jhe7ioz4ps@suse.de>
References: <1505132955-9517-1-git-send-email-geert@linux-m68k.org>
 <20170922155605.GB15970@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922155605.GB15970@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hey Bjorn,

On Fri, Sep 22, 2017 at 10:56:05AM -0500, Bjorn Helgaas wrote:
> Joerg, if you pick this up, would you mind capitalizing the subject
> line to match the PCI convention, e.g.,
> 
>   PCI: Add dummy pci_acs_enabled() for CONFIG_PCI=n build
> 
> If it's too late for you to pick this up this week, I can include it
> next week.  I assume this is not related to a specific change, i.e.,
> it's not a regression?  Should it be marked for stable?

I sent iommu fixes out today, this was not included. So if you are
sending fixes upstream next week anyway, please pick it up. I am not
sure if I have anything to send next week, so you are probably faster.

I think its stable material too.

Thanks,

	Joerg
