Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 30 Aug 2017 15:07:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Luebbe <jlu@pengutronix.de>
Subject: Re: [PATCH 0/2] fix 4GB DRAM window support on mvebu
Message-ID: <20170830200700.GX8154@bhelgaas-glaptop.roam.corp.google.com>
References: <20170828152517.24506-1-jlu@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20170828152517.24506-1-jlu@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 Gregory Clement <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 28, 2017 at 05:25:15PM +0200, Jan Luebbe wrote:
> The current MBUS DRAM window calculation fails for 4GB windows because it
> overflows. This is fixed in the first patch by using u64 instead of u32 to
> store the size. The second excplicitly checks that we don't try to configure a
> too large memory window in the pci driver.
> 
> As they don't depend on each other, they could also go in separatly.
> 
> Jan Luebbe (2):
>   bus: mbus: fix window size calculation for 4GB windows
>   PCI: mvebu: Check DRAM window size
> 
>  drivers/bus/mvebu-mbus.c     |  2 +-
>  drivers/pci/host/pci-mvebu.c | 27 ++++++++++++++++++++++-----
>  include/linux/mbus.h         |  4 ++--
>  3 files changed, 25 insertions(+), 8 deletions(-)

Since these can be applied separately, I'll let somebody else take care of
the drivers/bus/mvebu-mbus.c part.

I'll look for an ack from Thomas or Jason before applying the second patch,
which touches drivers/pci/host/pci-mvebu.c.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
