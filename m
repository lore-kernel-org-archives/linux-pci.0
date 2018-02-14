Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
To: Bjorn Helgaas <helgaas@kernel.org>,
        George Cherian <george.cherian@cavium.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <20180213150907.GD75542@bhelgaas-glaptop.roam.corp.google.com>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <dd104986-81e2-e7a2-353c-91827078bc4c@caviumnetworks.com>
Date: Wed, 14 Feb 2018 16:58:08 +0530
MIME-Version: 1.0
In-Reply-To: <20180213150907.GD75542@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for the review.

On 02/13/2018 08:39 PM, Bjorn Helgaas wrote:
> [+cc Lorenzo]
> 
> On Fri, Feb 02, 2018 at 07:00:46AM +0000, George Cherian wrote:
>> The PCIe Controller on Cavium ThunderX2 processors does not
>> respond to downstream CFG/ECFG cycles when root port is
>> in power management D3-hot state.
> 
> I think you're talking about the CPU initiating a config cycle to
> a device below the root port, right?
Yes
> 
> This erratum isn't published anywhere where we could include a URL,
> is it?
This erratum is available at support.cavium.com, You might need to 
register to the website to get hold of a copy.
> 
>> In our tests the above mentioned errata causes the following crash when
>> the downstream endpoint config space is accessed, while root port is in
>> D3 state.
>>
>> [   12.775202] Unhandled fault: synchronous external abort (0x96000610) at 0x0000000000000000
> 
> This looks like another example of not being able to deal with error
> responses to PCIe events, for example, the whole mess with drivers
> checking whether the link is up before issuing a config access.
> 
> In that sense, this looks like a band-aid that avoids the issue by
> preventing the use of D3, but doesn't fix the underlying problem.  If
> we *could* deal nicely with this error, maybe we could use D3 on these
> root ports.
> 
> So I'm not convinced yet that this is actually a PCIe erratum.  Does
> the hardware actually violate the PCIe spec, or is this just a problem
> with the kernel not knowing how to deal nicely with a PCIe error?
> 
This is not an issue with the way kernel handles the PCIe error.

> If you could include the erratum text and reference to the relevant
> section of the PCIe spec, that would be useful.
>
The relevant section of the PCIe Spec is the following Section 5.3 on 
wards (subsection  5.3.1.4.1)

Configuration and Message requests are the only TLPs accepted by a 
Function in the D3hot state. All other received Requests must be handled 
as Unsupported Requests, and all received Completions may optionally be 
handled as Unexpected Completions.

>> [   12.783453] Internal error: : 96000610 [#1] SMP
>> [   12.787971] Modules linked in: aes_neon_blk ablk_helper cryptd
>> [   12.793799] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-32-generic #34
>> [   12.800659] Hardware name: Cavium Inc. Unknown/Unknown, BIOS 1.0 01/01/2018
>> [   12.807607] task: ffff808f346b8d80 task.stack: ffff808f346b4000
>> [   12.813518] PC is at pci_generic_config_read+0x5c/0xf0
>> [   12.818643] LR is at pci_generic_config_read+0x48/0xf0
>> [   12.823767] pc : [<ffff000008506f34>] lr : [<ffff000008506f20>] pstate: 204000c9
>> [   12.831148] sp : ffff808f346b7bf0
>> [   12.834449] x29: ffff808f346b7bf0 x28: ffff000008e2b848
>> [   12.839750] x27: ffff000008dc3070 x26: ffff000008d516c0
>> [   12.845050] x25: 0000000000000040 x24: ffff00000937a480
>> [   12.850351] x23: 000000000000006c x22: 0000000000000000
>> [   12.855651] x21: ffff808f346b7c84 x20: 0000000000000004
>> [   12.860951] x19: ffff808f31076000 x18: 0000000000000000
>> [   12.866251] x17: 000000001b3613e6 x16: 000000007f330457
>> [   12.871551] x15: 0000000067268ad7 x14: 000000005c6254ac
>> [   12.876851] x13: 00000000f1e100cb x12: 0000000000000030
>> [   12.882151] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
>> [   12.887452] x9 : ff656d6e626d686f x8 : 7f7f7f7f7f7f7f7f
>> [   12.892752] x7 : ffff808f310da108 x6 : 0000000000000000
>> [   12.898052] x5 : 0000000000000003 x4 : ffff808f3107a800
>> [   12.903352] x3 : 000000000030006c x2 : 0000000000000014
>> [   12.908652] x1 : ffff000020000000 x0 : ffff00002030006c
>> [   12.913952]
>> [   12.915431] Process swapper/0 (pid: 1, stack limit = 0xffff808f346b4020)
>> [   12.922118] Stack: (0xffff808f346b7bf0 to 0xffff808f346b8000)
>> [   12.927850] 7be0:                                   ffff808f346b7c30 ffff000008506e2c
>> [   12.935665] 7c00: ffff000009185000 000000000000006c ffff808f31076000 ffff808f346b7d14
>> [   12.943481] 7c20: 0000000000000000 ffff000008309488 ffff808f346b7c90 ffff0000085089f4
>> [   12.951296] 7c40: 0000000000000004 ffff808f310d4000 0000000000000000 ffff808f346b7d14
>> [   12.959111] 7c60: 0000000000000068 ffff000008dc3078 ffff000008d604c8 ffff0000085089d8
>> [   12.966927] 7c80: 0000000000000004 000000000004080b ffff808f346b7cd0 ffff000008513d28
>> [   12.974742] 7ca0: ffff000009185000 00000000ffffffe7 0000000000000001 ffff808f310d4000
>> [   12.982557] 7cc0: ffff0000092ae000 ffff808f310d4000 ffff808f346b7d20 ffff0000085142d4
>> [   12.990372] 7ce0: ffff808f310d4000 ffff808f310d4000 ffff000009214000 ffff808f310d40b0
>> [   12.998188] 7d00: ffff0000092ae000 ffff808f310d40b0 00000000092ae000 000000000004080b
>> [   13.006003] 7d20: ffff808f346b7d40 ffff000008518754 0000000000000000 ffff808f310d4000
>> [   13.013818] 7d40: ffff808f346b7d80 ffff000008d9a974 0000000000000000 ffff808f310d4000
>> [   13.021634] 7d60: ffff000008d9a93c 0000000000000000 ffff0000092ae000 000000000004080b
>> [   13.029449] 7d80: ffff808f346b7da0 ffff000008083b4c ffff000009185000 ffff808f346b4000
>> [   13.037264] 7da0: ffff808f346b7e30 ffff000008d60dfc 00000000000000f5 ffff000009185000
>> [   13.045079] 7dc0: ffff0000092ae000 0000000000000007 ffff0000092ae000 ffff000008dc3078
>> [   13.052895] 7de0: ffff000008d604c8 ffff000008d51600 ffff000008dc3070 ffff000008e2b720
>> [   13.060710] 7e00: ffff0000091a68d8 ffff000008c09678 0000000000000000 0000000700000007
>> [   13.068526] 7e20: 0000000000000000 000000000004080b ffff808f346b7ea0 ffff000008980d90
>> [   13.076342] 7e40: ffff000008980d78 0000000000000000 0000000000000000 0000000000000000
>> [   13.084157] 7e60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.091972] 7e80: 0000000000000000 0000000000000000 0000000000000000 000000000004080b
>> [   13.099788] 7ea0: 0000000000000000 ffff000008083690 ffff000008980d78 0000000000000000
>> [   13.107603] 7ec0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.115418] 7ee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.123233] 7f00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.131048] 7f20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.138864] 7f40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.146679] 7f60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.154494] 7f80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.162309] 7fa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.170125] 7fc0: 0000000000000000 0000000000000005 0000000000000000 0000000000000000
>> [   13.177940] 7fe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [   13.185755] Call trace:
>> [   13.188190] Exception stack(0xffff808f346b7a00 to 0xffff808f346b7b30)
>> [   13.194616] 7a00: ffff808f31076000 0001000000000000 ffff808f346b7bf0 ffff000008506f34
>> [   13.202432] 7a20: 00000000204000c9 0000000000000003 ffff000009660000 0000000000000007
>> [   13.210247] 7a40: ffff000000000000 0000000000000000 ffff0000092c2d3b 414d48203a6d7665
>> [   13.218062] 7a60: 3a73727474612043 0000000000000024 0000000005f5e0ff 0000000000000006
>> [   13.225878] 7a80: 0000000000000007 ffff0000092c2d25 ffff808f346b7aa0 ffff00000849bc1c
>> [   13.233693] 7aa0: ffff808f346b7b20 ffff00000849c100 0000000000000000 000000000004080b
>> [   13.241508] 7ac0: ffff00002030006c ffff000020000000 0000000000000014 000000000030006c
>> [   13.249323] 7ae0: ffff808f3107a800 0000000000000003 0000000000000000 ffff808f310da108
>> [   13.257139] 7b00: 7f7f7f7f7f7f7f7f ff656d6e626d686f 7f7f7f7f7f7f7f7f 0101010101010101
>> [   13.264953] 7b20: 0000000000000030 00000000f1e100cb
>> [   13.269819] [<ffff000008506f34>] pci_generic_config_read+0x5c/0xf0
>> [   13.275987] [<ffff000008506e2c>] pci_bus_read_config_dword+0xb4/0xd8
>> [   13.282328] [<ffff0000085089f4>] pcie_capability_read_dword+0x64/0xb8
>> [   13.288757] [<ffff000008513d28>] __pci_dev_reset+0x90/0x328
>> [   13.294317] [<ffff0000085142d4>] pci_probe_reset_function+0x24/0x30
>> [   13.300571] [<ffff000008518754>] pci_create_sysfs_dev_files+0x18c/0x2a0
>> [   13.307173] [<ffff000008d9a974>] pci_sysfs_init+0x38/0x60
>> [   13.312560] [<ffff000008083b4c>] do_one_initcall+0x5c/0x170
>> [   13.318122] [<ffff000008d60dfc>] kernel_init_freeable+0x1c0/0x27c
>> [   13.324205] [<ffff000008980d90>] kernel_init+0x18/0x110
>> [   13.329416] [<ffff000008083690>] ret_from_fork+0x10/0x40
>> [   13.334716] Code: 7100069f 540003c0 71000a9f 54000240 (b9400001)
>> [   13.340805] ---[ end trace fc992038acd29ec3 ]---
> 
> Most of this dmesg output is overkill -- I don't think the timestamps,
> the register contents, or the hex stack dump will contribute to
> understanding the issue or helping a user match a problem with this
> patch.
Yes I will update the commit log in a better way to capture the issue.
> 
>> Fix this by adding a quirk that prevents the root port from
>> entering D3 state. This is seen on both Ax/Bx variants of the processor.
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> ---
>>   drivers/pci/quirks.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 10684b1..2eb08a8 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -1154,6 +1154,18 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
>>   
>>   /*
>> + * Cavium's Thunder-X2 Processors root port doesnot handle cfg/ecfg access to
>> + * downstream properly if root port is put into D3
>> + */
>> +
>> +static void quirk_no_rootport_d3(struct pci_dev *pdev)
>> +{
>> +	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM, 0x9084, quirk_no_rootport_d3);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xaf84, quirk_no_rootport_d3);
> 
> I assume this is really only of interest if we have the Thunder-X2
> host bridge driver in the kernel, right?  Could the quirk be moved to
> that driver so it's not included in everybody's kernel?
> 
We dont have a separate driver for  THUNDERX2 PCIhost. It uses the 
pci-host-generic driver. Instead I can have the changes to be under
#ifdef CONFIG_ARCH_THUNDER2
#endif

so that it is only included for CONFIG_ARCH_THUNDER2 enabled builds.

>> +
>> +/*
>>    * Some ATA devices break if put into D3
>>    */
>>   
>> -- 
>> 2.1.4
>>

Regards,
-George
