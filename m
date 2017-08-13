Return-Path: <SRS0=WsbS=7P=axtens.net=dja@kernel.org>
Return-Path: <SRS0=WsbS=7P=axtens.net=dja@kernel.org>
From: Daniel Axtens <dja@axtens.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com, gabriele.paoloni@huawei.com, bhelgaas@google.com, airlied@linux.ie, daniel.vetter@intel.com, alex.williamson@redhat.com, Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc: simplify and fix VGA default device behaviour
In-Reply-To: <20170811214438.GI17039@bhelgaas-glaptop.roam.corp.google.com>
References: <20170804102033.27731-1-dja@axtens.net> <20170804102033.27731-2-dja@axtens.net> <20170811214438.GI17039@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 14 Aug 2017 08:34:05 +1000
Message-ID: <87tw1bqeqq.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for reading the patch and providing some feedback.

>> This will work as intended if there is only one device, but if
>> there are multiple devices, we may override the device the VGA
>> arbiter picked.
>
> This quirk only runs on VGA class devices.  If there's more than one
> VGA device in the system, and we assume that firmware only enables
> PCI_COMMAND_IO or PCI_COMMAND_MEMORY on "the one initialized by
> firmware", which seems reasonable to me, I think the existing code
> does match the commit message.
>
> We set the first VGA device we find to be the default.  Then, if we
> find another VGA device that's enabled, we make *it* the default
> instead.
>
>> Instead, set a device as default if there is no default device AND
>> this device decodes.
>> 
>> This will not change behaviour on single-headed systems.
>
> If there is no enabled VGA device on the system, your new code means
> there will be no default VGA device.

Ah. Right you are.

>
> It's not clear from this changelog what problem this patch solves.
> Maybe it's the "some displays not being picked up by the VGA arbiter"
> you mentioned, but there's not enough detail to connect it with the
> patch, especially since the patch means we'll set the default device
> in fewer cases than we did before.
>
> With the patch, we only set the default if we find an enabled VGA
> device.  Previously we also set the default if we found a VGA device
> that had not been enabled.

My overall problem is not having default devices on some
machines. Initially, to solve this, I wanted to make this code
generic. To do that I wanted to make sure it played nice with the vga
arbiter, so not overriding default devices willy-nilly was a
requirement. Evidently, I was overly keen and restricted its behaviour
too much.

Regardless, in this current approach I don't make this powerpc code
generic after all, so this patch is unnecessary. I will remove it for
v2, which I will post after further testing.

I document the effects of the new approach for powerpc in more detail in
patch 3 of this series. If powerpc wants to keep the existing approach
we can arrange for that too; it's a simple matter of ifdefs.

Regards,
Daniel
>
>> Cc: Brian King <brking@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> 
>> ---
>> 
>> Tested in TCG (the card provided by qemu doesn't automatically
>> register with vgaarb, so the relevant code path has been tested)
>> but I would appreciate any tests on real hardware.
>> 
>> Informal benh ack: https://patchwork.kernel.org/patch/9850235/
>> ---
>>  arch/powerpc/kernel/pci-common.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>> index 341a7469cab8..c95fdda3a2dc 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -1746,8 +1746,11 @@ static void fixup_vga(struct pci_dev *pdev)
>>  {
>>  	u16 cmd;
>>  
>> +	if (vga_default_device())
>> +		return;
>> +
>>  	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>> -	if ((cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) || !vga_default_device())
>> +	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
>>  		vga_set_default_device(pdev);
>>  
>>  }
>> -- 
>> 2.11.0
>> 
