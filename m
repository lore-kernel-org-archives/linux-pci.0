Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36980 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722Ab2BOQiJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Feb 2012 11:38:09 -0500
Date: Wed, 15 Feb 2012 08:38:07 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	Takashi Iwai <tiwai@suse.de>, trenn@suse.de,
	linux-pci@vger.kernel.org, Michal Marek <MMarek@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC v2] USB: Fix handoff when BIOS disables host PCI device.
Message-ID: <20120215163807.GA5446@xanatos>
References: <20120209150823.GA5232@xanatos>
 <20120209201354.GA6709@xanatos>
 <20120214203311.GA8485@xanatos>
 <201202150948.07115.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201202150948.07115.oneukum@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 15, 2012 at 09:48:07AM +0100, Oliver Neukum wrote:
> Am Dienstag, 14. Februar 2012, 21:33:11 schrieb Sarah Sharp:
> > Hi Oliver,
> > 
> > Have you gotten a chance to test this patch on your test system?  I'd
> > like to get it out, but I want to make sure it fixes your problem.
> 
> Did I forget to answer? Anyway, yes it works. However it seems a bad idea
> to me to unconditionally disable the device, on second thought.

Why?  The USB core will re-enable the device during the PCI probe, so I
don't see the harm in it.  What else might be accessing the PCI device?
Obviously the PCI core didn't care if the device was enabled or not
pre-probe, or it would have enabled the PCI device itself.

Sarah Sharp
