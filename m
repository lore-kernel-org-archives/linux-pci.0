Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <550A7F8D.90404@linux.intel.com>
Date: Thu, 19 Mar 2015 15:49:33 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Thomas Hellstrom <thellstrom@vmware.com>,
	"bp @ alien8 . de" <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	"yinghai @ kernel . org" <yinghai@kernel.org>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Bugfix] x86/PCI: Release PCI IRQ resource only if PCI device
 is disabled when unbinding
References: <1426577832-23164-1-git-send-email-jiang.liu@linux.intel.com> <20150318221152.GA2495@google.com>
In-Reply-To: <20150318221152.GA2495@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/19 6:11, Bjorn Helgaas wrote:
> On Tue, Mar 17, 2015 at 03:37:12PM +0800, Jiang Liu wrote:
>> To support IOAPIC hot-removal, we need to release PCI interrupt resource
>> when unbinding PCI device driver. But due to historical reason,
>> /*
>>  * We would love to complain here if pci_dev->is_enabled is set, that
>>  * the driver should have called pci_disable_device(), but the
>>  * unfortunate fact is there are too many odd BIOS and bridge setups
>>  * that don't like drivers doing that all of the time.
>>  * Oh well, we can dream of sane hardware when we sleep, no matter how
>>  * horrible the crap we have to deal with is when we are awake...
>>  */
> 
> Quoting the comment here (especially the last two lines) is overkill and
> obscures the real point.  The important thing is that some drivers have
> legitimate reasons for not calling pci_disable_device().
Hi Bjorn,
	Thanks for review. I will rewrite the commit message.
>> some drivers don't call pci_disable_device() when unloading, which
>> prevents us from reallocating PCI interrupt resource on reloading
>> PCI driver and causes regressions.
> 
> This isn't very clear.  I can believe that "drivers not calling
> pci_disable_device()" means we don't release IRQ resources, which might
> prevent you from hot-removing an IOAPIC.
> 
> But "drivers not calling pci_disable_device()" doesn't cause regressions.
> 
>> So release PCI interrupt resource only if PCI device is disabled when
>> unbinding. By this way, we could support IOAPIC hot-removal on latest
>> platforms and avoid regressions on old platforms.
> 
> Does this mean you can only hot-remove IOAPICs if all drivers for devices
> using the IOAPIC call pci_disable_device()?  If so, it seems sort of
> dubious that we have to rely on drivers for that.
This is a quickfix for v4.0 merging window. We will try to solve this
issue for next merging window.

> 
> What happens if we try to hot-remove an IOAPIC where we haven't released
> all the IRQ resources?  Is there a nice error message that will help us
> debug problem reports?
> 
> This has nothing to do with "latest platforms" and "old platforms."  That
> text pretends to convey information, but it doesn't.  To be useful, it
> would have to say something specific about how "latest" and "old" platforms
> are different.
> 
> I haven't even figured out what causes the regressions yet.  I guess maybe
> it's the fact that after b4b55cda5874, we always call pcibios_disable_irq(),
> while before we only called it if the driver used pci_disable_device()?
> The changelog should be clear about this.
> 
>> Please aslo refer to:
> 
> "also"
> 
>> https://bugzilla.kernel.org/show_bug.cgi?id=94721
>>
> 
> This apparently fixes something and needs a Fixes: tag to help people who
> might backport the broken commit.
> 
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> Reported-by: Alex Williamson <alex.williamson@redhat.com>
>> Reported-by: Thomas Hellstrom <thellstrom@vmware.com>
>> Reviewed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
>> ---
>> Hi Rafael,
>> 	I have assumed an Reviewed-by from you, is that OK?
>> Thanks!
>> Gerry
>> ---
>>  arch/x86/pci/common.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index 3d2612b68694..8d792142cb2a 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -527,7 +527,7 @@ static int pci_irq_notifier(struct notifier_block *nb, unsigned long action,
> 
> I know the notifier was added by b4b55cda5874, not this patch, but I don't
> think it's the best mechanism.  I would rather do something like calling
> pcibios_disable_irq() directly from pci_device_remove().  That way the call
> is more explicit, it's in arch-independent code, and it's more parallel
> with how we call pcibios_enable_irq() in the pci_enable_device() path.
> 
> This code is all x86-specific.  But other arches use IOAPIC, and there's
> nothing obviously x86-specific here.  Won't they still have issues here?
pcibios_enable_irq() and pcibios_disable_irq() currently are x86
specific, so I tried to keep it x86 specific.
On the other hand, we want to release IOAPIC pin when a PCI device gets
unused instead of getting removed, so just assign IRQ number for PCI
devices in use.

How about this commit message?
------------------------------------------------------------------
x86/PCI: Release PCI IRQ resource only if PCI device is disabled when
unbinding

To support IOAPIC hot-removal, we need to track IOAPIC pin usage, which
is to allocate pin on demand and release pin when unused. According to
the original design should allocate and release IOAPIC pin as below:
pci_enable_device()
    -> pcibios_enable_device() when pci_dev->enable_cnt changing from 0 to 1
        ->pcibios_enable_irq()
            ->allocate IOAPIC pin
pci_disable_device()
    -> pcibios_disable_device() when pci_dev->enable_cnt changing from 1
to 0
        ->pcibios_disable_irq()
            ->release IOAPIC pin

But above design conclicts with PCI PM design. When suspending, PCI
device driver may call pci_disable_device() and eventually release
IOAPIC pin. When resuming, PCI device driver call pci_enable_device()
and reallocating IOAPIC pin. Since v3.19, IOAPIC driver dynamically
allocates IRQ number for IOAPIC pin. So when resuming, a different
IRQ number may assigned, which breaks some PCI drivers' suspend/resume
implementation.

So commit ("x86/PCI: Refine the way to release PCI IRQ resources")
tries to fix PM regressions by releasing IOAPIC pin when unbinding
PCI driver unconditionally, which causes new regressions one some
old platforms because:
1) some PCI device drivers skip calling pci_disable_device() when
   unbinding due to BIOS flaws, which causing non-zero
   pci_dev->enable_cnt after driver unbinding.
2) pci_enable_device() doesn't call pcibios_enable_irq() because
   pci_dev->enable_cnt is not zero when rebinding device driver,
   thus no IOAPIC pin(IRQ number) assigned to PCI device after rebinding.

This patch implements a quick workaround which releases IOAPIC iff
pci_dev->enable_cnt is zero after driver unbinding. A better solution
should be to make IOAPIC allocation/releasing symmetric,
1) calling pcibios_enable_irq() on BUS_NOTIFY_BIND_DRIVER notification
2) calling pcibios_disable_irq() on BUS_NOTIFY_UNBOUND_DRIVER notification
So we could make IOAPIC pin allocation/releasing independent of
pci_dev->enable_cnt. We will try the symmetric solution for next merge
window.

Please also refer to:
https://bugzilla.kernel.org/show_bug.cgi?id=94721

Fixes: b4b55cda5874("x86/PCI: Refine the way to release PCI IRQ resources")
------------------------------------------------------------------
Thanks!
Gerry
> 
>>  	if (action != BUS_NOTIFY_UNBOUND_DRIVER)
>>  		return NOTIFY_DONE;
>>  
>> -	if (pcibios_disable_irq)
>> +	if (!pci_is_enabled(dev) && pcibios_disable_irq)
>>  		pcibios_disable_irq(dev);
>>  
>>  	return NOTIFY_OK;
>> -- 
>> 1.7.10.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
