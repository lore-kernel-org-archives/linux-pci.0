Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CABhMZUX_pv2Wx4u+kqwcyCOpUnZ3yi68cVpV9TAzsqx2DF5DRQ@mail.gmail.com>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
	<1331018040-30725-20-git-send-email-yinghai@kernel.org>
	<CABhMZUX_pv2Wx4u+kqwcyCOpUnZ3yi68cVpV9TAzsqx2DF5DRQ@mail.gmail.com>
Date: Tue, 6 Mar 2012 22:37:43 -0800
Message-ID: <CAE9FiQXy6dAbHrymyCVuO_C=c20Td=ymHzH+H-N8XzsQc8QeTQ@mail.gmail.com>
Subject: Re: [PATCH 19/23] PCI: add /sys/bus/pci/rescan_root
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 6, 2012 at 8:31 PM, Bjorn Helgaas <bjorn.helgaas@gmail.com> wro=
te:
> On Tue, Mar 6, 2012 at 12:13 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> It will be used to rediscover removed pci root buses.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Randy Dunlap <rdunlap@xenotime.net>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-doc@vger.kernel.org
>> ---
>> =A0Documentation/ABI/testing/sysfs-bus-pci | =A0 =A09 +++++++++
>> =A0drivers/pci/pci-sysfs.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 21 ++++=
+++++++++++++++++
>> =A02 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci
>> b/Documentation/ABI/testing/sysfs-bus-pci
>> index 22392de..eb826bd 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -66,6 +66,15 @@ Description:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0re-discover previously removed devices.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Depends on CONFIG_HOTPLUG.
>>
>> +What: =A0 =A0 =A0 =A0 =A0/sys/bus/pci/rescan_root
>> +Date: =A0 =A0 =A0 =A0 =A0March 2012
>> +Contact: =A0 =A0 =A0 Linux PCI developers <linux-pci@vger.kernel.org>
>> +Description:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Writing a non-zero value to this attribute=
 will
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cause a rescan of all PCI root buses in th=
e system, and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 re-discover previously removed PCI root bu=
ses.
>
> This seems sort of backwards to me. =A0Architecture-specific code
> enumerated the host bridges/root buses in the first place, not the PCI
> core. =A0Now we're asking the PCI core (/sys/bus/pci) to re-enumerate
> them.
>
> But maybe it's still the right answer, I dunno.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 Depends on CONFIG_HOTPLUG.
>> +
>> =A0What: =A0 =A0 =A0 =A0 =A0/sys/bus/pci/devices/.../msi_irqs/
>> =A0Date: =A0 =A0 =A0 =A0 =A0September, 2011
>> =A0Contact: =A0 =A0 =A0 Neil Horman <nhorman@tuxdriver.com>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index f855b4b..d6221e5 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -302,8 +302,29 @@ static ssize_t bus_rescan_store(struct bus_type *bu=
s,
>> const char *buf,
>> =A0 =A0 =A0 =A0return count;
>> =A0}
>>
>> +void __weak acpi_pci_root_rescan(void) { }
>> +void __weak pcibios_root_rescan(void) { }
>> +
>> +static ssize_t bus_rescan_root_store(struct bus_type *bus, const char
>> *buf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t cou=
nt)
>> +{
>> + =A0 =A0 =A0 unsigned long val;
>> +
>> + =A0 =A0 =A0 if (strict_strtoul(buf, 0, &val) < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 if (val) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&pci_remove_rescan_mutex);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_pci_root_rescan();
>
> This architecture-dependent function name should not be here. =A0How
> will we make this work for powerpc, sparc, etc.?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_root_rescan();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&pci_remove_rescan_mutex);

how about arch_pci_root_rescan(), and for x86 will let include
arch_pci_root_rescan()
pcibios_root_rescan().

need to check arch like powerpc,  sparc  to see if could
add pcibios_root_rescan()

Yinghai
