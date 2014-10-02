Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37842 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753054AbaJBAQ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 20:16:27 -0400
Message-ID: <1412208952.4285.239.camel@pasglop>
Subject: Re: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Thu, 02 Oct 2014 10:15:52 +1000
In-Reply-To: <1412201282.4285.232.camel@pasglop>
References: <1412129393.4285.195.camel@pasglop>
	 <s5htx3o44tv.wl-tiwai@suse.de> <1412149289.4285.204.camel@pasglop>
	 <s5hr3ys43ev.wl-tiwai@suse.de> <s5hoatw42f6.wl-tiwai@suse.de>
	 <CADnq5_P1qTkedSuFfgJ=dd5cWji1-OUbmKoUyq+kLQgPGYYaQw@mail.gmail.com>
	 <1412201282.4285.232.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-10-02 at 08:08 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2014-10-01 at 13:58 -0400, Alex Deucher wrote:
> > Patch looks good.  Audio DMAs are limited to 40 bits, same as the GPU
> > side.  I'm still waiting to hear back on the MSIs for audio, but they
> > probably follow the GPU side, so I expect they should be fixed on Sea
> > Islands as well.
> 
> In the audio driver we don't have the "family names", just a list of
> PCI IDs, do you happen to know which ones are unaffected ?

So I tried to be more discriminate but in the end, I had to give up, the
most recent ID we have in the driver seems to be Cap Verde/Pitcairn,
which isn't fixed. So either we are missing IDs or the new cards use the
same ID.

I think the consequences of being over-zealous here are nil on what
matters, ie, x86. AFAIK, x86 always uses 32-bit addresses for MSIs
anyway, so it's unaffected and ARM ... well, I doubt it will be. In
general, I don't think we have a big issue here by just flagging them
all.

I'll send an updated series with just the flag name changed as suggested
by Alex and the DMA bits updated as suggested by Takashi.

Cheers,
Ben.


