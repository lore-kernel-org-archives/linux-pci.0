Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbcKHLud (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Nov 2016 06:50:33 -0500
Date: Tue, 8 Nov 2016 11:49:53 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        bhelgaas@google.com, olof@lixom.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org, minyard@acm.org,
        benh@kernel.crashing.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com, marc.zyngier@arm.com
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Message-ID: <20161108114953.GB15297@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 08, 2016 at 11:47:08AM +0800, zhichang.yuan wrote:
> +Hisilicon Hip06 low-pin-count device
> +  Usually LPC controller is part of PCI host bridge, so the legacy ISA ports
> +  locate on LPC bus can be accessed direclty. But some SoCs have independent
> +  LPC controller, and access the legacy ports by triggering LPC I/O cycles.
> +  Hisilicon Hip06 implements this LPC device.

s/direclty/directly/

My understanding of ISA (which may be flawed) is that it's not part of
the PCI host bridge, but rather on x86 it happens to share the IO space
with PCI.

So, how about this becomes:

  Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
  provides access to some legacy ISA devices.

I believe that we could theoretically have multiple independent LPC/ISA
busses, as is possible with PCI on !x86 systems. If the current ISA code
assumes a singleton bus, I think that's something that needs to be fixed
up more generically.

I don't see why we should need any architecture-specific code here. Why
can we not fix up the ISA bus code in drivers/of/address.c such that it
handles multiple ISA bus instances, and translates all sub-device
addresses relative to the specific bus instance?

> +Required properties:
> +- compatible: should be "hisilicon,low-pin-count"

This would be better as something like:

	"hisilicon,hip06-lpc-controller"

If it's reused in other SoCs, we can add more strings as we usually do.

> +- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
> +- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
> +- reg: base memory range where the register set of this device is mapped.
> +
> +Note:
> +  The node name before '@' must be "isa" to represent the binding stick to the
> +  ISA/EISA binding specification.
> +
> +Example:
> +
> +isa@a01b0000 {
> +	compatible = "hisilicom,low-pin-count";

s/hisilicom/hisilicon/

My comment above on the compatible string also applies.

> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	reg = <0x0 0xa01b0000 0x0 0x1000>;
> +
> +	ipmi0: bt@e4 {
> +		compatible = "ipmi-bt";
> +		device_type = "ipmi";
> +		reg = <0x01 0xe4 0x04>;
> +		status = "disabled";
> +	};
> +};

Please remove the status property; it's irrelevant to the example.

[...]

> +/**
> + * indirect_io_enabled - check whether indirectIO is enabled.
> + *	arm64_extio_ops will be set only when indirectIO mechanism had been
> + *	initialized.
> + *
> + * Returns true when indirectIO is enabled.
> + */
> +bool indirect_io_enabled(void)
> +{
> +	return arm64_extio_ops ? true : false;
> +}

	return !!arm64_extio_ops;

> +/**
> + * addr_is_indirect_io - check whether the input taddr is for indirectIO.
> + * @taddr: the io address to be checked.
> + *
> + * Returns 1 when taddr is in the range; otherwise return 0.
> + */
> +int addr_is_indirect_io(u64 taddr)
> +{
> +	if (arm64_extio_ops->start > taddr || arm64_extio_ops->end < taddr)
> +		return 0;
> +
> +	return 1;
> +}

Why not bool?

I don't think this is the right thing to do, regardless.

> + * of_isa_indirect_io - get the IO address from some isa reg property value.
> + *	For some isa/lpc devices, no ranges property in ancestor node.
> + *	The device addresses are described directly in their regs property.
> + *	This fixup function will be called to get the IO address of isa/lpc
> + *	devices when the normal of_translation failed.
> + *
> + * @parent:	points to the parent dts node;
> + * @bus:		points to the of_bus which can be used to parse address;
> + * @addr:	the address from reg property;
> + * @na:		the address cell counter of @addr;
> + * @presult:	store the address paresed from @addr;
> + *
> + * return 1 when successfully get the I/O address;
> + * 0 will return for some failures.
> + */
> +static int of_get_isa_indirect_io(struct device_node *parent,
> +				struct of_bus *bus, __be32 *addr,
> +				int na, u64 *presult)
> +{
> +	unsigned int flags;
> +	unsigned int rlen;
> +
> +	/* whether support indirectIO */
> +	if (!indirect_io_enabled())
> +		return 0;
> +
> +	if (!of_bus_isa_match(parent))
> +		return 0;
> +
> +	flags = bus->get_flags(addr);
> +	if (!(flags & IORESOURCE_IO))
> +		return 0;
> +
> +	/* there is ranges property, apply the normal translation directly. */
> +	if (of_get_property(parent, "ranges", &rlen))
> +		return 0;
> +
> +	*presult = of_read_number(addr + 1, na - 1);
> +	/* this fixup is only valid for specific I/O range. */
> +	return addr_is_indirect_io(*presult);
> +}
> +
>  static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>  			    struct of_bus *pbus, __be32 *addr,
>  			    int na, int ns, int pna, const char *rprop)
> @@ -595,6 +639,15 @@ static u64 __of_translate_address(struct device_node *dev,
>  			result = of_read_number(addr, na);
>  			break;
>  		}
> +		/*
> +		 * For indirectIO device which has no ranges property, get
> +		 * the address from reg directly.
> +		 */
> +		if (of_get_isa_indirect_io(dev, bus, addr, na, &result)) {
> +			pr_debug("isa indirectIO matched(%s)..addr = 0x%llx\n",
> +				of_node_full_name(dev), result);
> +			break;
> +		}

I don't believe this is the right place for this to live. This should
live in the isa of_bus, matched in the usual way with of_match_bus(),
and used in pbus->translate() in of_translate_one().

If we need to extend the prototypes of those functions, we should do so.

If we need to be able to register instance-specific translations or
indirection, we should build the infrastructure for that rather than
forcing a singleton translation in here.

Thanks,
Mark.
