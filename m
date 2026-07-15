Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA72373BEC;
	Wed, 15 Jul 2026 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154517; cv=none; b=XyZUB0aXehpbotbD5U0Ux/x8vzgeLUCcSTX7lCsz1FgXIL9+D3YqOX9mNwA8J53f5bJ/Y6CTvdP1N397cqVLNAJt8aG7L9qNi7ptjeUl5F50XzXiFlMIkmvHu+s7zVyA54sUH+qEcxwEFTNqoyjMXlJXjhhVDXv2J+lB56zOgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154517; c=relaxed/simple;
	bh=1I6u4o6Jjf5fzfvUUVOjnnD57fn8+OTvo3d5UyJLhJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bj3bfOvSLZoERnSdbxvRiJByjlLaO9fW1ic8Yr/4sENaP7jL8kBI5Vaj67y4w3ADNvi3PKmWmj5FV24XLmaOCRYfZq3122uDwJzZKPk/qex7BH6pPjwzqAnWJ8zOkvFtsvFYOQN6ikVe5VI+L64VSt/zdzGGIGCIuQEIVAe47nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN2NwMJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN2NwMJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB771F000E9;
	Wed, 15 Jul 2026 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784154515;
	bh=KnhetXf9V1THrKT+6gaAOSwWUV4QEM/g+lR1mkGDwCI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=NN2NwMJNhGZJwoPdoHcbBP307DNtnfjKLDo1xT23LKYCguLvXy2Nq/jfVljJyVqfp
	 OJdGsrIvSFt2TxMz8lYQ3jOH/8lFb8TOnMT2ldZU+7Z/pub31p8MZmUd3cifAP7x5L
	 KDGsTT/UevMOwphaxLUU8r7BKtwwZcyZQuGGfLH4LFJwvbApYvH6uI5PRcRa9rGXgj
	 QDcERc12nwufHuhQv6reoWez+Rdqp8N/i/etGiVF1IuxQYGRsrzA+20u17udb2ctbo
	 7KqOCraeb1H6LP6Cnp0qsXfuJpa6n2oP36sLo0dC0s2o89HVwTEbnUMLUW1Wo/Laku
	 rL8VX8nok5DiQ==
Message-ID: <780d621d-248c-4a6e-9f00-37bf60bd916c@kernel.org>
Date: Wed, 15 Jul 2026 17:28:31 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] thunderbolt: Quiesce AMD NHI during suspend
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Yo-Jung Leo Lin <Leo.Lin@amd.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 "S, Sanath" <sanath.s@amd.com>,
 "Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20260706023422.3647320-1-acelan.kao@canonical.com>
 <2ff2d9b9-12fb-4908-8738-2498b2927571@kernel.org>
 <5abee20c-aea5-4209-a6d5-2929cd325a9f@kernel.org>
 <alcW0iPBPF9tp5cv@acelan-Precision-5480>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <alcW0iPBPF9tp5cv@acelan-Precision-5480>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/15/26 12:19 AM, Chia-Lin Kao (AceLan) wrote:
> On Wed, Jul 08, 2026 at 01:37:55PM -0500, Mario Limonciello wrote:
>> Some comments about your changes too.
>>
>> On 7/8/26 10:34, Mario Limonciello wrote:
>>> ++ linux-pci
>>> ++ Sanath && Basavaraj
>>>
>>> On 7/5/26 21:34, Chia-Lin Kao (AceLan) wrote:
>>>> On some AMD USB4 systems, resuming from system suspend with a
>>>> Thunderbolt dock in the picture hard-hangs the machine very early in the
>>>> resume path, before the Thunderbolt driver gets a chance to rescan and
>>>> re-establish the topology. It is a PCIe bus wedge: the system never
>>>> reaches the point where the thunderbolt module could recover the dock,
>>>> and the kernel journal does not persist past "PM: suspend entry
>>>> (s2idle)".
>>>>
>>>> Reproduce:
>>>>
>>>>     1. Affected platform: an AMD USB4 host with the thunderbolt driver
>>>>        bound to its NHI PCI functions. Observed on a Dell Pro 14 Plus
>>>>        (PB14255, AMD Phoenix) which exposes two USB4 NHI functions
>>>>        (0000:c6:00.5 and 0000:c6:00.6).
>>>>
>>>>     2. Put the system into s2idle (Low Power S0 Idle / Modern Standby)
>>>>        with no dock attached.
>>>>
>>>>     3. While the system is suspended, plug in a Dell SD25TB4 Thunderbolt 4
>>>>        dock (Goshen Ridge). The plug event wakes the system, and the
>>>> dock's
>>>>        downstream PCIe bridges are enumerated behind the AMD USB4 PCIe
>>>>        tunnel during the resume.
>>>>
>>>>     4. The machine hard-hangs during the noirq resume phase, before the
>>>>        thunderbolt driver re-establishes the topology. The Dell power
>>>>        indicator flashes the "3A5W" code (3 amber + 5 white lights).
>>>>
>>>>     Removing the trigger makes resume reliable: unbinding the two NHI PCI
>>>>     functions, or unloading the thunderbolt module, before suspend both
>>>>     avoid the hang completely. The difference in those cases is the PCI
>>>>     state the core restores for the driver-bound NHI on resume.
>>>>
>>>> EC team findings (from the platform EC log):
>>>>
>>>> The EC/PD/dock side is healthy across the failing cycle, which points
>>>> the finger at the host resume path rather than the dock:
>>>>
>>>>     - Modern Standby entry and resume are seen on the EC side; the dock
>>>>       plug interrupt during MS is handled and the full power sequence
>>>>       recovers (SLP_S3# okay, PLTRST# received, U8-U20 sequence
>>>> completed).
>>>>
>>>>     - The EC-to-dock DDM command exchange fully succeeds: all CMsd/CMgd
>>>>       transactions return success (device type, TBT cable type, dock
>>>>       module config for USB/TBT/Audio/LAN).
>>>>
>>>>     - PD/Type-C renegotiation is normal (power contracts up to 95W/100W);
>>>>       no persistent protocol error appears in the log.
>>>>
>>>>     - The only suspicious symptom is host-side: the EC repeatedly logs
>>>>       PmSt_Timeout_Count while waiting for the BIOS/host to consume the
>>>>       wake (PWRB pressed) event. That indicates the host resume path is
>>>>       late or stuck, not an EC-to-dock transport failure. The Dell "3A5W"
>>>>       diagnostic LED code (3 amber + 5 white) maps in the EC code to an
>>>>       SLP_S3#/PLTRST#/RUNPWROK failure indication.
>>>>
>>>> Root cause:
>>>>
>>>> With the driver bound, the PCI core restores the saved NHI config space
>>>> during the noirq resume phase, including PCI_COMMAND with memory space
>>>> and bus mastering enabled. This is the same phase in which the core
>>>> restores the config space of the tunneled PCI bridges and whatever sits
>>>> behind them (the dock). If the AMD host router is made active (memory +
>>>> bus mastering) while the downstream USB4 PCIe tunnel to the dock is still
>>>> being restored and is not yet ready, the host interface starts bus
>>>> activity toward a not-yet-ready endpoint and the PCIe hierarchy wedges.
>>>>
>>>> This matches the workarounds: unbinding the NHI or unloading the module
>>>> means the core does not restore an active NHI over the tunnel during
>>>> noirq, and the hang disappears. Several Thunderbolt-side attempts did not
>>>> help (returning early from nhi_resume_noirq(), disabling host-router wake
>>>> flags, adding an unconditional delay before tunnel activation), which is
>>>> why the actionable boundary is the PCI PM state of the driver-bound AMD
>>>> NHI rather than a later Thunderbolt protocol step. We do not have
>>>> visibility into what the host router does internally in that window; that
>>>> uncertainty is the main reason for sending this as an RFC (see open
>>>> questions below).
>>>>
>>>> What this patch does:
>>>>
>>>> Add a QUIRK_QUIESCE_ON_SUSPEND quirk, currently set for all AMD USB4 host
>>>> routers (matched by vendor AMD + USB4 PCI class), and:
>>>>
>>>>     - clear PCI_COMMAND_MEMORY and PCI_COMMAND_MASTER before the PCI core
>>>>       saves the NHI config space in runtime and system suspend, so the NHI
>>>>       is restored inactive on resume;
>>>>
>>>>     - keep the NHI quiescent across nhi_resume_noirq() (return early
>>>> without
>>>>       touching the controller), so it stays inactive while the core
>>>>       restores the tunneled bridges and the dock;
>>>>
>>>>     - once the whole system has resumed, re-enable memory space and bus
>>>>       mastering and bring the domain back up from the PM complete callback
>>>>       via tb_domain_resume_noirq(), and from nhi_runtime_resume() for the
>>>>       runtime PM path.
>>>>
>>>> The result is that Thunderbolt/USB4 stays functional after resume instead
>>>> of the machine hanging or the tunnels staying down until the module is
>>>> reloaded.
>>>>
>>>> Test results:
>>>>
>>>> Tested on the Dell Pro 14 Plus (PB14255, AMD Phoenix, two USB4 host
>>>> routers) with the Dell SD25TB4 dock. Without the patch, the sequence
>>>> above hard-hangs during resume. With the patch, repeated suspend/resume
>>>> cycles with the dock connected complete cleanly with no hang. After
>>>> resume the NHI PCI_COMMAND reads back with MEMORY|MASTER set again, and
>>>> the dock's downstream USB devices re-enumerate, confirming the USB tunnel
>>>> is restored and the domain is functional.
>>>>
>>>> Caveats observed while the NHI is quiescent across noirq: config space
>>>> reads to the host router time out and TMU configuration restore fails
>>>> during that window; the controller and domain are fully brought back in
>>>> nhi_complete(). The DP tunnel restore path was not exercised in this
>>>> test, as no external display was driven through the dock during the
>>>> tested cycle.
>>>>
>>>> Open questions for RFC discussion:
>>>>
>>>>     1. Root cause: what does the AMD host router actually do when it is
>>>>        restored with memory + bus mastering enabled during noirq while the
>>>>        downstream tunnel is not ready? Is this an expected ordering
>>>>        constraint, a firmware behavior, or a hardware erratum?
>>>>
>>>>     2. Scope: the quirk currently matches all AMD USB4 host routers by
>>>>        class. Which parts are actually affected? Should this be narrowed
>>>>        (e.g. by DMI or specific device IDs) instead of applied to all AMD
>>>>        USB4?
>>>>
>>>>     3. Mechanism: is clearing both PCI_COMMAND_MEMORY and
>>>> PCI_COMMAND_MASTER
>>>>        the right lever, or would clearing bus mastering alone suffice
>>>> and be
>>>>        less invasive? Is poking PCI_COMMAND directly acceptable in the NHI
>>>>        driver, or should this move into a PCI backend op / PCI quirk?
>>>>
>>>> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>>>
>>> I have no idea why I didn't receive this patch in my mailbox - I'm
>>> obviously CC'ed.  But I checked my spam and it's not there either.
>>>
>>> But anyway, I am wondering if the real issue here is that we're
>>> accessing the hardware before it's ready.  If you can readily reproduce
>>> the issue, can you try this series to see if it helps?
>>>
>>> https://lore.kernel.org/linux-pci/20260708152650.536604-1-
>>> mario.limonciello@amd.com/
>>>
>>>> ---
>>>>    drivers/thunderbolt/nhi.c | 78 +++++++++++++++++++++++++++++++++++++--
>>>>    drivers/thunderbolt/nhi.h |  5 ++-
>>>>    drivers/thunderbolt/pci.c |  8 ++++
>>>>    3 files changed, 85 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>>>> index 698fb124d529..787185c745ae 100644
>>>> --- a/drivers/thunderbolt/nhi.c
>>>> +++ b/drivers/thunderbolt/nhi.c
>>>> @@ -16,6 +16,7 @@
>>>>    #include <linux/interrupt.h>
>>>>    #include <linux/iommu.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/pci.h>
>>>>    #include <linux/delay.h>
>>>>    #include <linux/property.h>
>>>>    #include <linux/string_choices.h>
>>>> @@ -40,6 +41,31 @@ static bool host_reset = true;
>>>>    module_param(host_reset, bool, 0444);
>>>>    MODULE_PARM_DESC(host_reset, "reset USB4 host router (default: true)");
>>>> +static bool nhi_quirk_quiesce_on_suspend(const struct tb_nhi *nhi)
>>>> +{
>>>> +    return nhi->quirks & QUIRK_QUIESCE_ON_SUSPEND;
>>>> +}
>>>> +
>>>> +static void nhi_disable_pci_mem_master(struct tb_nhi *nhi)
>>>> +{
>>>> +    struct pci_dev *pdev = to_pci_dev(nhi->dev);
>>>> +    u16 cmd;
>>>> +
>>>> +    pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>>>> +    cmd &= ~(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
>>>> +    pci_write_config_word(pdev, PCI_COMMAND, cmd);
>>>> +}
>>>> +
>>>> +static void nhi_enable_pci_mem_master(struct tb_nhi *nhi)
>>>> +{
>>>> +    struct pci_dev *pdev = to_pci_dev(nhi->dev);
>>>> +    u16 cmd;
>>>> +
>>>> +    pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>>>> +    cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
>>>> +    pci_write_config_word(pdev, PCI_COMMAND, cmd);
>>>> +}
>>>> +
>>
>> Is this basically an open coded version of pci_set_master() and
>> pci_clear_master()?
> Yes
> 
>>
>> Or is the PCI_COMMAND_MEMORY actually important for this issue?
> Did another try without PCI_COMMAND_MEMORY and it also works. So, this
> flag is not needed.
> 
>>
>>>>    static int ring_interrupt_index(const struct tb_ring *ring)
>>>>    {
>>>>        int bit = ring->hop;
>>>> @@ -988,6 +1014,9 @@ static int __nhi_suspend_noirq(struct device
>>>> *dev, bool wakeup)
>>>>                return ret;
>>>>        }
>>>> +    if (nhi_quirk_quiesce_on_suspend(nhi))
>>>> +        nhi_disable_pci_mem_master(nhi);
>>>> +
>>
>> Isn't this going to break wakeup interrupts?
> No, plugging in a dock and the system wakes up automatically.
> 

Oh; Dell has a special way to handle this from EC communication with 
Dell docks that is separate from USB4 wake on connect settings.  So even 
without a driver loaded the Dell dock should be able to wake the Dell 
system.

But I expect it would break non-Dell systems USB4 wake on connect settings.
