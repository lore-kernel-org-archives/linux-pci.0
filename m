Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 5 Oct 2015 11:04:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ruud <netwerkforens@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: Which PCI development git repo to use?
Message-ID: <20151005160453.GA13383@localhost>
References: <CAKsTQnnuRzWjTtjLSt2FhPuy7s6V=oO5R7WKC0G4=VnR5s_AfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKsTQnnuRzWjTtjLSt2FhPuy7s6V=oO5R7WKC0G4=VnR5s_AfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 05, 2015 at 08:03:45AM +0200, Ruud wrote:
> Hello all,
> 
> Looking at the changes in this sundays rc, it seems the PCI patches of
> Yinghai do not get picked up in RC2 and later. I did see some patches
> from helgaas.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> 
> Does someone know the plans with regard to PCIe support for big
> systems with problematic bioses (aka high density GPU computing
> clusters) in the linus tree. Or is it just too much of a risk to
> migrate to new PCIe configuration code as most users do not need it?
> 
> If the latter is the case, it is at least good to know now beforehand...

I don't know specifically what problems you're seeing with "big
systems with problematic BIOSes," but I will apply patches that
improve Linux support for PCIe configuration, as long as they are
clean, reviewable, and safe.

There is no automatic "post patches on linux-pci and see them appear
in the next RC" arrangement.  Even if such patches fix a problem for
some users, they have to be safe for all users and maintainable by
people other than the author before I can merge them.

I use https://patchwork.ozlabs.org/project/linux-pci/list/ as the
queue of patches to be reviewed and potentially applied.

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/ is the
git tree of PCI-related changes heading for the mainline kernel.  The
"for-linus" branch contains things I plan to ask Linus to merge
between the merge window and the final release, e.g., between v4.3-rc1
and v4.3.  The "next" branch contains things intended for the next
merge window, e.g., they would be merged between v4.3 and v4.4-rc1.

Bjorn
