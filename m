Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 6 Apr 2018 11:21:28 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 1/6] PCI: aardvark: Introduce an
 advk_pcie_valid_device() helper
Message-ID: <20180406112128.6b904f39@windsurf>
In-Reply-To: <20180404112843.GA24669@red-moon>
References: <20180329083946.25970-1-thomas.petazzoni@bootlin.com>
 <20180329083946.25970-2-thomas.petazzoni@bootlin.com>
 <20180404112843.GA24669@red-moon>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, stable@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>,
 =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Wed, 4 Apr 2018 12:28:43 +0100, Lorenzo Pieralisi wrote:
> On Thu, Mar 29, 2018 at 10:39:41AM +0200, Thomas Petazzoni wrote:
> > In other to mimic other PCIe host controller drivers, introduce an
> > advk_pcie_valid_device() helper, used in the configuration read/write
> > functions.
> > 
> > This patch by itself is not a fix, but it is required for a follow-up
> > patch that is a fix, hence the Fixes tag and the Cc to stable.  
> 
> Should not we just reshuffle patch 1 and 2 instead of sending this
> patch to stable ? I appreciate the merge window is open and timing is
> quite tight, it is just to avoid sending churn to stable kernels
> for not much.

I can certainly do that, but it's actually Bjorn who asked in the first
place to introduce the advk_pcie_valid_device() helper.

I'll send a new patch series that has these reshuffled.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
