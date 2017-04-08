Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 8 Apr 2017 14:06:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: `pci_apply_final_quirks()` taking half a second
Message-ID: <20170408190628.GB16832@bhelgaas-glaptop.roam.corp.google.com>
References: <44cada166e42007d27b4c3e3aa0744d7@molgen.mpg.de>
 <20170408154128.GA16832@bhelgaas-glaptop.roam.corp.google.com>
 <1491670819.6021.33.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491670819.6021.33.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 08, 2017 at 07:00:19PM +0200, David Woodhouse wrote:
> ...
> I note it's also reading PCI_CACHE_LINE_SIZE From config space for each
> device in pci_apply_final_quirks(). How long does that take?

I don't know, but it's pointless on modern PCIe systems where the
Cache Line Size has no effect.  It'd be really nice if somebody
cleaned that up and got rid of the read itself and the useless
messages.

Bjorn
