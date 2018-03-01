Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1519931483.10722.342.camel@linux.intel.com>
Subject: Re: [PATCH v15 1/9] LIB: Introduce a generic PIO mapping method
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>,
        mika.westerberg@linux.intel.com, rafael@kernel.org,
        lorenzo.pieralisi@arm.com, rjw@rjwysocki.net,
        hanjun.guo@linaro.org, robh+dt@kernel.org, bhelgaas@google.com,
        arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net,
        dann.frazier@canonical.com, andy.shevchenko@gmail.com,
        robh@kernel.org
Cc: joe@perches.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com, minyard@acm.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        rdunlap@infradead.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, frowand.list@gmail.com, agraf@suse.de
Date: Thu, 01 Mar 2018 21:11:23 +0200
In-Reply-To: <1519663249-9850-2-git-send-email-john.garry@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
         <1519663249-9850-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-02-27 at 00:40 +0800, John Garry wrote:
> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
> 
> In commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
> pci_pio_to_address()"), a new I/O space management was supported. With
> that driver, the I/O ranges configured for PCI/PCIe hosts on some
> architectures can be mapped to logical PIO, converted easily between
> CPU address and the corresponding logicial PIO. Based on this, PCI
> I/O devices can be accessed in a memory read/write way through the
> unified in/out accessors.
> 
> But on some archs/platforms, there are bus hosts which access I/O
> peripherals with host-local I/O port addresses rather than memory
> addresses after memory-mapped.
> 
> To support those devices, a more generic I/O mapping method is
> introduced
> here. Through this patch, both the CPU addresses and the host-local
> port
> can be mapped into the logical PIO space with different logical/fake
> PIOs.
> After this, all the I/O accesses to either PCI MMIO devices or host-
> local
> I/O peripherals can be unified into the existing I/O accessors defined
> in
> asm-generic/io.h and be redirected to the right device-specific hooks
> based on the input logical PIO.
> 

A bit more small comments.


> +#ifndef __LINUX_LOGIC_PIO_H
> +#define __LINUX_LOGIC_PIO_H
> +

> +#ifdef __KERNEL__

Hmm... How the header in include/linux/ can be non-kernel?

> +	list_for_each_entry_rcu(range, &io_range_list, list) {

> +		if (range->flags == LOGIC_PIO_CPU_MMIO &&
> +				new_range->flags ==
> LOGIC_PIO_CPU_MMIO) {

It's rather fancy indentation.

> +			if (start >= range->hw_start + range->size ||
> +			    end < range->hw_start)

Misses {}

> +				allocated_mmio_size += range->size;
> +			else {
> +				ret = -EFAULT;
> +				goto end_register;
> +			}

> +		if (allocated_mmio_size + new_range->size - 1 >
> +			MMIO_UPPER_LIMIT) {

Fancy indentation.

> +			if (allocated_mmio_size + SZ_64K - 1 >
> +			MMIO_UPPER_LIMIT) {

Ditto.

> +		if (allocated_iio_size + new_range->size - 1 >
> +		    IO_SPACE_LIMIT) {

While this is nothing wrong, like above I would consider to check how
long it is and consider putting on one line.

> +/**
> + * logic_pio_to_hwaddr - translate logical PIO to HW address
> + * @pio: logical PIO value
> + *
> + * Returns HW address if valid, -1 otherwise

It can't return -1 when the return type is unsigned.

> + *
> + * Translate the input logical pio to the corresponding hardware
> address.
> + * The input pio should be unique in the whole logical PIO space.
> + */
> +resource_size_t logic_pio_to_hwaddr(unsigned long pio)
> +{
> +	struct logic_pio_hwaddr *range;

> +	resource_size_t hwaddr = (resource_size_t)-1;

Ditto.

> +	return hwaddr;
> +}

> +	list_for_each_entry_rcu(range, &io_range_list, list) {
> +		if (range->flags != LOGIC_PIO_CPU_MMIO)
> +			continue;

> +		if (addr >= range->hw_start &&
> +		    addr < range->hw_start + range->size)

Perhaps you may copy'n'paste in_range() macro from fs/ext* files and use
in this module. At some point it would be good to make it generic.

> +			return addr - range->hw_start +
> +				range->io_start;


> +	}


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
