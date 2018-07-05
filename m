Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 5 Jul 2018 16:19:09 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] PCI: aardvark: Size bridges before resources
 allocation
Message-ID: <20180705161909.2a7a6030@windsurf>
In-Reply-To: <20180705141522.GA13716@red-moon>
References: <20180629091620.31503-1-thomas.petazzoni@bootlin.com>
 <20180629091620.31503-2-thomas.petazzoni@bootlin.com>
 <20180705141522.GA13716@red-moon>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Zachary Zhang <zhangzg@marvell.com>,
 Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello Lorenzo,

Thanks for your feedback!

On Thu, 5 Jul 2018 15:15:22 +0100, Lorenzo Pieralisi wrote:

> I am queueing these two patches but this one seems a serious bug,
> I reckon we should send it to stable kernels (and would be grateful
> if you provide me with a Fixes tag and a kernel log to add to the
> commit log).

It is a serious bug, but it is not a regression. I.e whatever is fixed
by this patch never worked. So if you take a conservative view on
pushing patches to stable and only want to fix regressions, this one
doesn't qualify. However, if you take a more open approach and say you
want to fix obvious bugs/issues even in older stable kernels, then
indeed this patch qualifies.

If you are within the kernel developers with this more open approach to
sending patches to stable, then you can add:

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>

when applying the patch. Unless of course you want me to resend the
patch series with this added. Just let met know what you prefer.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
