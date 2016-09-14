Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Zhichang Yuan <yuanzhichang@hisilicon.com>,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        benh@kernel.crashing.org, minyard@acm.org,
        linux-pci@vger.kernel.org, gabriele.paoloni@huawei.com,
        john.garry@huawei.com, will.deacon@arm.com, xuwei5@hisilicon.com,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        zourongrong@gmail.com, liviu.dudau@arm.com, kantyzc@163.com,
        zhichang.yuan02@gmail.com
Subject: Re: [PATCH V3 3/4] ARM64 LPC: support serial based on low-pin-count
Date: Wed, 14 Sep 2016 14:25:54 +0200
Message-ID: <4340181.AghlmQIy28@wuerfel>
In-Reply-To: <1473855354-150093-4-git-send-email-yuanzhichang@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com> <1473855354-150093-4-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 14, 2016 8:15:53 PM CEST Zhichang Yuan wrote:
> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> 
> On Hip06 platform, a 16550 compatible UART is connected to low-pin-count and
> controlled through the LPC I/O cycles. After registering the LPC uart specific
> serial_in/serial_out to 8250 core driver, serial data can be read/written
> through the LPC.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> 

I still think this should be handled by 8250_of.c after the addition of
support for IORESOURCE_IO.

	Arnd
