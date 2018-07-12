Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 12 Jul 2018 11:24:46 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: emulated PCI bridge common logic
Message-ID: <20180712112446.74998bd9@windsurf>
In-Reply-To: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
References: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Russell King <linux@arm.linux.org.uk>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
 Zachary Zhang <zhangzg@marvell.com>, Wilson Ding <dingwei@marvell.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, Lorenzo,

On Fri, 29 Jun 2018 11:22:28 +0200, Thomas Petazzoni wrote:

> The pci-mvebu driver already contains some logic to emulate a root
> port PCI bridge. It turns out that we have a similar need for the
> pci-aardvark driver. Instead of duplicating the same logic in two
> drivers, this patch series starts by adding a small common
> infrastructure that helps emulate a root port PCI bridge, converts
> pci-mvebu to use it, and finally extends pci-aardvark to use it as
> well.
> 
> Thanks to this, Marvell Armada 3720 based systems, which use the
> Aarkvark PCI controller, will have better PCI support, by having a
> root port PCI bridge exposed.
> 
> The emulated PCI bridge common logic is a proposal, I very much
> welcome comments and suggestions. Also, if you feel that adding a
> common logic for only two drivers is too early, I'm fine with
> duplicating a bit of code betwen pci-mvebu and pci-aardvark.

I was wondering if you had any feedback on this patch series. Not
necessarily a detailed review, but at least some general
feeling/feedback on the overall approach would be very nice.

Thanks a lot,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
