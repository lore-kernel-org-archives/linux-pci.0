Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 11 Jun 2015 10:47:26 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: jakeo@microsoft.com
Cc: kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, mebersol@microsoft.com, haiyangz@microsoft.com
Subject: Re: [PATCH 0/6] Front-end driver for PCIe Pass-through on Hyper-V
Message-ID: <20150611174726.GD22639@kroah.com>
References: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 11, 2015 at 04:22:21PM +0000, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch does some slight refactoring on the hv_vmbus driver and its
> dependents and then introduces a new paravirtual front-end driver for PCI
> which supports PCI Express devices passed through to a Linux guest running
> in a Hyper-V VM.
> 
> To support this front-end, several new mechanisms are introduced:
> 
> 1 - A common way of finding free memory-mapped I/O space in a Hyper-V VM, 
>     available to all Hyper-V-related drivers.
> 
> 2 - A way of handling PCI Message-Signaled Interrupt (MSI and MSI-X)
>     creation and formatting when Hyper-V is running.
> 
> 3 - A mapping function from Linux processor number to Hyper-V virtual
>     processor number, available to drivers, which is necessary for MSI(-X)
>     creation.
> 
> The Hyper-V Frame Buffer driver is modified to use the MMIO space
> allocation function so that its allocations both don't collide with the
> PCI front end and so that the chosen range can come from any available
> part of MMIO space.
> 
> Finally, the new PCI front-end driver is the last patch in the series.

All of this information needs to be in the patches themselves, they all
do not have any changelog information in them at all, making them not
acceptable at all.

Please fix all of this up and resend.

thanks,

greg k-h
