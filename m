Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Mar 2013 16:16:44 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Michal Marek <mmarek@suse.cz>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Oliver Neukum <oneukum@suse.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciehp: Add pciehp_surprise module option
Message-ID: <20130322161644.GA28760@srcf.ucam.org>
References: <s5h38vqjhk6.wl%tiwai@suse.de>
 <1363802953.24132.513.camel@bling.home>
 <s5hr4j9q48d.wl%tiwai@suse.de>
 <514C8388.3050200@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <514C8388.3050200@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 22, 2013 at 05:15:04PM +0100, Michal Marek wrote:

> Alex, Matthew, would it work for you to have this debug / band-aid
> option _and_ have a list of either machines' dmi strings that have this
> problem, or devices' PCI IDs (*), and enable the surprise event handling
> for such machines / devices automatically?  The option would be still
> useful for debugging, to be able to easily find out if given machine has
> this problem and needs to be added to the quirk list.

That's be preferable, but if there's anything we've learned about dmi 
strings it's that they usually mean we're doing something wrong. Does 
this work with Windows without any quirking? Is there a machine-specific 
driver for the PCIe chipset?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
