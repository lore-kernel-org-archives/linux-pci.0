Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48054 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110AbaJAWI6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 18:08:58 -0400
Message-ID: <1412201282.4285.232.camel@pasglop>
Subject: Re: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Thu, 02 Oct 2014 08:08:02 +1000
In-Reply-To: <CADnq5_P1qTkedSuFfgJ=dd5cWji1-OUbmKoUyq+kLQgPGYYaQw@mail.gmail.com>
References: <1412129393.4285.195.camel@pasglop>
	 <s5htx3o44tv.wl-tiwai@suse.de> <1412149289.4285.204.camel@pasglop>
	 <s5hr3ys43ev.wl-tiwai@suse.de> <s5hoatw42f6.wl-tiwai@suse.de>
	 <CADnq5_P1qTkedSuFfgJ=dd5cWji1-OUbmKoUyq+kLQgPGYYaQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-10-01 at 13:58 -0400, Alex Deucher wrote:
> Patch looks good.  Audio DMAs are limited to 40 bits, same as the GPU
> side.  I'm still waiting to hear back on the MSIs for audio, but they
> probably follow the GPU side, so I expect they should be fixed on Sea
> Islands as well.

In the audio driver we don't have the "family names", just a list of
PCI IDs, do you happen to know which ones are unaffected ?

Cheers,
Ben.


