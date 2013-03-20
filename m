Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 Mar 2013 19:12:50 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Oliver Neukum <oneukum@suse.de>, Michal Marek <mmarek@suse.cz>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciehp: Add pciehp_surprise module option
Message-ID: <20130320191250.GA11262@srcf.ucam.org>
References: <s5h38vqjhk6.wl%tiwai@suse.de>
 <20130320175234.GA8948@srcf.ucam.org>
 <s5hppytq430.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <s5hppytq430.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 20, 2013 at 08:11:15PM +0100, Takashi Iwai wrote:
> At Wed, 20 Mar 2013 17:52:34 +0000,
> Matthew Garrett wrote:
> > Well that just sounds like a bug. What's the downside to just ignoring 
> > that capability bit?
> 
> I'm afraid that it's too radical to enable always.

Why?

> Or, what about to check this bit only for disable path?

What happens if you unplug the device on one of the affected machines?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
