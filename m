Return-Path: <SRS0=Fe65=6I=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=Fe65=6I=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v9 0/3] Tango PCIe controller support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <20170704202412.GK13824@bhelgaas-glaptop.roam.corp.google.com>
 <6256cab3-dd77-c0f6-66b8-be261695bbb1@free.fr>
 <20170705180359.GL13824@bhelgaas-glaptop.roam.corp.google.com>
 <5a1207cb-31fd-6b85-86af-8c37bd57ad4f@free.fr>
 <20170705213419.GD25063@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <8dcab663-245b-880a-be3a-2965fd12d663@free.fr>
Date: Wed, 5 Jul 2017 23:59:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170705213419.GD25063@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 05/07/2017 23:34, Bjorn Helgaas wrote:

> On Wed, Jul 05, 2017 at 10:39:19PM +0200, Mason wrote:
>
>> On 05/07/2017 20:03, Bjorn Helgaas wrote:
>>
>>> On Wed, Jul 05, 2017 at 12:55:37AM +0200, Mason wrote:
>>>
>>>> On 04/07/2017 22:24, Bjorn Helgaas wrote:
>>>>
>>>>> I made the trivial changes I mentioned, added a dependency on
>>>>> CONFIG_BROKEN (for the config/MMIO muxing issue), and put these on
>>>>> pci/host-tango.  I can't build or test this, so I probably broke
>>>>> something in the process.  I think the combination of the boot-time
>>>>> warning, the taint, and CONFIG_BROKEN is a reasonable amount of
>>>>> warning that a user should expect issues.
>>>>>
>>>>> Can you take a look and see if it works for you?
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-tango
>>>>
>>>> Thanks. I'll take it for a spin ASAP.
>>>>
>>>> TAINT_CRAP... Smirk. I didn't see that one in the docs:
>>>> https://www.kernel.org/doc/html/latest/admin-guide/tainted-kernels.html
>>>>
>>>> Oh wait... TAINT_CRAP is "C" => a staging driver has been loaded
>>>
>>> I wish it had a less pejorative, more descriptive name.  But it seems like
>>> the closest to this situation.
>>
>> Maybe it is not too late to submit a patch to Linus
>> renaming TAINT_CRAP?
>>
>> Here are a few candidates, off the top of my head:
>>
>> TAINT_STAGING
>> TAINT_STAGING_DRIVER
>> TAINT_BROKEN_HW
>> TAINT_BROKEN_HARDWARE
>> TAINT_USE_AT_YOUR_OWN_RISK
> 
> I personally wouldn't object, but it's not a PCI thing so that can all
> be separate from this driver.

Yes, of course. I was just asking for your (and anyone's)
opinion, as a Linux dev.

>>>> The one issue I anticipate with "depends on BROKEN" is
>>>> when I add support for revision 2, which isn't broken.
>>>
>>> How about this:
>>>
>>>   - Rename PCIE_TANGO to PCIE_TANGO_REV1
>>>   - PCIE_TANGO_REV1 depends on BROKEN
>>>   - Add rev2 support later, enabled by PCIE_TANGO
>>>   - PCIE_TANGO_REV1 depends on PCIE_TANGO && BROKEN
>>>
>>> I updated pci/host-tango along these lines (without rev2 support,
>>> obviously).
>>
>> And support for REV1 wouldn't be compiled in, unless
>> BROKEN is selected? Yes, I think that could fly.
> 
> Right.
> 
>> Don't you think the naming should follow the DT
>> convention of using the first SoC embedding the
>> IP (for the compatible string) ?
>>
>> PCIE_TANGO_REV1 vs PCIE_TANGO_SMP8759
> 
> Sounds reasonable.  So v2 will be something other than SMP8759?
> I renamed it to CONFIG_PCIE_TANGO_SMP8759.

Right, HW bugs are fixed in newer chips. Old chips rarely
get bug fixes, apparently.

> If you confirm that
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-tango&id=d752a8b29345
> works for you, I'll include it in my v4.13 pull request.

There were a few nits I wanted to address:

- Since we added suppress_bind_attrs = true, probe()
can only be called at init, so I wanted to mark __init
all the probe functions, to save space.

- I left the definition of MSI_MAX in the wrong patch

- You put a pointer to the pdev in the struct tango_pcie.
I think this is redundant, since the pdev already has a
pointer to the struct, as drvdata.
So I wanted to change tango_msi_probe() to take a pdev
as argument (to make it more like an actual probe function)
and derive pcie from pdev, instead of the other way around.

Can I send you a patch series with these changes on Friday?

Regards.
