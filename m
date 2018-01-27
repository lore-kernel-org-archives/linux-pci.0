Return-Path: <SRS0=awys=EW=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=awys=EW=linuxfoundation.org=gregkh@kernel.org>
Date: Sat, 27 Jan 2018 15:56:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH 0/4] PCI: Add SPDX tags
Message-ID: <20180127145616.GA2117@kroah.com>
References: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 26, 2018 at 03:32:17PM -0600, Bjorn Helgaas wrote:
> b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to
> files with no license") added SPDX GPL-2.0 tags to several PCI files.
> 
> These patches add SPDX tags to almost all remaining PCI files.  For ease of
> reviewing they're split into several cases (GPL v2, GPL v2+, etc.)
> 
> One file (drivers/pci/hotplug/s390_pci_hpc.c) specifies only "GPL"; I don't
> know what to do with that, so I left it unchanged.
> 
> These are on my pci/spdx branch [1], and if they're non-controversial, I'll
> include them for v4.16.  If they *are* controversial or you have other
> plans, I'll hold off.  I couldn't tell if you have a grand scheme or if you
> want maintainers to step up and finish things.

No grand scheme here from me at all, I'd love for maintainers to step up
and finish these things :)

All of these look great to me, feel free to add:
	Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
to all of them if you want to.

thanks for doing this work, much appreciated.

greg k-h
