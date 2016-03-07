Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0100.outbound.protection.outlook.com ([157.56.111.100]:10594
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752506AbcCGSCQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Mar 2016 13:02:16 -0500
Message-ID: <56DDC220.5080003@caviumnetworks.com>
Date: Mon, 7 Mar 2016 10:02:08 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Yury Norov <ynorov@caviumnetworks.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>,
	Dann Frazier <dann.frazier@canonical.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v7 2/3] pci, pci-thunder-pem: Add PCIe host driver for
 ThunderX processors.
References: <1457130708-3231-1-git-send-email-ddaney.cavm@gmail.com> <1457130708-3231-3-git-send-email-ddaney.cavm@gmail.com> <20160305155409.GA2532@yury-N73SV>
In-Reply-To: <20160305155409.GA2532@yury-N73SV>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/05/2016 07:54 AM, Yury Norov wrote:
[...]
>> +static u32 thunder_pem_bridge_w1c_bits(int where)
>> +{
>> +	u32 w1c_bits = 0;
>> +
>> +	switch (where & ~3) {
>> +	case 0x04: /* Command/Status */
>> +	case 0x1c: /* Base and I/O Limit/Secondary Status */
>> +		w1c_bits = 0xff000000;
>> +		break;
>> +	case 0x44: /* Power Management Control and Status */
>> +		w1c_bits = 0xfffffe00;
>> +		break;
>> +	case 0x78: /* Device Control/Device Status */
>> +	case 0x80: /* Link Control/Link Status */
>> +	case 0x88: /* Slot Control/Slot Status */
>> +	case 0x90: /* Root Status */
>> +	case 0xa0: /* Link Control 2 Registers/Link Status 2 */
>> +		w1c_bits = 0xffff0000;
>> +		break;
>> +	case 0x104: /* Uncorrectable Error Status */
>> +	case 0x110: /* Correctable Error Status */
>> +	case 0x130: /* Error Status */
>> +	case 0x160: /* Link Control 4 */
>
> This patchset is full of magic numbers.

Yes.  Did you notice that there is a comment with each one describing 
what it is, or what it is doing?


> For better readability

I disagree with that.

Doing a:

  #define CN8890_PASS1_LINK_CONTROL_4_CONFIG_SPACE_OFFSET 0x160

and then later using the symbol adds clutter.  The current code is 
compact, and *more* readable than scattering the information across 
multiple sites in the file.

> and portability,

The whole point of this file is that we are fixing up accesses for a 
very small and tightly constrained set of systems.  It is not a general 
purpose PCI root complex with standard bridges that will be used by 
multiple vendors and architectures.  Portability is not a big concern.

> it's better to declare all that as macro:
> #define LINK_CONTROL_4 0x160
>
> If there's some specific reason to use numbers, I think, it should be
> explained.
>

I had hoped that the changlog for the commit combined with the comments 
in the file would be sufficient.

I try to explain in this e-mail my thoughts on some of the stylistic 
choices I made while writing the code, but I don't plan on including 
them into the patch itself.

>> +		w1c_bits = 0xffffffff;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +	return w1c_bits;
>> +}
>> +
>> +static int thunder_pem_bridge_write(struct pci_bus *bus, unsigned int devfn,
>> +				    int where, int size, u32 val)
>> +{
>> +	struct gen_pci *pci = bus->sysdata;
>> +	struct thunder_pem_pci *pem_pci;
>> +	u64 write_val, read_val;
>> +	u32 mask = 0;
>> +
>> +	pem_pci = container_of(pci, struct thunder_pem_pci, gen_pci);
>> +
>> +	if (devfn != 0 || where >= 2048)
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>> +	/*
>> +	 * 32-bit accesses only.  If the write is for a size smaller
>> +	 * than 32-bits, we must first read the 32-bit value and merge
>> +	 * in the desired bits and then write the whole 32-bits back
>> +	 * out.
>> +	 */
>> +	switch (size) {
>> +	case 1:
>> +		read_val = where & ~3ull;
>> +		writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
>> +		read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
>> +		read_val >>= 32;
>> +		mask = ~(0xff << (8 * (where & 3)));
>
> I'm pretty sure, there's no any rocket science, but it's hard to
> understand what happens here. What is 8? Bits in byte? Bytes in word?
> Anything PCI-specific?  Moreover, you repeat this line several times
> here (though little modified). Maybe it deserves to be wrapped by some
> explaining macro?

I tried to explain this in the comment above the switch statement.

I doubt breaking the masking operations out into out-of-line functions 
would add to the readability.

>
>> +		read_val &= mask;
>> +		val = (val & 0xff) << (8 * (where & 3));
>> +		val |= (u32)read_val;
>> +		break;
>> +	case 2:
>
> Case 1 and 2 are looking very similar. Is it possible to wrap them?
> For now it looks like code duplication.

They are indeed similar, differing only in mask width.

If Bjorn insists, we could probably factor some of this code out into a 
separate function.  Personally, I don't think it is worthwhile, as doing 
so would probably increase the number of lines in the file.

>
>> +		read_val = where & ~3ull;
>> +		writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
>> +		read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
>> +		read_val >>= 32;
>> +		mask = ~(0xffff << (8 * (where & 3)));
>> +		read_val &= mask;
>> +		val = (val & 0xffff) << (8 * (where & 3));
>> +		val |= (u32)read_val;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	/*
>> +	 * By expanding the write width to 32 bits, we may
>> +	 * inadvertently hit some W1C bits that were not intended to
>> +	 * be written.  Calculate the mask that must be applied to the
>> +	 * data to be written to avoid these cases.
>> +	 */
>> +	if (mask) {
>> +		u32 w1c_bits = thunder_pem_bridge_w1c_bits(where);
>> +
>> +		if (w1c_bits) {
>> +			mask &= w1c_bits;
>> +			val &= ~mask;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Low order bits are the config address, the high order 32
>> +	 * bits are the data to be written.
>> +	 */
>> +	write_val = where & ~3ull;
>> +	write_val |= (((u64)val) << 32);
>> +	writeq(write_val, pem_pci->pem_reg_base + PEM_CFG_WR);
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
[...]
