Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51531BF9.8020405@suse.cz>
Date: Wed, 27 Mar 2013 17:19:05 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Oliver Neukum <oneukum@suse.de>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Takashi Iwai <tiwai@suse.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciehp: Add pciehp_surprise module option
References: <s5h38vqjhk6.wl%tiwai@suse.de> <514C8388.3050200@suse.cz> <1363969243.24132.613.camel@bling.home> <5658592.BRAWLYK6e8@linux-5eaq.site>
In-Reply-To: <5658592.BRAWLYK6e8@linux-5eaq.site>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27.3.2013 17:11, Oliver Neukum wrote:
> On Friday 22 March 2013 10:20:43 Alex Williamson wrote:
> 
>>> (*) It would probably make more sense to have a list of dmi strings,
>>> because it's the PCIe controller that does not set the capability bit
>>> when it should. The device (Realtek card reader in this case) seems to
>>> behave correctly. The machines in question have been laptops or
>>> all-in-one PCs so far, so there should be no problem with dmi matches.
>>
>> Yep, I think that makes sense, leave the global option for debugging but
>> fix individual known broken devices through dmi quirks.  Thanks,
> 
> I checked with Win8 and it does ignore the surprise attribute.

I.e., the device hotplugs / hotremoves even in a pristine Win8 install
that does not include any driver for the device.

Michal
