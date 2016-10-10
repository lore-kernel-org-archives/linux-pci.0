Return-Path: <flyos@mailoo.org>
Return-Path: <flyos@mailoo.org>
From: Pierre de Villemereuil <flyos@mailoo.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Oliver Neukum <oneukum@suse.com>, USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
Date: Tue, 11 Oct 2016 10:06:47 +1300
Message-ID: <1758161.mMDqyN5NJP@flyosflip>
In-Reply-To: <20161008103140.GA7725@wunner.de>
References: <20161005204119.GA5961@wunner.de> <Pine.LNX.4.44L0.1610061029430.1630-100000@iolanthe.rowland.org> <20161008103140.GA7725@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

Hi guys!

Thanks for your efforts for fixing this bug! (The workaround of 
loading the kernel with "usbcore.autosuspend=-1" works very fine for 
me now).

Meanwhile, Asus gave me the expected response:

"Hello Mr. De Villemereuil,

Thank you for having solicited the ASUS Technical Support.

A reading your email I understand that your PC has a problem with 
the firmware bios from linux report.

Unfortunately, Linux is not part of our areas and we are not trained 
on.

So we have no confirmation on the Linux of the report.

Thank you for your understanding and wish you a good day."

I attached the explanation from Mathias about what is going on, but 
apparently if a bug of THEIR firmware is discovered on Linux, they 
simply freak out and say they don't do Linux (kinda expected...). 

So, I guess they won't release a fix for that... Makes your effort 
even more relevant since they sell quite a lot of computers and 
motherboards.

Cheers,
Pierre.
