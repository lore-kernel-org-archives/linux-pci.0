Return-Path: <airlied@gmail.com>
Return-Path: <airlied@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160519154946.GA20036@localhost>
References: <20160519154946.GA20036@localhost>
Date: Mon, 23 May 2016 06:46:20 +1000
Message-ID: <CAPM=9ty9k2e_QLQXLztUSFiDxN8-a7xiGG9USSc=nu1-vNcUyQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.7
From: Dave Airlie <airlied@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
	Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 20 May 2016 at 01:49, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Linus,
>
> Here are the PCI changes I intend for v4.7.
>
> There is a silent conflict that needs to be resolved when you pull this:
>
>   - e3156048346c ("iommu/amd: Fix checking of pci dma aliases"), which is
>     already in your tree, added a use of PCI_DEV_FLAGS_DMA_ALIAS_DEVFN.
>
>   - 338c3149a221 ("PCI: Add support for multiple DMA aliases"), which is
>     included in this pull request, replaces PCI_DEV_FLAGS_DMA_ALIAS_DEVFN
>     with pdev->dma_alias_mask to support multiple aliases.
>
> The conflict resolution I suggest is attached below.  The identical patch
> has been in linux-next and was supplied by both Jacek Lawrynowicz and Joerg
> Roedel (and probably Stephen as well).
>

Hi,

can we consider pulling in Mika's changes again for this merge window,
they fix a
pretty serious power management regression since we started
advertising Windows 2013
ACPI compat, as lots of dual GPU laptops can no longer switch off
their secondary GPUs.

I know they had an issue, but Mika seems to have fixed it promptly,
and those patches
aren't going to get much more testing out of tree.

Dave.
