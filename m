Return-Path: <SRS0=U+df=BC=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=U+df=BC=davemloft.net=davem@kernel.org>
Date: Tue, 03 Oct 2017 13:55:47 -0700 (PDT)
Message-Id: <20171003.135547.882515522129470867.davem@davemloft.net>
To: helgaas@kernel.org
Cc: b.zolnierkie@samsung.com, linux@roeck-us.net,
 lorenzo.pieralisi@arm.com, bhelgaas@google.com, rth@twiddle.net,
 ink@jurassic.park.msu.ru, mattst88@gmail.com, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] ide: add missing hwif->portdev freeing on
 hwif_init() failure
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171003191955.GD25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171003175742.GC27400@bhelgaas-glaptop.roam.corp.google.com>
	<20171003191108.GA25517@bhelgaas-glaptop.roam.corp.google.com>
	<20171003191955.GD25517@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 3 Oct 2017 14:19:55 -0500

> BTW, if you'd rather take these via an IDE tree, let me know and I'll
> drop it from mine.

No, feel free to take it via PCI, that's perfectly fine with me.
