Return-Path: <SRS0=EriY=LR=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=EriY=LR=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 3 Sep 2018 15:12:09 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Daniel Drake <drake@endlessm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Linux Upstreaming Team <linux@endlessm.com>,
	nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>,
	Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] PCI: add prefetch quirk to work around Asus/Nvidia
 suspend issues
Message-ID: <20180903121209.GC2283@lahna.fi.intel.com>
References: <20180831073057.14626-1-drake@endlessm.com>
 <20180831191225.GA43106@bhelgaas-glaptop.roam.corp.google.com>
 <CAD8Lp45CKCHxTg91zF9bWztqbAwLzgAUpNEHQ6ouKu2PkJT8SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD8Lp45CKCHxTg91zF9bWztqbAwLzgAUpNEHQ6ouKu2PkJT8SQ@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 03, 2018 at 04:56:32PM +0800, Daniel Drake wrote:
> On Sat, Sep 1, 2018 at 3:12 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > If true, this sounds like some sort of erratum, so it would be good to
> > get some input from Intel, and I cc'd a few Intel folks.
> 
> Yes, it would be great to get their input.

We have seen one similar issue with LPSS devices when BIOS assigns
device BARs above 4G (which is not the case here) and it turned out to
be misconfigured MTRR register or something like that. It may not be
related at all but it could be worth a try to dump out MTRR registers of
one of the affected systems and see if the memory areas are listed there
(and if the attributes are somehow wrong if found).
