Return-Path: <SRS0=U+df=BC=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=U+df=BC=davemloft.net=davem@kernel.org>
Date: Mon, 02 Oct 2017 20:09:44 -0700 (PDT)
Message-Id: <20171002.200944.1868499443421449979.davem@davemloft.net>
To: helgaas@kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 bhelgaas@google.com, rth@twiddle.net, ink@jurassic.park.msu.ru,
 linux@roeck-us.net, mattst88@gmail.com
Subject: Re: [PATCH v2] drivers/ide/pci: Fix legacy IRQ assignment
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171002235320.GA27400@bhelgaas-glaptop.roam.corp.google.com>
References: <1506941567-10762-1-git-send-email-lorenzo.pieralisi@arm.com>
	<20171002235320.GA27400@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 2 Oct 2017 18:53:20 -0500

> The patch below now only touches drivers/ide/ide-scan-pci.c.
> 
> It fixes a problem introduced via the PCI tree, so I'd be happy to
> merge the fix as well, given an ack from you, Dave.  Or you can merge
> it yourself with my ack:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Bjorn, feel free to merge this via the PCI tree with my ACK:

Acked-by: David S. Miller <davem@davemloft.net>
