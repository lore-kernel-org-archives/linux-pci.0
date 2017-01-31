Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 30 Jan 2017 18:09:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: Re: [PATCH V6 1/5] LIB: Indirect ISA/LPC port IO introduced
Message-ID: <20170131000914.GA11331@bhelgaas-glaptop.roam.corp.google.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-2-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1485241525-201782-2-git-send-email-yuanzhichang@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, benh@kernel.crashing.org, gabriele.paoloni@huawei.com,
 rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 linuxarm@huawei.com, frowand.list@gmail.com, lorenzo.pieralisi@arm.com,
 arnd@arndb.de, xuwei5@hisilicon.com, linux-serial@vger.kernel.org,
 catalin.marinas@arm.com, devicetree@vger.kernel.org, minyard@acm.org,
 liviu.dudau@arm.com, john.garry@huawei.com, zourongrong@gmail.com,
 robh+dt@kernel.org, bhelgaas@google.com, kantyzc@163.com,
 zhichang.yuan02@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, olof@lixom.net, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 24, 2017 at 03:05:21PM +0800, zhichang.yuan wrote:
> Low-pin-count interface is integrated into some SoCs. The accesses to those
> peripherals under LPC make use of I/O ports rather than the memory mapped I/O.
> 
> To drive these devices, this patch introduces a method named indirect-IO.

It's slightly confusing to call this "indirect I/O" and then use
"extio" for the filename and function prefix.  It'd be nice to use
related names.

> +struct extio_node {
> +	unsigned long bus_start;	/* bus start address */
> +	unsigned long io_start;	/* io port token corresponding to bus_start */
> +	size_t range_size;	/* size of the extio node operating range */
> +	struct fwnode_handle *fwnode;
> +	struct list_head list;
> +	struct extio_ops *ops;	/* ops operating on this node */
> +	void *devpara;	/* private parameter of the host device */
> +};

I wish we didn't have both struct io_range and struct extio_node.  It
seems like they're both sort of trying to do the same thing.  Maybe
this is the same as what Alex is saying.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
