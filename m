Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Jan 2017 16:03:57 -0600
From: Rob Herring <robh@kernel.org>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        frowand.list@gmail.com, bhelgaas@google.com, rafael@kernel.org,
        mark.rutland@arm.com, brian.starkey@arm.com, olof@lixom.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org, minyard@acm.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com
Subject: Re: [PATCH V6 3/5] OF: Add missing I/O range exception for
 indirect-IO  devices
Message-ID: <20170127220357.3lpavvyeymlhvlfg@rob-hp-laptop>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-4-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485241525-201782-4-git-send-email-yuanzhichang@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 24, 2017 at 03:05:23PM +0800, zhichang.yuan wrote:
> There are some special ISA/LPC devices that work on a specific I/O range where
> it is not correct to specify a 'ranges' property in DTS parent node as cpu
> addresses translated from DTS node are only for memory space on some
> architectures, such as Arm64. Without the parent 'ranges' property, current
> of_translate_address() return an error.
> Here we add special handlings for this case.
> During the OF address translation, some checkings will be perfromed to
> identify whether the device node is registered as indirect-IO. If yes, the I/O
> translation will be done in a different way from that one of PCI MMIO.
> In this way, the I/O 'reg' property of the special ISA/LPC devices will be
> parsed correctly.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Shouldn't this be Reviewed-by?

Otherwise, looks fine to me.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/address.c | 87 ++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 71 insertions(+), 16 deletions(-)
> 
