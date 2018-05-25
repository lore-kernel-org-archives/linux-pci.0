Return-Path: <SRS0=pkZX=IM=google.com=rajatja@kernel.org>
Return-Path: <SRS0=pkZX=IM=google.com=rajatja@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACK8Z6HzmqP0MMs9WQ1kNyTPxdbd0Hf=cbfmvji5-2BheZ1vyw@mail.gmail.com>
References: <20180516013333.135259-1-rajatja@google.com> <20180524223751.GC15320@bhelgaas-glaptop.roam.corp.google.com>
 <CACK8Z6E6g=+T04qDUXhQrhHr1y5O05yHbjTuLM7oxnn1XJpBmw@mail.gmail.com>
 <20180525183049.GB63280@bhelgaas-glaptop.roam.corp.google.com> <CACK8Z6HzmqP0MMs9WQ1kNyTPxdbd0Hf=cbfmvji5-2BheZ1vyw@mail.gmail.com>
From: Rajat Jain <rajatja@google.com>
Date: Fri, 25 May 2018 11:38:55 -0700
Message-ID: <CACK8Z6GYaKVRWCb5Ei8m7qZmF6_QJi4JPJ-86Y_MKbHgY+yNXw@mail.gmail.com>
Subject: Re: [PATCH] lspci: Indicate if the OS / kernel go out-of-sync on BAR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Martin Mares <mj@ucw.cz>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Sorry, if it was not obvious, I'd like to self NAK this patch. Thanks.

On Fri, May 25, 2018 at 11:38 AM, Rajat Jain <rajatja@google.com> wrote:
> On Fri, May 25, 2018 at 11:30 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Fri, May 25, 2018 at 09:57:59AM -0700, Rajat Jain wrote:
>>> On Thu, May 24, 2018 at 3:37 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> > On Tue, May 15, 2018 at 06:33:33PM -0700, Rajat Jain wrote:
>>> >> If the OS and device are reporting different BAR(s), currently
>>> >> the lspci will happily show the OS version with no indication what
>>> >> so ever that there is a problem. This is not correct in my opinion
>>> >> because lspci is often used to debug devices, so should either show
>>> >> the BAR reported by the device, or atleast an indication of
>>> >> out-of-sync.
>>> >>
>>> >> I spent a lot of time debugging a PCI device that would unexpectedly
>>> >> clear out the BAR register due to some bug, and it was quite later
>>> >> I realized that the lspci is showing me the OS version. So fix that.
>>> >
>>> > I assume (hope) that "lspci -b" would show you the hardware values.
>>> > Of course, who would think to use that when you're debugging a
>>> > problem.  So that's not really a solution to the problem you faced.
>>> >
>>> >> On a system that is in problem state:
>>> >>
>>> >> localhost ~ # setpci -s 1:0.0 0x10.l
>>> >> 00000004  <=== BAR is zeroed out
>>> >> localhost ~ #
>>> >>
>>> >> Before:
>>> >>
>>> >> localhost ~ # lspci -v -s 1:0.0
>>> >> 01:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
>>> >>         Subsystem: Intel Corporation Dual Band Wireless-AC 7265
>>> >>         Flags: bus master, fast devsel, latency 0, IRQ 275
>>> >>         Memory at d1400000 (64-bit, non-prefetchable) [size=8K]
>>> >>         Capabilities: [c8] Power Management version 3
>>> >>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>> >>         Capabilities: [40] Express Endpoint, MSI 00
>>> >>         Capabilities: [100] Advanced Error Reporting
>>> >>         Capabilities: [140] Device Serial Number b4-d5-bd-ff-ff-c8-a1-6d
>>> >>         Capabilities: [14c] Latency Tolerance Reporting
>>> >>         Capabilities: [154] L1 PM Substates
>>> >>         Kernel driver in use: iwlwifi
>>> >>         Kernel modules: iwlwifi
>>> >>
>>> >> After:
>>> >>
>>> >> localhost ~ # lspci -v -s 1:0.0
>>> >> 01:00.0 Network controller: Device 8086:095a (rev 59)
>>> >>         Subsystem: Device 8086:5010
>>> >>         Flags: bus master, fast devsel, latency 0, IRQ 275
>>> >>         [out-of-sync] Memory at d1400000 (64-bit, non-prefetchable) [size=8K]
>>> >>         Capabilities: [c8] Power Management version 3
>>> >>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>> >>         Capabilities: [40] Express Endpoint, MSI 00
>>> >>         Capabilities: [100] Advanced Error Reporting
>>> >>         Capabilities: [140] Device Serial Number b4-d5-bd-ff-ff-c8-a1-6d
>>> >>         Capabilities: [14c] Latency Tolerance Reporting
>>> >>         Capabilities: [154] L1 PM Substates
>>> >>         Kernel driver in use: iwlwifi
>>> >>         Kernel modules: iwlwifi
>>> >
>>> > I've never been quite clear on the path from hardware BAR value to
>>> > lspci output.  On my system,
>>> >
>>> >   $ strace -e trace=open lspci -vs00:14.0 2>&1 | grep 00:14.0
>>> >
>>> > suggests that lspci reads these:
>>> >
>>> >   /sys/bus/pci/.../resource and
>>> >   /sys/bus/pci/.../config
>>> >
>>> > "resource" uses resource_show(), where we use the result of
>>> > pci_resource_to_user() on the resources in the struct pci_dev, so
>>> > these are basically cached and may be out of date with respect to the
>>> > hardware.
>>> >
>>> > "config" uses pci_read_config(), where we ultimately call the config
>>> > accessors, which should give us the actual values from the hardware
>>> > BARs.
>>> >
>>> >> Signed-off-by: Rajat Jain <rajatja@google.com>
>>> >> ---
>>> >>  lspci.c | 18 ++++++++++++++++++
>>> >>  1 file changed, 18 insertions(+)
>>> >>
>>> >> diff --git a/lspci.c b/lspci.c
>>> >> index 748452c..81c65f3 100644
>>> >> --- a/lspci.c
>>> >> +++ b/lspci.c
>>> >> @@ -371,6 +371,20 @@ show_range(char *prefix, u64 base, u64 limit, int is_64bit)
>>> >>    putchar('\n');
>>> >>  }
>>> >>
>>> >> +static pciaddr_t
>>> >> +bar_value(struct device *d, int i, u32 flg)
>>> >> +{
>>> >> +  pciaddr_t val = 0;
>>> >> +
>>> >> +  /* Read higher order 32 bits if it's a 64 bit bar in memory space */
>>> >> +  if (i < 5 && !(flg & PCI_BASE_ADDRESS_SPACE_IO) &&
>>> >> +      (flg & PCI_BASE_ADDRESS_MEM_TYPE_MASK == PCI_BASE_ADDRESS_MEM_TYPE_64))
>>> >> +      val = get_conf_long(d, PCI_BASE_ADDRESS_0 + 4 * (i + 1));
>>> >> +
>>> >> +  val = (val << 32) | flg;
>>> >> +  return val;
>>> >> +}
>>> >> +
>>> >>  static void
>>> >>  show_bases(struct device *d, int cnt)
>>> >>  {
>>> >> @@ -401,6 +415,10 @@ show_bases(struct device *d, int cnt)
>>> >>         flg = pos;
>>> >>         virtual = 1;
>>> >>       }
>>> >> +      else if (pos != bar_value(d, i, flg))
>>> >> +     {
>>> >> +       printf("[out-of-sync] ");
>>> >
>>> > If the host bridge does any address translation, e.g., if it uses ACPI
>>> > _TRA, isn't this going to print "out-of-sync" for *every* BAR, even if
>>> > it isn't really out of sync?
>>>
>>> Need a clarification here to ensure I understand you right. When you
>>> refer to address translation above, I assume you are referring to a
>>> situation where the CPU issues reads to an address X (in CPU address
>>> space), which goes through a translation at the pcie root port /
>>> controller, and appears as a read from address Y (as seen on the PCIe
>>> bus side)?
>>
>> It appears as a read *to* address Y on PCI (I'm sure that's what you had
>> in mind).  Linux shows it like this when it enumerates the host bridge:
>>
>>   pci_bus 0000:00: root bus resource [mem 0xf0000000000-0xf007edfffff] (bus address [0x80000000-0xfedfffff])
>>
>> A CPU read to physical address 0xf0000000000 will appear on PCI with the
>> bus address 0x80000000.  The PCI BAR would contain 0x80000000.
>>
>>> In such a situation, my understanding (may be wrong) was that the
>>> lspci is supposed to be showing the PCI address Y for the bar (not
>>> address X in physical address space). If this understanding is wrong
>>> (and the lspci is supposed to show address CPU X for the bar), then
>>> yes, this patch is likely not correct.
>>
>> My impression, based on the man page text about the "-b" option was the
>> opposite:
>>
>>   -b     Bus-centric  view.  Show all IRQ numbers and addresses as
>>          seen by the cards on the PCI bus instead of as seen by the
>>          kernel.
>
> Oh, sorry I was wrong. Thanks for correcting me.
>
>>
>> That suggests to me that by default lspci shows addresses as seen by
>> the kernel, i.e., using CPU physical addresses.  These match what
>> /proc/iomem shows (at least if you look at /proc/iomem as root).
>>
>>> But I do think lspci should have a way to indicate when the bars in
>>>  /sys/bus/pci/.../resource and
>>>  /sys/bus/pci/.../config
>>> get out of sync.
>>
>> I don't disagree; that does sound like it could be useful.  I just
>> don't know the best way to accomplish it.
>
> Lets leave it for some other time I think. For now, the lspci -b seems
> to accomplish what I want (so I'll change my scripts to use it as
> needed). Thanks!
>
>>  Seems like you'd have to do
>> something in resource_show() to re-read the BAR and validate the
>> cache.  I don't know what you do if you find that it's invalid.
>>
>>> >
>>> >> +     }
>>> >>        if (flg & PCI_BASE_ADDRESS_SPACE_IO)
>>> >>       {
>>> >>         pciaddr_t a = pos & PCI_BASE_ADDRESS_IO_MASK;
>>> >> --
>>> >> 2.17.0.441.gb46fe60e1d-goog
>>> >>
