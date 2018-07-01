Return-Path: <SRS0=8O55=JR=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=8O55=JR=h08.hostsharing.net=foo00@kernel.org>
Date: Sun, 1 Jul 2018 19:45:08 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: Document patch submission hints
Message-ID: <20180701174508.GB28249@wunner.de>
References: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 29, 2018 at 03:27:39PM -0500, Bjorn Helgaas wrote:
> --- /dev/null
> +++ b/Documentation/PCI/submitting-patches.txt
> @@ -0,0 +1,153 @@
> +Start with Documentation/process/submitting-patches.rst for general
> +guidance.
> +
> +These are things I look at when reviewing patches.

For an uninitiated reader who doesn't know that you're currently the
(sole) maintainer of the PCI subsystem, this sentence might look odd.
Who's "I"?  What happens if you onboard co-maintainers, are you
going to change this to "we"?


> +  - Wrap code and comments to fit in 80 columns.  Exception: I prefer
> +    printk strings to be in one piece for searchability, so don't split
> +    quoted strings to make them fit in 80 columns.

This is a duplication of Documentation/process/coding-style.rst, section 2.


> +  - Follow the existing convention  Run "git log --oneline <file>" and make
> +    your subject line match previous changes in format, capitalization, and
> +    sentence structure.  For example, native host bridge driver patch
> +    titles look like this:
> +
> +      PCI: vmd: Remove IRQ affinity so we can allocate more IRQs
> +      PCI: mediatek: Add MSI support for MT2712 and MT7622
> +      PCI: rockchip: Remove IRQ domain if probe fails

A quick "git log --oneline --no-merges drivers/pci" shows that the prefixes
in use aren't consistent at all:  Sometimes a slash is used to separate
"PCI" from the subpart touched by the patch, sometimes a colon, e.g.
"PCI/AER: " versus "PCI: shpchp: ".  Your own patches aren't consistent
in that respect.  Sometimes, only "PCI: " is given as prefix, even though
the commit only touches a subpart such as "sysfs", so could easily specify
more precisely what it's touching.

If you value consistency, it would be good to codify the preferred form
right here.


> +  - Include specific details, e.g., write "Add XYZ controller support"
> +    instead of "add support for new generation controller".

Why not simply "Support XYZ controller"?  One word less, more succinct.


> +  - Always copy linux-pci@vger.kernel.org and linux-kernel@vger.kernel.org.

I'd drop linux-kernel here.  The volume on that list is already like
drinking from a firehose, I doubt it adds much value to cc it.

Thanks,

Lukas
