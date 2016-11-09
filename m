Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for special
 ISA
Date: Wed, 09 Nov 2016 22:38:32 +0100
Message-ID: <5900275.i4NZvtxTcC@wuerfel>
In-Reply-To: <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <2368890.jTbyGqYR0M@wuerfel> <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, gabriele.paoloni@huawei.com,
 benh@kernel.crashing.org, will.deacon@arm.com, linuxarm@huawei.com,
 lorenzo.pieralisi@arm.com, xuwei5@hisilicon.com, linux-serial@vger.kernel.org,
 catalin.marinas@arm.com, devicetree@vger.kernel.org, minyard@acm.org,
 marc.zyngier@arm.com, liviu.dudau@arm.com, john.garry@huawei.com,
 zourongrong@gmail.com, robh+dt@kernel.org, bhelgaas@google.com,
 kantyzc@163.com, zhichang.yuan02@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 olof@lixom.net
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 9, 2016 1:54:53 PM CET One Thousand Gnomes wrote:
> > I think it is a relatively safe assumption that there is only one
> > ISA bridge. A lot of old drivers hardcode PIO or memory addresses
> 
> It's not a safe assumption for x86 at least. There are a few systems with
> multiple ISA busses particularly older laptops with a docking station.

But do they have multiple ISA domains? There is no real harm in supporting
it, the (small) downsides I can think of are:

- a few extra cycles for the lookup, from possibly walking a linked list
  to find the correct set of helpers and MMIO addresses
- making it too general could invite more people to design hardware
  around the infrastructure when we really want them to stop adding
  stuff like this.

	Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
