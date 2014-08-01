Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [RFC PATCH 00/11] Refactor MSI to support Non-PCI device
Date: Fri, 1 Aug 2014 15:16:26 +0200
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Paul.Mundt@huawei.com, Marc Zyngier <marc.zyngier@arm.com>,
	linux-pci@vger.kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	virtualization@lists.linux-foundation.org,
	Xinwei Hu <huxinwei@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, Wuyun <wuyun.wu@huawei.com>
References: <1406344128-27055-1-git-send-email-wangyijing@huawei.com> <53D89502.60506@linux.intel.com> <53D89CA1.7000501@huawei.com>
In-Reply-To: <53D89CA1.7000501@huawei.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201408011516.26253.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 30 July 2014, Yijing Wang wrote:
> >>>
> >>> The other part I'm not completely sure about is how you want to
> >>> have MSIs map into normal IRQ descriptors. At the moment, all
> >>> MSI users are based on IRQ numbers, but this has known scalability problems.
> >>
> >> Hmmm, I still use the IRQ number to map the MSIs to IRQ description.
> >> I'm sorry, I don't understand you meaning.
> >> What are the scalability problems you mentioned ?
> > We have soft limitation of nr_irqs or hard limitation NR_IRQS,
> > we couldn't allocate as much irq number as we need in some cases,
> > such as to support MSI-x.
> 
> Oh, yes, this is a potential issue. Gerry, thanks for you explanation. :)

This should no longer be an issue, as arm64 uses CONFIG_SPARSE_IRQ
and the number of interrupts is not limited in any form.

My point was more that the device driver should not need to care about
the interrupt number: it gets made up on the spot when the MSI is
needed, and then it is only used to request the IRQ. This can be
simplified into one interface at the device driver level, even though
the internal still use numbers somewhere. If we ever remove IRQ numbers
from the driver API, this part doesn't need to get touched again.

	Arnd
