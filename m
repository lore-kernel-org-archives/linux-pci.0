Return-Path: <mj+f-140516+helgaas=kernel.org@ucw.cz>
Return-Path: <mj+f-140516+helgaas=kernel.org@ucw.cz>
Date: Sat, 14 May 2016 11:28:23 +0200
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Sean O. Stalley" <sean.stalley@intel.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com,
	david.daney@cavium.com
Subject: Re: [PATCH v4 2/2] Add support for enhanced allocation regions
Message-ID: <mj+md-20160514.092731.58710.camelot@ucw.cz>
References: <1455238345-5602-1-git-send-email-sean.stalley@intel.com>
 <1455238345-5602-3-git-send-email-sean.stalley@intel.com>
 <20160410222244.GD5852@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160410222244.GD5852@localhost>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

sorry for the delay, I was too busy with rebuilding my house :)

> > ex: a 2000 byte region should display [size=2000] instead of [size=1K]
> 
> What do you think of this?  I don't object to the kernel PCI part of
> it, but I don't want to apply it unless you plan to make lspci make
> use of it.

I like it. Applied to pciutils.git.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Nothing is smiple enough to be not screwed up.
