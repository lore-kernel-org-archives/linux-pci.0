Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58620 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3C0QLC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Mar 2013 12:11:02 -0400
From: Oliver Neukum <oneukum@suse.de>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Michal Marek <mmarek@suse.cz>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciehp: Add pciehp_surprise module option
Date: Wed, 27 Mar 2013 17:11:39 +0100
Message-ID: <5658592.BRAWLYK6e8@linux-5eaq.site>
In-Reply-To: <1363969243.24132.613.camel@bling.home>
References: <s5h38vqjhk6.wl%tiwai@suse.de> <514C8388.3050200@suse.cz> <1363969243.24132.613.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 22 March 2013 10:20:43 Alex Williamson wrote:

> > (*) It would probably make more sense to have a list of dmi strings,
> > because it's the PCIe controller that does not set the capability bit
> > when it should. The device (Realtek card reader in this case) seems to
> > behave correctly. The machines in question have been laptops or
> > all-in-one PCs so far, so there should be no problem with dmi matches.
> 
> Yep, I think that makes sense, leave the global option for debugging but
> fix individual known broken devices through dmi quirks.  Thanks,

I checked with Win8 and it does ignore the surprise attribute.

	Regards
		Oliver

