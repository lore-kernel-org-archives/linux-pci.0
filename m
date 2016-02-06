Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42098 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbcBFQBe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 6 Feb 2016 11:01:34 -0500
Date: Sat, 6 Feb 2016 10:01:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v5 2/3] pci, pci-thunder-pem: Add PCIe host driver for
 ThunderX processors.
Message-ID: <20160206160130.GC22119@localhost>
References: <1454715675-17512-1-git-send-email-ddaney.cavm@gmail.com>
 <1454715675-17512-3-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454715675-17512-3-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

I don't have time today to look at this thoroughly, but I think I did
see one actual bug and a possible way to make this more readable.  I
think reading difficulty increases as at least the square of the
maximum indent level :)

Bjorn

On Fri, Feb 05, 2016 at 03:41:14PM -0800, David Daney wrote:
> ...
> +static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
> +				    int where, int size, u32 val)
> +{
> +	struct gen_pci *pci = bus->sysdata;
> +	struct thunder_pem_pci *pem_pci;
> +
> +	pem_pci = container_of(pci, struct thunder_pem_pci, gen_pci);
> +
> +	/*
> +	 * The first device on the bus in the PEM PCIe bridge.
> +	 * Special case its config access.
> +	 */
> +	if (bus->number == pci->cfg.bus_range->start) {
> +		u64 write_val, read_val;
> +		u32 mask = 0;
> +
> +		if (devfn != 0 || where >= 2048)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +		/*
> +		 * 32-bit accesses only.  If the write is for a size
> +		 * smaller than 32-bits, we must first read the 32-bit
> +		 * value and merge in the desired bits and then write
> +		 * the whole 32-bits back out.
> +		 */
> +		switch (size) {
> +		case 1:
> +			read_val = where & ~3ull;
> +			writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
> +			read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
> +			read_val >>= 32;
> +			mask = ~(0xff << (8 * (where & 3)));
> +			read_val &= mask;
> +			val = (val & 0xff) << (8 * (where & 3));
> +			val |= (u32)read_val;
> +			break;
> +		case 2:
> +			read_val = where & ~3ull;
> +			writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
> +			read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
> +			read_val >>= 32;
> +			mask = ~(0xffff << (8 * (where & 3)));
> +			read_val &= mask;
> +			val = (val & 0xffff) << (8 * (where & 3));
> +			val |= (u32)read_val;
> +			break;
> +		default:
> +			break;
> +
> +		}

I think it would make this easier to read if the root bus case were
split to a different function, e.g.,

  static u32 thunder_pem_root_w1c_bits(...)
  {
    ...
  }

  static int thunder_pem_root_config_write(...)
  {
    u32 mask[2] = {0xff, 0xffff};

    if (devfn != 0 || where >= 2048)
      return PCIBIOS_DEVICE_NOT_FOUND;

    if (size != 1 && size != 2 && size != 4)
      return PCIBIOS_BAD_REGISTER_NUMBER;

    /* 32-bit accesses supported natively */
    if (size == 4) {
      write_val = where & ~3ull;
      write_val |= (((u64)val) << 32);
      writeq(write_val, pem_pci->pem_reg_base + PEM_CFG_WR);
      return PCIBIOS_SUCCESSFUL;
    }

    /* smaller accesses require read/modify/write */
    read_val = where & ~3ull;
    writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
    read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
    read_val >>= 32;

    /* mask W1C bits so we don't clear them inadvertently */
    write_val = read_val & ~thunder_pem_root_w1c_bits(...);

    /* deposit new write data (which may intentionally write W1C bits) */
    val &= mask[size];
    shift = 8 * (where & 3);

    write_val &= ~(mask[size] << shift);
    write_val |= val << shift;

    write_val = where & ~3ull;
    write_val |= (((u64)val) << 32);
    writeq(write_val, pem_pci->pem_reg_base + PEM_CFG_WR);
    return PCIBIOS_SUCCESSFUL;
  }

  static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
				    int where, int size, u32 val)
  {
    ...
    if (bus->number < pci->cfg.bus_range->start ||
        bus->number > pci->cfg.bus_range->end)
      return PCIBIOS_DEVICE_NOT_FOUND;

    if (bus->number == pci->cfg.bus_range->start)
      return thunder_pem_root_config_write(...);

    return pci_generic_config_write(bus, devfn, where, size, val);
  }

> +
> +		if (mask) {
> +			/*
> +			 * By expanding the write width to 32 bits, we
> +			 * may inadvertently hit some W1C bits that
> +			 * were not intended to be written.  Mask
> +			 * these out.
> +			 *
> +			 * Some of the w1c_bits below also include
> +			 * read-only or non-writable reserved bits,
> +			 * this makes the code simpler and is OK as
> +			 * the bits are not affected by writing zeros
> +			 * to them.
> +			 */
> +			u32 w1c_bits = 0;
> +
> +			switch (where & 3) {
> +			case 0x04: /* Command/Status */
> +			case 0x1c: /* Base and I/O Limit/Secondary Status */
> +				w1c_bits = 0xff000000;
> +				break;
> +			case 0x44: /* Power Management Control and Status */
> +				w1c_bits = 0xfffffe00;
> +				break;
> +			case 0x78: /* Device Control/Device Status */
> +			case 0x80: /* Link Control/Link Status */
> +			case 0x88: /* Slot Control/Slot Status */
> +			case 0x90: /* Root Status */
> +			case 0xa0: /* Link Control 2 Registers/Link Status 2 */
> +				w1c_bits = 0xffff0000;
> +				break;
> +			case 0x104: /* Uncorrectable Error Status */
> +			case 0x110: /* Correctable Error Status */
> +			case 0x130: /* Error Status */
> +			case 0x160: /* Link Control 4 */

"where & 3" can never match any of these cases.  I suppose you meant
"where & ~3"?

> +				w1c_bits = 0xffffffff;
> +				break;
> +			default:
> +				break;
> +
> +			}
> +			if (w1c_bits) {
> +				mask &= w1c_bits;
> +				val &= ~mask;
> +			}
> +		}
> +
> +		/*
> +		 * Low order bits are the config address, the high
> +		 * order 32 bits are the data to be written.
> +		 */
> +		write_val = where & ~3ull;
> +		write_val |= (((u64)val) << 32);
> +		writeq(write_val, pem_pci->pem_reg_base + PEM_CFG_WR);
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +	if (bus->number < pci->cfg.bus_range->start ||
> +	    bus->number > pci->cfg.bus_range->end)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	return pci_generic_config_write(bus, devfn, where, size, val);
> +}
