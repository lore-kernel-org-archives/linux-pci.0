Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Bugfix v4] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32-bit kernel
To: Tomasz Nowicki <tn@semihalf.com>
References: <559107F2.3080701@pr.hu>
 <1436340399-19695-1-git-send-email-jiang.liu@linux.intel.com>
 <563780FC.5070503@linaro.org> <563B5161.1060105@semihalf.com>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Boszormenyi Zoltan <zboszor@pr.hu>,
	Len Brown <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <563B588C.1010507@linux.intel.com>
Date: Thu, 5 Nov 2015 21:24:28 +0800
MIME-Version: 1.0
In-Reply-To: <563B5161.1060105@semihalf.com>
Content-Type: multipart/mixed;
 boundary="------------070305040105010509060604"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070305040105010509060604
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 2015/11/5 20:53, Tomasz Nowicki wrote:
> On 02.11.2015 16:27, Tomasz Nowicki wrote:
>> On 08.07.2015 09:26, Jiang Liu wrote:
>>> Zoltan Boszormenyi reported this regression:
>>>    "There's a Realtek RTL8111/8168/8411 (PCI ID 10ec:8168, Subsystem ID
>>>     1565:230e) network chip on the mainboard. After the r8169 driver
>>> loaded
>>>     the IRQs in the machine went berserk. Keyboard keypressed arrived
>>> with
>>>     considerable latency and duplicated, so no real work was possible.
>>>     The machine responded to the power button but didn't actually power
>>>     down. It just stuck at the powering down message. I had to press the
>>>     power button for 4 seconds to power it down.
>>>
>>>     The computer is a POS machine with a big battery inside. Because
>>> of this,
>>>     either ACPI or the Realtek chip kept the bad state and after
>>> rebooting,
>>>     the network chip didn't even show up in lspci. Not even the PXE ROM
>>>     announced itself during boot. I had to disconnect the battery to
>>> beat
>>>     some sense back to the computer.
>>>
>>>     The regression happens with 4.0.5, 4.1.0-rc8 and 4.1.0-final.
>>> 3.18.16 was
>>>     good."
>>>
>>> The regression is caused by commit 593669c2ac0f ("x86/PCI/ACPI: Use
>>> common
>>> ACPI resource interfaces to simplify implementation"). Since commit
>>> 593669c2ac0f, x86 PCI ACPI host bridge driver validates ACPI
>>> resources by
>>> first converting an ACPI resource to a 'struct resource' structure and
>>> then applying checks against the converted resource structure. The
>>> 'start'
>>> and 'end' fields in 'struct resource' are defined to be type of
>>> resource_size_t, which may be 32 bits or 64 bits depending on
>>> CONFIG_PHYS_ADDR_T_64BIT.
>>>
>>> This may cause incorrect resource validation results with 32-bit kernels
>>> because 64-bit ACPI resource descriptors may get truncated when
>>> converting
>>> to 32-bit 'start' and 'end' fields in 'struct resource'. It eventually
>>> affects PCI resource allocation subsystem and makes some PCI devices and
>>> the system behave abnormally due to incorrect resource assignment.
>>>
>>> So enhance the ACPI resource parsing interfaces to ignore ACPI resource
>>> descriptors with address/offset above 4G when running in 32-bit mode.
>>>
>>> With the fix applied, the behavior of the machine was restored to how
>>> 3.18.16 worked, i.e. the memory range that is over 4GB is ignored again,
>>> and lspci -vvxxx shows that everything is at the same memory window as
>>> they were with 3.18.16.
>>>
>>> Reported-and-Tested-by: Boszormenyi Zoltan <zboszor@pr.hu>
>>> Fixes: 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource
>>> interfaces to simplify implementation")
>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>>> Cc: stable@vger.kernel.org # 4.0
>>> ---
>>>   drivers/acpi/resource.c |   24 +++++++++++++++---------
>>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>> index 10561ce16ed1..e8d281739cbc 100644
>>> --- a/drivers/acpi/resource.c
>>> +++ b/drivers/acpi/resource.c
>>> @@ -194,6 +194,7 @@ static bool acpi_decode_space(struct resource_win
>>> *win,
>>>       u8 iodec = attr->granularity == 0xfff ? ACPI_DECODE_10 :
>>> ACPI_DECODE_16;
>>>       bool wp = addr->info.mem.write_protect;
>>>       u64 len = attr->address_length;
>>> +    u64 start, end, offset = 0;
>>>       struct resource *res = &win->res;
>>>
>>>       /*
>>> @@ -205,9 +206,6 @@ static bool acpi_decode_space(struct resource_win
>>> *win,
>>>           pr_debug("ACPI: Invalid address space min_addr_fix %d,
>>> max_addr_fix %d, len %llx\n",
>>>                addr->min_address_fixed, addr->max_address_fixed, len);
>>>
>>> -    res->start = attr->minimum;
>>> -    res->end = attr->maximum;
>>> -
>>>       /*
>>>        * For bridges that translate addresses across the bridge,
>>>        * translation_offset is the offset that must be added to the
>>> @@ -215,12 +213,22 @@ static bool acpi_decode_space(struct
>>> resource_win *win,
>>>        * primary side. Non-bridge devices must list 0 for all Address
>>>        * Translation offset bits.
>>>        */
>>> -    if (addr->producer_consumer == ACPI_PRODUCER) {
>>> -        res->start += attr->translation_offset;
>>> -        res->end += attr->translation_offset;
>>> -    } else if (attr->translation_offset) {
>>> +    if (addr->producer_consumer == ACPI_PRODUCER)
>>> +        offset = attr->translation_offset;
>>> +    else if (attr->translation_offset)
>>>           pr_debug("ACPI: translation_offset(%lld) is invalid for
>>> non-bridge device.\n",
>>>                attr->translation_offset);
>>> +    start = attr->minimum + offset;
>>> +    end = attr->maximum + offset;
>>
>> I still see the issue for this area, I mean ACPI_IO_RANGE. You are
>> adding translation offset to attr->minimum, build resource structure
>> which is then passed to acpi_dev_ioresource_flags and compared against
>> 0x10003. It causes some IO ranges to be ignored.
>>
> 
> Kindly reminder, any comments?
> 
> Tomasz
Hi Tomasz,
	Thanks for reporting this issue! Could you please help to
test the attached patch?
Thanks,
Gerry


--------------070305040105010509060604
Content-Type: text/x-patch;
 name="0001-ACPI-Fix-an-error-in-IO-port-range-validation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ACPI-Fix-an-error-in-IO-port-range-validation.patch"

>From 2afdf4595dc961a2472ba1a35d7f67046b1845d2 Mon Sep 17 00:00:00 2001
From: Liu Jiang <jiang.liu@linux.intel.com>
Date: Thu, 5 Nov 2015 21:13:23 +0800
Subject: [PATCH] ACPI: Fix an error in IO port range validation


Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 15d22db05054..5bb1daa562b0 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -119,14 +119,14 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
 EXPORT_SYMBOL_GPL(acpi_dev_resource_memory);
 
 static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
-				      u8 io_decode)
+				      u64 offset, u8 io_decode)
 {
 	res->flags = IORESOURCE_IO;
 
 	if (!acpi_dev_resource_len_valid(res->start, res->end, len, true))
 		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
 
-	if (res->end >= 0x10003)
+	if (res->end - offset >= 0x10003)
 		res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
 
 	if (io_decode == ACPI_DECODE_16)
@@ -138,7 +138,7 @@ static void acpi_dev_get_ioresource(struct resource *res, u64 start, u64 len,
 {
 	res->start = start;
 	res->end = start + len - 1;
-	acpi_dev_ioresource_flags(res, len, io_decode);
+	acpi_dev_ioresource_flags(res, len, 0, io_decode);
 }
 
 /**
@@ -231,7 +231,7 @@ static bool acpi_decode_space(struct resource_win *win,
 		acpi_dev_memresource_flags(res, len, wp);
 		break;
 	case ACPI_IO_RANGE:
-		acpi_dev_ioresource_flags(res, len, iodec);
+		acpi_dev_ioresource_flags(res, len, offset, iodec);
 		break;
 	case ACPI_BUS_NUMBER_RANGE:
 		res->flags = IORESOURCE_BUS;
-- 
1.7.10.4


--------------070305040105010509060604--
