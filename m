Return-Path: <SRS0=4gZw=JS=cogentembedded.com=sergei.shtylyov@kernel.org>
Return-Path: <SRS0=4gZw=JS=cogentembedded.com=sergei.shtylyov@kernel.org>
Subject: Re: [PATCH] pci: fix I/O space page leak
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Rob Herring <robh@kernel.org>, Tanmay Inamdar <tinamdar@apm.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
References: <1ca6adde-a91e-84d0-c7dc-fd01bfd9edcc@cogentembedded.com>
 <20180628132259.GB90450@bhelgaas-glaptop.roam.corp.google.com>
 <20180628142615.GA9101@red-moon>
 <ac015f99-c310-3701-35ce-846393b61235@cogentembedded.com>
 <20180702103316.GA10784@red-moon>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b881add9-b428-938e-947d-b44d04c34dd6@cogentembedded.com>
Date: Mon, 2 Jul 2018 22:40:31 +0300
MIME-Version: 1.0
In-Reply-To: <20180702103316.GA10784@red-moon>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 07/02/2018 01:33 PM, Lorenzo Pieralisi wrote:

>>>>> When testing the R-Car PCIe driver on the Condor board, I noticed that iff
>>>>> I  left the PCIe PHY driver disabled, the kernel crashed  with this BUG:
>>>>>
>>>>> [    1.225819] kernel BUG at lib/ioremap.c:72!
>>>>> [    1.230007] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>>>> [    1.235496] Modules linked in:
>>>>> [    1.238561] CPU: 0 PID: 39 Comm: kworker/0:1 Not tainted 4.17.0-dirty #1092
>>>>> [    1.245526] Hardware name: Renesas Condor board based on r8a77980 (DT)
>>>>> [    1.252075] Workqueue: events deferred_probe_work_func
>>>>> [    1.257220] pstate: 80000005 (Nzcv daif -PAN -UAO)
>>>>> [    1.262024] pc : ioremap_page_range+0x370/0x3c8
>>>>> [    1.266558] lr : ioremap_page_range+0x40/0x3c8
>>>>> [    1.271002] sp : ffff000008da39e0
>>>>> [    1.274317] x29: ffff000008da39e0 x28: 00e8000000000f07
>>>>> [    1.279636] x27: ffff7dfffee00000 x26: 0140000000000000
>>>>> [    1.284954] x25: ffff7dfffef00000 x24: 00000000000fe100
>>>>> [    1.290272] x23: ffff80007b906000 x22: ffff000008ab8000
>>>>> [    1.295590] x21: ffff000008bb1d58 x20: ffff7dfffef00000
>>>>> [    1.300909] x19: ffff800009c30fb8 x18: 0000000000000001
>>>>> [    1.306226] x17: 00000000000152d0 x16: 00000000014012d0
>>>>> [    1.311544] x15: 0000000000000000 x14: 0720072007200720
>>>>> [    1.316862] x13: 0720072007200720 x12: 0720072007200720
>>>>> [    1.322180] x11: 0720072007300730 x10: 00000000000000ae
>>>>> [    1.327498] x9 : 0000000000000000 x8 : ffff7dffff000000
>>>>> [    1.332816] x7 : 0000000000000000 x6 : 0000000000000100
>>>>> [    1.338134] x5 : 0000000000000000 x4 : 000000007b906000
>>>>> [    1.343452] x3 : ffff80007c61a880 x2 : ffff7dfffeefffff
>>>>> [    1.348770] x1 : 0000000040000000 x0 : 00e80000fe100f07
>>>>> [    1.354090] Process kworker/0:1 (pid: 39, stack limit = 0x        (ptrval))
>>>>> [    1.361056] Call trace:
>>>>> [    1.363504]  ioremap_page_range+0x370/0x3c8
>>>>> [    1.367695]  pci_remap_iospace+0x7c/0xac
>>>>> [    1.371624]  pci_parse_request_of_pci_ranges+0x13c/0x190
>>>>> [    1.376945]  rcar_pcie_probe+0x4c/0xb04
>>>>> [    1.380786]  platform_drv_probe+0x50/0xbc
>>>>> [    1.384799]  driver_probe_device+0x21c/0x308
>>>>> [    1.389072]  __device_attach_driver+0x98/0xc8
>>>>> [    1.393431]  bus_for_each_drv+0x54/0x94
>>>>> [    1.397269]  __device_attach+0xc4/0x12c
>>>>> [    1.401107]  device_initial_probe+0x10/0x18
>>>>> [    1.405292]  bus_probe_device+0x90/0x98
>>>>> [    1.409130]  deferred_probe_work_func+0xb0/0x150
>>>>> [    1.413756]  process_one_work+0x12c/0x29c
>>>>> [    1.417768]  worker_thread+0x200/0x3fc
>>>>> [    1.421522]  kthread+0x108/0x134
>>>>> [    1.424755]  ret_from_fork+0x10/0x18
>>>>> [    1.428334] Code: f9004ba2 54000080 aa0003fb 17ffff48 (d4210000)
>>>>>
>>>>> It turned out that pci_remap_iospace() wasn't undone when the driver's
>>>>> probe failed, and since devm_phy_optional_get() returned -EPROBE_DEFER,
>>>>> the probe was retried,  finally causing the BUG due to trying to remap
>>>>> already remapped pages.
>>>>>
>>>>> The most feasible solution seems to introduce devm_pci_remap_iospace()
>>>>> and call it instead of pci_remap_iospace(), so that the pages get unmapped
>>>>> automagically on any probe failure.
>>>>>
>>>>> And  while fixing pci_parse_request_of_pci_ranges(), aslo fix the other
>>>>> drivers that have probably copied the bad example...
>>>>>
>>>>> Fixes: 4e64dbe226e7 ("PCI: generic: Expose pci_host_common_probe() for use by other drivers")
>>>>> Fixes: cbce7900598c ("PCI: designware: Make driver arch-agnostic")
>>>>> Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
>>>>> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
>>>>> Fixes: 68a15eb7bd0c ("PCI: v3-semi: Add V3 Semiconductor PCI host driver")
>>>>> Fixes: b7e78170efd4 ("PCI: versatile: Add DT-based ARM Versatile PB PCIe host driver")
>>>>> Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
>>>>> Fixes: 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller support")
>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>>> Cc: stable@vger.kernel.org
>>>>
>>>> Let me know if you want me to take this, Lorenzo, otherwise:
>>>> s/pci: fix/PCI: Fix/ and
>>>>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Thank you Bjorn, yes it could go in as a fix but IMO it has to be split,
>>> more so given the stable tag (and I think that each "Fixes" tag should
>>> be self-contained),
>>
>>    It cannot be self-contained because it'll depend on the initial
>> commit adding devm_pci_remap_iobase(). If you mean finding the
>> earliest broken driver and introduce the deviec managed API while
>> fixing it and then make use of that
>> API in the subsequent patches, that surely can be done.
> 
> Yes I think that's the best course of action.

   OK! :-)

>>> merging it as-is would give Greg (and us) a
>>> headache when it comes to backporting it.
>>
>>    The patch interdependency would give him headache too, and I was
>> hoping to relieve those with the monilitic patch. :-)
> 
> The problem is that if any of the fixes has to be reverted we have
> to revert the whole thing instead of just the problematic patch,
> which, given that we are sending this to stable kernels may easily
> turn out quite complicated.
> 
> So, I would add the new API along with the earliest broken driver
> and mark it for stable.
> 
> In the same thread, add all other fixes (one per patch) without the
> stable tag. When the first fix gets merged into the mainline (and
> consequently goes to stable) we can send the stable backports for the
> remainder of fixes.
> 
> How does that sound ?

   I think the -stable maintainers are actively looking at the Fixes: tags
these days, not only at stable@vger.kernel.org.  I can do thsat

>>> Honestly I think it is best to split it up and send it for v4.19 but
>>> I am happy to hear other options.
>>
>>    I disagree about 4.19. The R-Car PCIe situation is as follows:
>> given me missing to get the PHY driver merged into 4.18 (and the
>> gen3 PCIe stuff successfully merged into 4.18), the user is bound to
>> have PCIe not working (if he doesn't refer to the PHY driver in DT)
>> or encounter a kernel BUG (if he does refer to the PHY driver), thus

   s/driver/device/, of course. :-)

>> I'd like this BUG to be fixed in 4.18 time frame...
> 
> We shall try, please let me know if you are able to respin asap,
> we already have a bunch of fixes queued.

   I can probably try -- despite I'm on vacations and the football
championship is still going on. :-)

> Thanks for putting it together,
> Lorenzo

MBR, Sergei
