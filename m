Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40019 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754066AbaLHW42 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Dec 2014 17:56:28 -0500
Message-ID: <1418079372.13358.9.camel@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Clear bridge MEM_64 flag if one child does not
 support it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Marek =?ISO-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>,
	zermond@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Tue, 09 Dec 2014 09:56:12 +1100
In-Reply-To: <1418075552-26495-1-git-send-email-yinghai@kernel.org>
References: <1418075552-26495-1-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-12-08 at 13:52 -0800, Yinghai Lu wrote:
> 2. or scan the children resource other than ROM to clear bridge MEM_64
>    for mmio pref.
> 
> The patch is using second way so will keep child mmio pref into bridge
> mmio pref range.

That means that having a single ROM BAR that is 32-bit and prefetchable
will downgrade the entire window to 32-bit ? That's not going to work
either.

I have GPUs with 16G BARs for example... suddenly they don't fit
anaymore because we downgraded the window to 32 bit because somewhere
there's a 32-bit pref resource ?

That will break more than it fixes...

Ben.


