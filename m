Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:53320 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152AbbIXWss (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 18:48:48 -0400
Date: Fri, 25 Sep 2015 00:40:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] pci: mvebu: generate proper configuration access
 cycles
Message-ID: <20150924224034.GH20825@lunn.ch>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
 <E1Zenfg-0004d5-Dg@rmk-PC.arm.linux.org.uk>
 <20150924222322.GF20825@lunn.ch>
 <20150924224305.GG21513@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150924224305.GG21513@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > I tried
> > 
> > root@dir665:~# setpci -s 1:0.0 0xe8.l
> > 00102000
> > root@dir665:~# setpci -s 1:0.0 0xe8.w=0x2000
> > root@dir665:~# setpci -s 1:0.0 0xe8.l
> > 00102000
> > 
> > but that is not producing the FAIL you had.
> 
> The only bit you have set in your DevSta register is:
> 
> #define  PCI_EXP_DEVSTA_AUXPD   0x0010  /* AUX Power Detected */
> 
> which is not a RW1C bit.

So i cannot actually test this on my hardware :-(

I guess the best i can do is apply the patch, load the wifi driver,
and ensure i can still join a network.

    Andrew
