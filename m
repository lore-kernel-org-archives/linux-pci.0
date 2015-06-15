Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Jun 2015 12:50:27 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: jakeo@microsoft.com
Cc: kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, pebolle@tiscali.nl,
	haiyangz@microsoft.com, mebersol@microsoft.com
Subject: Re: [PATCH v2 6/6] drivers:pci:hv: New paravirtual PCI front-end for
 Hyper-V VMs
Message-ID: <20150615195027.GA5257@kroah.com>
References: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
 <1434387999-1885-7-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434387999-1885-7-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 15, 2015 at 05:06:39PM +0000, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch supplies a new driver, hv_pcifront, which exposes new root PCI
> buses.  When a Hyper-V VM running Linux is offered a paravirtual PCI bus
> in order to expose a device passed through on that bus, this drver
> registers a new bus with the PCI driver.  This new bus is bus "zero"
> within a new PCI domain.  This is done so that there's no overlap between
> the emulated, or fully virtualized, PCI that may be in the VM and a real
> PCIe device that will be exposed.
> 
> This PCI front-end only supports PCIe devices which do not use I/O BARs and
> which do not need a legacy INTx# interrupt (relying on MSI or MSI-X).
> Multifunction devices are supported, but devices with Type 1 or Type 2
> config headers are not supported.  (These are bridges to other PCI buses.)
> 
> The content of this patch differs from the one sent previously in that it
> incorporates feedback related to unused code (which has been removed) and
> GPL license (which has been updated.)  It also removes Kconfig lines that
> had been copied from the Xen PCI front-end entry, but which shouldn't be
> used here.

This paragraph goes below the --- line, we don't need it in the
changelog :(

