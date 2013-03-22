Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60404 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161015Ab3CVQfm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Mar 2013 12:35:42 -0400
Message-ID: <514C8858.3050702@suse.cz>
Date: Fri, 22 Mar 2013 17:35:36 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Oliver Neukum <oneukum@suse.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciehp: Add pciehp_surprise module option
References: <s5h38vqjhk6.wl%tiwai@suse.de> <1363802953.24132.513.camel@bling.home> <s5hr4j9q48d.wl%tiwai@suse.de> <514C8388.3050200@suse.cz> <20130322161644.GA28760@srcf.ucam.org>
In-Reply-To: <20130322161644.GA28760@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 22.3.2013 17:16, Matthew Garrett wrote:
> On Fri, Mar 22, 2013 at 05:15:04PM +0100, Michal Marek wrote:
> 
>> Alex, Matthew, would it work for you to have this debug / band-aid
>> option _and_ have a list of either machines' dmi strings that have this
>> problem, or devices' PCI IDs (*), and enable the surprise event handling
>> for such machines / devices automatically?  The option would be still
>> useful for debugging, to be able to easily find out if given machine has
>> this problem and needs to be added to the quirk list.
> 
> That's be preferable, but if there's anything we've learned about dmi 
> strings it's that they usually mean we're doing something wrong. Does 
> this work with Windows without any quirking? Is there a machine-specific 
> driver for the PCIe chipset?

I don't know. Oliver and Takashi have the machines, but I'm not sure if
they have a working Windows image for them.

Michal
