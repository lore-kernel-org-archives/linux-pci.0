Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V5 0/4] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Wed, 29 Mar 2017 20:16:19 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B2846675D9B9@IRSMSX101.ger.corp.intel.com>
References: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
 <f062dc8f-df66-bfd8-a0d7-50ac1cadf975@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846675AEDC@IRSMSX101.ger.corp.intel.com>
 <c9820456-d9b1-cd97-533b-889905e27603@codeaurora.org>
 <1f677feb-b561-1dd3-69ad-afd4049b6d59@codeaurora.org>
 <f3e76f8d-16bb-8ec5-da9b-d62ca66dafd6@codeaurora.org>
 <92EBB4272BF81E4089A7126EC1E7B2846675D8C4@IRSMSX101.ger.corp.intel.com>
 <beb63ced-3e63-c09c-8c2c-5d5b0956d2fc@codeaurora.org>
In-Reply-To: <beb63ced-3e63-c09c-8c2c-5d5b0956d2fc@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "timur@codeaurora.org" <timur@codeaurora.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

>On 3/29/2017 1:27 PM, Patel, Mayurkumar wrote:
>> Hi Kaya
>>
>>>
>>> On 3/28/2017 9:04 AM, Sinan Kaya wrote:
>>>> On 3/28/2017 8:52 AM, Sinan Kaya wrote:
>>>>> On 3/28/2017 2:02 AM, Patel, Mayurkumar wrote:
>>>>>> Thanks for your patches. I am seeing kernel panic after applying
>>>>>> these patches (on top of latest kernel) each time during early boot in pci_aspm_init() (any hints already?) function.
>>>>>> Need to check if it's something related to my local setup or it's because of these changes.
>>>>>> For now I don't have more details why it crashes but I will dig in further and I will provide
>>>>>> you more data as soon as I have it.
>>>>>>
>>>>>
>>>>> Interesting, I retested Qemu and I don't see an issue.
>>>>> Can you share your bootlog when you see the crash?
>>>>>
>>>> Thinking more...
>>>>
>>>> Can you add this to the top of pci_aspm_init() and try again?
>>>>
>>>> if (!pci_is_pcie(pdev))
>>>>           return -EINVAL;
>>>>
>>>
>>> Did this help?
>>
>> No, It did not helped. I tested without your patches and no panic seen.
>
>I think you have a mixture of old and new patches or a mixture of old/new object files.
>pci_function_0() is no longer getting called from pci_aspm_init(). This was done in V4 of the patch.
>


>>
>> I found with your patch in pci_aspm_init() call, pdev->subordinate is not valid which causes a crash in
>> pci_function_0().
>> I tentatively started validating pdev->subordinate pointer and proceeding pci_aspm_init()  without allocating link->downstream pointer,
>> then I got another following issue during boot. I will further debug it but if you have any other suggestion or some other clicks in your
>mind
>> what this could be I could try that too.
>>
>
>I think you have a mixture of old and new patches or a mixture of old/new object files.
>
>> [    2.339374]  pcie_get_aspm_reg+0x39/0x1a0
>> [    2.387312]  pcie_aspm_init_link_state+0x2aa/0x900
>> [    2.444611]  ? pci_device_add+0x20a/0x300
>
>This was also done in V4 of the patch. This was replaced by pci_aspm_init() in V5 and
>there is no call from device_add path into pci_aspm_init() function. The
>pcie_aspm_init_link_state() gets called from the pci_scan_slot() as it used to be.
>
>Can you try it on a clean tree with the following patches?
>
>https://patchwork.codeaurora.org/patch/207667/
>https://patchwork.codeaurora.org/patch/207653/
>https://patchwork.codeaurora.org/patch/207669/
>https://patchwork.codeaurora.org/patch/207651/
>
>The only change you should need on top of this is this.
>
>--- a/drivers/pci/pcie/aspm.c
>+++ b/drivers/pci/pcie/aspm.c
>@@ -847,6 +847,9 @@ int pci_aspm_init(struct pci_dev *pdev)
>        if (!pdev->has_secondary_link)
>                return 0;
>
>+       if (!pci_is_pcie(pdev))
>+               return -EINVAL;
>+
>        link = alloc_pcie_link_state(pdev);
>        if (!link)
>                return -ENOMEM;
>
>

Actually, I have taken same patches of yours which proposed and applied it correctly. Will try it with clean
build if that helps.

But what I could understand from following patch is https://patchwork.codeaurora.org/patch/207653/ 

We still have a flow of pci_aspm_init() -> alloc_pcie_link_state() -> pci_function_0()
Where I see the first Kernel NULL pointer crash while accessing pdev->subordinate in pci_function_0() function.

To mitigate that I included following code in it.

@@ -430,8 +439,11 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 {
 	struct pci_dev *child;
 
+	if (!linkbus)
+		return NULL;
+
 	list_for_each_entry(child, &linkbus->devices, bus_list)
		if (PCI_FUNC(child->devfn) == 0)
			return child;
 	return NULL;


Then I start seeing following error as pdev-> downstream stays NULL.

>
>> [    0.835443] BUG: unable to handle kernel NULL pointer dereference at 000000000000003e
>> [    0.929138] IP: pcie_capability_read_dword+0x82/0x1a0
>> [    0.989555] PGD 0
>> [    0.989556]
>> [    1.031360] Oops: 0000 [#1] SMP
>> [    1.068901] Modules linked in:
>> [    1.105403] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc4-aspmtestv6 #24
>> [    1.192861] Hardware name:    /IC97, BIOS IV97R903 02/25/2016
>> [    1.261600] task: ffff9141435c8000 task.stack: ffffa6b8418c0000
>> [    1.332419] RIP: 0010:pcie_capability_read_dword+0x82/0x1a0
>> [    1.399077] RSP: 0000:ffffa6b8418c39b0 EFLAGS: 00010246
>> [    1.461575] RAX: 0000000000000000 RBX: 000000000000000c RCX: ffffffff85e5be08
>> [    1.546954] RDX: ffffa6b8418c39ec RSI: 000000000000000c RDI: 0000000000000000
>> [    1.632332] RBP: ffffa6b8418c39d8 R08: 0000000000000001 R09: 0000000000000171
>> [    1.717707] R10: 0000000000000000 R11: 0000000000000170 R12: 0000000000000000
>> [    1.803085] R13: ffffa6b8418c39ec R14: ffff914142e370c0 R15: 0000000000000000
>> [    1.888462] FS:  0000000000000000(0000) GS:ffff914155c80000(0000) knlGS:0000000000000000
>> [    1.985278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    2.054017] CR2: 000000000000003e CR3: 0000000300e09000 CR4: 00000000003406e0
>> [    2.139396] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [    2.224772] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [    2.310150] Call Trace:
>> [    2.339374]  pcie_get_aspm_reg+0x39/0x1a0
>> [    2.387312]  pcie_aspm_init_link_state+0x2aa/0x900
>> [    2.444611]  ? pci_device_add+0x20a/0x300
>> [    2.492554]  pci_scan_slot+0xd7/0x110
>> [    2.536335]  pci_scan_child_bus+0x30/0x180
>> [    2.585313]  pci_scan_bridge+0x3f0/0x670
>> [    2.632215]  ? pci_scan_single_device+0x6d/0xd0
>> [    2.686394]  pci_scan_child_bus+0x9f/0x180
>> [    2.735375]  acpi_pci_root_create+0x182/0x1de
>> [    2.787475]  pci_acpi_scan_root+0x15f/0x1b0
>> [    2.837493]  acpi_pci_root_add+0x3bf/0x4c4
>> [    2.886474]  acpi_bus_attach+0xdf/0x18e
>> [    2.932336]  acpi_bus_attach+0x135/0x18e
>> [    2.979234]  acpi_bus_attach+0x135/0x18e
>> [    3.026135]  acpi_bus_scan+0x6e/0x8d
>> [    3.068877]  ? acpi_sleep_proc_init+0x28/0x28
>> [    3.120976]  acpi_scan_init+0xda/0x237
>> [    3.165795]  ? acpi_sleep_proc_init+0x28/0x28
>> [    3.217895]  acpi_init+0x2be/0x347
>>
>>>
>>> --
>>> Sinan Kaya
>>> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
>>> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
>> Intel Deutschland GmbH
>> Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
>> Tel: +49 89 99 8853-0, www.intel.de
>> Managing Directors: Christin Eisenschmid, Christian Lamprechter
>> Chairperson of the Supervisory Board: Nicole Lau
>> Registered Office: Munich
>> Commercial Register: Amtsgericht Muenchen HRB 186928
>>
>>
>
>
>--
>Sinan Kaya
>Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
>Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
