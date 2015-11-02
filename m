Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35587 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbbKBP2H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2015 10:28:07 -0500
Received: by lfbn126 with SMTP id n126so62987543lfb.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2015 07:28:05 -0800 (PST)
Subject: Re: [Bugfix v4] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32-bit kernel
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Boszormenyi Zoltan <zboszor@pr.hu>, Len Brown <lenb@kernel.org>
References: <559107F2.3080701@pr.hu>
 <1436340399-19695-1-git-send-email-jiang.liu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Message-ID: <563780FC.5070503@linaro.org>
Date: Mon, 2 Nov 2015 16:27:56 +0100
MIME-Version: 1.0
In-Reply-To: <1436340399-19695-1-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08.07.2015 09:26, Jiang Liu wrote:
> Zoltan Boszormenyi reported this regression:
>    "There's a Realtek RTL8111/8168/8411 (PCI ID 10ec:8168, Subsystem ID
>     1565:230e) network chip on the mainboard. After the r8169 driver loaded
>     the IRQs in the machine went berserk. Keyboard keypressed arrived with
>     considerable latency and duplicated, so no real work was possible.
>     The machine responded to the power button but didn't actually power
>     down. It just stuck at the powering down message. I had to press the
>     power button for 4 seconds to power it down.
>
>     The computer is a POS machine with a big battery inside. Because of this,
>     either ACPI or the Realtek chip kept the bad state and after rebooting,
>     the network chip didn't even show up in lspci. Not even the PXE ROM
>     announced itself during boot. I had to disconnect the battery to beat
>     some sense back to the computer.
>
>     The regression happens with 4.0.5, 4.1.0-rc8 and 4.1.0-final. 3.18.16 was
>     good."
>
> The regression is caused by commit 593669c2ac0f ("x86/PCI/ACPI: Use common
> ACPI resource interfaces to simplify implementation"). Since commit
> 593669c2ac0f, x86 PCI ACPI host bridge driver validates ACPI resources by
> first converting an ACPI resource to a 'struct resource' structure and
> then applying checks against the converted resource structure. The 'start'
> and 'end' fields in 'struct resource' are defined to be type of
> resource_size_t, which may be 32 bits or 64 bits depending on
> CONFIG_PHYS_ADDR_T_64BIT.
>
> This may cause incorrect resource validation results with 32-bit kernels
> because 64-bit ACPI resource descriptors may get truncated when converting
> to 32-bit 'start' and 'end' fields in 'struct resource'. It eventually
> affects PCI resource allocation subsystem and makes some PCI devices and
> the system behave abnormally due to incorrect resource assignment.
>
> So enhance the ACPI resource parsing interfaces to ignore ACPI resource
> descriptors with address/offset above 4G when running in 32-bit mode.
>
> With the fix applied, the behavior of the machine was restored to how
> 3.18.16 worked, i.e. the memory range that is over 4GB is ignored again,
> and lspci -vvxxx shows that everything is at the same memory window as
> they were with 3.18.16.
>
> Reported-and-Tested-by: Boszormenyi Zoltan <zboszor@pr.hu>
> Fixes: 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces to simplify implementation")
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: stable@vger.kernel.org # 4.0
> ---
>   drivers/acpi/resource.c |   24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 10561ce16ed1..e8d281739cbc 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -194,6 +194,7 @@ static bool acpi_decode_space(struct resource_win *win,
>   	u8 iodec = attr->granularity == 0xfff ? ACPI_DECODE_10 : ACPI_DECODE_16;
>   	bool wp = addr->info.mem.write_protect;
>   	u64 len = attr->address_length;
> +	u64 start, end, offset = 0;
>   	struct resource *res = &win->res;
>
>   	/*
> @@ -205,9 +206,6 @@ static bool acpi_decode_space(struct resource_win *win,
>   		pr_debug("ACPI: Invalid address space min_addr_fix %d, max_addr_fix %d, len %llx\n",
>   			 addr->min_address_fixed, addr->max_address_fixed, len);
>
> -	res->start = attr->minimum;
> -	res->end = attr->maximum;
> -
>   	/*
>   	 * For bridges that translate addresses across the bridge,
>   	 * translation_offset is the offset that must be added to the
> @@ -215,12 +213,22 @@ static bool acpi_decode_space(struct resource_win *win,
>   	 * primary side. Non-bridge devices must list 0 for all Address
>   	 * Translation offset bits.
>   	 */
> -	if (addr->producer_consumer == ACPI_PRODUCER) {
> -		res->start += attr->translation_offset;
> -		res->end += attr->translation_offset;
> -	} else if (attr->translation_offset) {
> +	if (addr->producer_consumer == ACPI_PRODUCER)
> +		offset = attr->translation_offset;
> +	else if (attr->translation_offset)
>   		pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge device.\n",
>   			 attr->translation_offset);
> +	start = attr->minimum + offset;
> +	end = attr->maximum + offset;

I still see the issue for this area, I mean ACPI_IO_RANGE. You are 
adding translation offset to attr->minimum, build resource structure 
which is then passed to acpi_dev_ioresource_flags and compared against 
0x10003. It causes some IO ranges to be ignored.

> +
> +	win->offset = offset;
> +	res->start = start;
> +	res->end = end;
> +	if (sizeof(resource_size_t) < sizeof(u64) &&
> +	    (offset != win->offset || start != res->start || end != res->end)) {
> +		pr_warn("acpi resource window ([%#llx-%#llx] ignored, not CPU addressable)\n",
> +			attr->minimum, attr->maximum);
> +		return false;
>   	}
>
>   	switch (addr->resource_type) {
> @@ -237,8 +245,6 @@ static bool acpi_decode_space(struct resource_win *win,
>   		return false;
>   	}
>
> -	win->offset = attr->translation_offset;
> -
>   	if (addr->producer_consumer == ACPI_PRODUCER)
>   		res->flags |= IORESOURCE_WINDOW;
>
>

Thanks,
Tomasz
