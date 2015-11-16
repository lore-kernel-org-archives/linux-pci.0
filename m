Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51901 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbbKPSbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Nov 2015 13:31:33 -0500
Message-ID: <564A2101.90600@arm.com>
Date: Mon, 16 Nov 2015 18:31:29 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>
CC: Thierry Reding <treding@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>	<PS1PR06MB11804ED428472FC1FD776F6EF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>	<20151109161115.GA13870@ulmo.nvidia.com>	<PS1PR06MB1180111D6423287273B64B0FF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>	<20151110155232.GA25368@ulmo.nvidia.com>	<20151111163802.3a96080c@arm.com>	<PS1PR06MB11806B2B906CABB553B94442F5120@PS1PR06MB1180.apcprd06.prod.outlook.com> <20151112203100.2e91da2a@arm.com> <PS1PR06MB11800B547C8957B226077B83F5110@PS1PR06MB1180.apcprd06.prod.outlook.com>
In-Reply-To: <PS1PR06MB11800B547C8957B226077B83F5110@PS1PR06MB1180.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/11/15 09:36, Phil Edworthy wrote:
> Hi Marc,
> 
> On 12 November 2015 20:31, Marc Zyngier wrote:
>> Phil Edworthy <phil.edworthy@renesas.com> wrote:
>>> On 11 November 2015 16:38, Marc Zyngier wrote:
>>>> On Tue, 10 Nov 2015 16:52:33 +0100
>>>> Thierry Reding <treding@nvidia.com> wrote:
>>>>
>>>>> On Mon, Nov 09, 2015 at 06:01:49PM +0000, Phil Edworthy wrote:
>>>>>> Hi Thierry,
>>>>>>
>>>>>> On 09 November 2015 17:24, Phil wrote:
>>>>>>> On 09 November 2015 16:11, Thierry wrote:
>>>>>>>> On Mon, Nov 09, 2015 at 03:20:24PM +0000, Phil Edworthy wrote:
>>>>>>>>> cc'ing others (Tegra, Altera, Designware) who may have the same
>> bug
>>>>>>>>>
>>>>>>>>> On 03 November 2015 09:28, Phil Edworthy wrote:
>>>>>>>>>> The OF node passed to irq_domain_add_linear() should be a
>>>>>>>>>> pointer to interrupt controller's device tree node, or NULL,
>>>>>>>>>> but not the PCI controller's node.
>>>>>>>>>>
>>>>>>>>>> This fixes an oops in msi_domain_alloc_irqs() when it tries
>>>>>>>>>> to call msi_check().
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/pci/host/pcie-rcar.c | 2 +-
>>>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-
>> rcar.c
>>>>>>>>>> index 2377bf0..c6fa562 100644
>>>>>>>>>> --- a/drivers/pci/host/pcie-rcar.c
>>>>>>>>>> +++ b/drivers/pci/host/pcie-rcar.c
>>>>>>>>>> @@ -709,7 +709,7 @@ static int rcar_pcie_enable_msi(struct
>> rcar_pcie
>>>>>>> *pcie)
>>>>>>>>>>  	msi->chip.setup_irq = rcar_msi_setup_irq;
>>>>>>>>>>  	msi->chip.teardown_irq = rcar_msi_teardown_irq;
>>>>>>>>>>
>>>>>>>>>> -	msi->domain = irq_domain_add_linear(pcie->dev->of_node,
>>>>>>>>>> INT_PCI_MSI_NR,
>>>>>>>>>> +	msi->domain = irq_domain_add_linear(NULL,
>> INT_PCI_MSI_NR,
>>>>>>>>>>  					    &msi_domain_ops, &msi-
>>>>> chip);
>>>>>>>>>>  	if (!msi->domain) {
>>>>>>>>>>  		dev_err(&pdev->dev, "failed to create IRQ domain\n");
>>>>>>>>
>>>>>>>> On Tegra the PCI controller is in fact the interrupt controller for
>>>>>>>> MSIs. And looking at the code here it seems like the same would apply
>> to
>>>>>>>> RCAR.
>>>>>>> Yes you are correct here.
>>>>>>>
>>>>>>>> I'm also slightly confused as to why this would cause ->msi_check() to
>>>>>>>> fail. The default implementation (msi_domain_ops_check()) doesn't
>> do
>>>>>>>> anything.
>>>>>>>>
>>>>>>>> Also, how is passing in NULL instead of a valid struct device_node *
>>>>>>>> going to prevent an oops? Perhaps this is one of those reference
>> count
>>>>>>>> imbalance bugs that have recently been showing up?
>>>>>>> On arm64 (previously I didn't realise this just affects arm64, not arm),
>>>>>>> the changes in commit f075915ac0b11 ("PCI/MSI: Drop domain field
>> from
>>>>>>> msi_controller") and d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain
>> use
>>>>>>> struct device::msi_domain") return an uninitialized msi domain that
>> leads
>>>>>>> to the oops. It appears that these changes assume that msi interrupt
>>>>>>> controller is separate from the PCI controller.
>>>>>> More accurately, when CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled,
>>>>>> pci_msi_get_domain() calls dev_get_msi_domain() and at this point
>>>>>> dev->msi_domain is uninitialized.
>>>>>
>>>>> Marc, any idea what's going on here?
>>>>
>>>> Thanks for putting me in the loop.
>>>>
>>>> No precise idea yet, but the proposed fix definitely looks like the
>>>> wrong one. Actually, not passing a node identifier to any domain
>>>> constructor is pretty much always a mistake when using DT.
>>>>
>>>> Can someone post a stack trace for this issue so that I can have a
>>>> look? I'm currently traveling, so expect a slightly delayed reply...
>>>
>>> Unfortunately, not all the code for this arm64 board is upstream
>>> yet, this code base is off 4.3-rc7.
>>
>> Oh, this is arm64? Well, you're not supposed to use the old
>> msi_controller stuff on arm64 - I really want all arm64 controllers to
>> be converted to generic MSI domains. Please have a look at the xgene
>> code, for example.
> Oh right, I wasn't aware of that. I had hoped that drivers weren't so
> arch specific...

They are not. Generic MSI domains are supported on all other
architectures that select this option (arm, x86).

>> But irrespective of that, I share Thierry's skepticism:
>>
>>> systemd-udevd[1315]: undefined instruction: pc=ffffffc03106d41c
>>> Code: ffffffc0 311f9740 ffffffc0 3106d138 (ffffffc0)
>>> Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
>>> Modules linked in: e1000e(+)
>>> CPU: 0 PID: 1315 Comm: systemd-udevd Not tainted 4.3.0-rc7+ #4
>>> Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
>>> task: ffffffc0307af080 ti: ffffffc030ecc000 task.ti: ffffffc030ecc000
>>> PC is at 0xffffffc03106d41c
>>
>> You are clearly jumping to nowhereland, and I doubt this is related to
>> the domain of_node being set. Are you overriding arch_setup_msi_irq one
>> way or another?
> No, I'm not overriding arch_setup_msi_irq at all.
> 
> Since the stack trace doesn't help that much I added some tracing:
> pci_msi_setup_msi_irqs()
>   calls pci_msi_get_domain()
>     calls dev_get_msi_domain(), gets a non-NULL domain.
> pci_msi_setup_msi_irqs()
>   calls pci_msi_domain_alloc_irqs()
>     calls msi_domain_alloc_irqs()
> msi_domain_alloc_irqs:273: ops=ffffffc03193a810
> msi_domain_alloc_irqs:274: ops->msi_check=ffffffc031161418
> systemd-udevd[1311]: undefined instruction: pc=ffffffc03116141c
> That looks to me as though msi_check is off pointing to the weeds.

So the next step is to find out who initializes msi_check. Assuming
someone does...

> By passing a NULL domain into irq_domain_add_linear() you get:
> pci_msi_setup_msi_irqs()
>   calls pci_msi_get_domain()
>     calls dev_get_msi_domain(), gets a NULL domain.
>     calls arch_setup_msi_irq()
> All ok then.

Yes, because you're sidestepping the issue. Any chance you could dig a
bit deeper? I'd really like to nail this one down (before we convert
your PCI driver to the right API... ;-).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
