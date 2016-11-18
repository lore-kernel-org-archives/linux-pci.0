Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for special
 ISA
Date: Fri, 18 Nov 2016 10:22:46 +0100
Message-ID: <11716372.n451O5j8Vs@wuerfel>
In-Reply-To: <20161114111111.1b753dc3@lxorguk.ukuu.org.uk>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <5900275.i4NZvtxTcC@wuerfel> <20161114111111.1b753dc3@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, catalin.marinas@arm.com,
 gabriele.paoloni@huawei.com, benh@kernel.crashing.org, will.deacon@arm.com,
 linuxarm@huawei.com, lorenzo.pieralisi@arm.com, xuwei5@hisilicon.com,
 linux-serial@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, minyard@acm.org, marc.zyngier@arm.com,
 liviu.dudau@arm.com, john.garry@huawei.com, olof@lixom.net, robh+dt@kernel.org,
 bhelgaas@google.com, kantyzc@163.com, zhichang.yuan02@gmail.com,
 linux-kernel@vger.kernel.org, "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 zourongrong@gmail.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, November 14, 2016 11:11:11 AM CET One Thousand Gnomes wrote:
> > > It's not a safe assumption for x86 at least. There are a few systems with
> > > multiple ISA busses particularly older laptops with a docking station.  
> > 
> > But do they have multiple ISA domains? There is no real harm in supporting
> > it, the (small) downsides I can think of are:
> 
> I don't believe they x86 class ones have multiple ISA domains. But as
> I've said I don't know how the electronics in the older ThinkPad worked
> when it used two PIIX4s with some LPC or ISA stuff on each.
> 
> It works in DOS and unmodified Linux so I'm pretty sure there are no
> additional domains. Likewise the various x86 schemes that route some bits
> of ISA bus off into strange places work in DOS and don't have any
> overlaps.
> 
> yenta_socket handles PCI/PCMCIA bridging and routes a range of that flat
> ISA space appropriately to the card.

Right, that's what I had expected, so we still don't even
need to handle multiple ISA I/O address spaces for the
only known case of multiple ISA buses, though we may decide
to generalize the code like that anyway.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
