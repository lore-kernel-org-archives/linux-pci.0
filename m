Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2125B30D;
	Wed, 15 Jul 2026 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077512; cv=none; b=oEG5Ul6UyhWdY1Cp/h3aREOa9oD2+dtWks+Z0McoeliZnLxPzIPxf/PaZHZj/dIHdfjGfI2A+KY4nXDCsbG02maq+/Btm081MYvvBtuOk8u6iJoNV8PwqfG22FjNRkAtoexUJdZBFpNBboIYcOlYRVZ52gpLpT86E9pYqrNP0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077512; c=relaxed/simple;
	bh=XLFwXxWyxbUH+q/Qw83XEZC7FLpayI+UquvOeAFewI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TkghsnIzlkqR8WDSzeV8FZKxWxV3WjpEdKCIvyq41re+66hpbmNNuj+G69pcPzdsTbtd1g+9yt1fObSGVl2KIFdn/m/ayrDbLO3EX1OruRxxKyw1z7MfvZqTU5KI2MdhRJAa0sIvoyfRHRR3BwoOHvPgzOYA5Gbh4bZv/eUaW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO3nhRYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO3nhRYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8536D1F000E9;
	Wed, 15 Jul 2026 01:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784077506;
	bh=y0YoLBtLdW6Krp7DgOdSvsGw4eBcuKez0HI9wom36Fc=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=CO3nhRYHrFqkyCpX5DKHmYx34quspEEB2SkXMCPpgT3KbBiep+BxmXeuMugUz3Qql
	 IEKUI4zJe72POx9jxlLQoambHr6n2/7uGvkPXwY8ny2988nwFa4Igo8Dz6dxdGnLfe
	 UeBXuqw5OjZNUu04fekeXrrvCfVwiR24EXEnGxE6L1MATrR/s1/E6iBuK3pESBpd4t
	 Z/ZdObxT9qzHWpBDYHvAmbhYH6eUd96zo5RhpVuUnlcWWayfojxjflJYlpcz6ABPnO
	 aos3OEzvK/Wc5lWv2qbt+KJ5t3TQiiwEFO3b3fpnkxb+KBqwSsKtgyuEWOxKHJ+wXC
	 Md2mKTWHLOHcw==
Message-ID: <e78152a9-c6d3-47d9-8657-f5efc2fe69f7@kernel.org>
Date: Tue, 14 Jul 2026 20:05:04 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] thunderbolt: Quiesce AMD NHI during suspend
Content-Language: en-US
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
 <albapl82ioSBPbp6@acelan-Precision-5480>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <albapl82ioSBPbp6@acelan-Precision-5480>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 20:01, Chia-Lin Kao (AceLan) wrote:
> On Wed, Jul 08, 2026 at 10:34:54AM -0500, Mario Limonciello wrote:
>> ++ linux-pci
>> ++ Sanath && Basavaraj
>>
>> On 7/5/26 21:34, Chia-Lin Kao (AceLan) wrote:
>>> On some AMD USB4 systems, resuming from system suspend with a
>>> Thunderbolt dock in the picture hard-hangs the machine very early in the
>>> resume path, before the Thunderbolt driver gets a chance to rescan and
>>> re-establish the topology. It is a PCIe bus wedge: the system never
>>> reaches the point where the thunderbolt module could recover the dock,
>>> and the kernel journal does not persist past "PM: suspend entry
>>> (s2idle)".
>>>
>>> Reproduce:
>>>
>>>     1. Affected platform: an AMD USB4 host with the thunderbolt driver
>>>        bound to its NHI PCI functions. Observed on a Dell Pro 14 Plus
>>>        (PB14255, AMD Phoenix) which exposes two USB4 NHI functions
>>>        (0000:c6:00.5 and 0000:c6:00.6).
>>>
>>>     2. Put the system into s2idle (Low Power S0 Idle / Modern Standby)
>>>        with no dock attached.
>>>
>>>     3. While the system is suspended, plug in a Dell SD25TB4 Thunderbolt 4
>>>        dock (Goshen Ridge). The plug event wakes the system, and the dock's
>>>        downstream PCIe bridges are enumerated behind the AMD USB4 PCIe
>>>        tunnel during the resume.
>>>
>>>     4. The machine hard-hangs during the noirq resume phase, before the
>>>        thunderbolt driver re-establishes the topology. The Dell power
>>>        indicator flashes the "3A5W" code (3 amber + 5 white lights).
>>>
>>>     Removing the trigger makes resume reliable: unbinding the two NHI PCI
>>>     functions, or unloading the thunderbolt module, before suspend both
>>>     avoid the hang completely. The difference in those cases is the PCI
>>>     state the core restores for the driver-bound NHI on resume.
>>>
>>> EC team findings (from the platform EC log):
>>>
>>> The EC/PD/dock side is healthy across the failing cycle, which points
>>> the finger at the host resume path rather than the dock:
>>>
>>>     - Modern Standby entry and resume are seen on the EC side; the dock
>>>       plug interrupt during MS is handled and the full power sequence
>>>       recovers (SLP_S3# okay, PLTRST# received, U8-U20 sequence completed).
>>>
>>>     - The EC-to-dock DDM command exchange fully succeeds: all CMsd/CMgd
>>>       transactions return success (device type, TBT cable type, dock
>>>       module config for USB/TBT/Audio/LAN).
>>>
>>>     - PD/Type-C renegotiation is normal (power contracts up to 95W/100W);
>>>       no persistent protocol error appears in the log.
>>>
>>>     - The only suspicious symptom is host-side: the EC repeatedly logs
>>>       PmSt_Timeout_Count while waiting for the BIOS/host to consume the
>>>       wake (PWRB pressed) event. That indicates the host resume path is
>>>       late or stuck, not an EC-to-dock transport failure. The Dell "3A5W"
>>>       diagnostic LED code (3 amber + 5 white) maps in the EC code to an
>>>       SLP_S3#/PLTRST#/RUNPWROK failure indication.
>>>
>>> Root cause:
>>>
>>> With the driver bound, the PCI core restores the saved NHI config space
>>> during the noirq resume phase, including PCI_COMMAND with memory space
>>> and bus mastering enabled. This is the same phase in which the core
>>> restores the config space of the tunneled PCI bridges and whatever sits
>>> behind them (the dock). If the AMD host router is made active (memory +
>>> bus mastering) while the downstream USB4 PCIe tunnel to the dock is still
>>> being restored and is not yet ready, the host interface starts bus
>>> activity toward a not-yet-ready endpoint and the PCIe hierarchy wedges.
>>>
>>> This matches the workarounds: unbinding the NHI or unloading the module
>>> means the core does not restore an active NHI over the tunnel during
>>> noirq, and the hang disappears. Several Thunderbolt-side attempts did not
>>> help (returning early from nhi_resume_noirq(), disabling host-router wake
>>> flags, adding an unconditional delay before tunnel activation), which is
>>> why the actionable boundary is the PCI PM state of the driver-bound AMD
>>> NHI rather than a later Thunderbolt protocol step. We do not have
>>> visibility into what the host router does internally in that window; that
>>> uncertainty is the main reason for sending this as an RFC (see open
>>> questions below).
>>>
>>> What this patch does:
>>>
>>> Add a QUIRK_QUIESCE_ON_SUSPEND quirk, currently set for all AMD USB4 host
>>> routers (matched by vendor AMD + USB4 PCI class), and:
>>>
>>>     - clear PCI_COMMAND_MEMORY and PCI_COMMAND_MASTER before the PCI core
>>>       saves the NHI config space in runtime and system suspend, so the NHI
>>>       is restored inactive on resume;
>>>
>>>     - keep the NHI quiescent across nhi_resume_noirq() (return early without
>>>       touching the controller), so it stays inactive while the core
>>>       restores the tunneled bridges and the dock;
>>>
>>>     - once the whole system has resumed, re-enable memory space and bus
>>>       mastering and bring the domain back up from the PM complete callback
>>>       via tb_domain_resume_noirq(), and from nhi_runtime_resume() for the
>>>       runtime PM path.
>>>
>>> The result is that Thunderbolt/USB4 stays functional after resume instead
>>> of the machine hanging or the tunnels staying down until the module is
>>> reloaded.
>>>
>>> Test results:
>>>
>>> Tested on the Dell Pro 14 Plus (PB14255, AMD Phoenix, two USB4 host
>>> routers) with the Dell SD25TB4 dock. Without the patch, the sequence
>>> above hard-hangs during resume. With the patch, repeated suspend/resume
>>> cycles with the dock connected complete cleanly with no hang. After
>>> resume the NHI PCI_COMMAND reads back with MEMORY|MASTER set again, and
>>> the dock's downstream USB devices re-enumerate, confirming the USB tunnel
>>> is restored and the domain is functional.
>>>
>>> Caveats observed while the NHI is quiescent across noirq: config space
>>> reads to the host router time out and TMU configuration restore fails
>>> during that window; the controller and domain are fully brought back in
>>> nhi_complete(). The DP tunnel restore path was not exercised in this
>>> test, as no external display was driven through the dock during the
>>> tested cycle.
>>>
>>> Open questions for RFC discussion:
>>>
>>>     1. Root cause: what does the AMD host router actually do when it is
>>>        restored with memory + bus mastering enabled during noirq while the
>>>        downstream tunnel is not ready? Is this an expected ordering
>>>        constraint, a firmware behavior, or a hardware erratum?
>>>
>>>     2. Scope: the quirk currently matches all AMD USB4 host routers by
>>>        class. Which parts are actually affected? Should this be narrowed
>>>        (e.g. by DMI or specific device IDs) instead of applied to all AMD
>>>        USB4?
>>>
>>>     3. Mechanism: is clearing both PCI_COMMAND_MEMORY and PCI_COMMAND_MASTER
>>>        the right lever, or would clearing bus mastering alone suffice and be
>>>        less invasive? Is poking PCI_COMMAND directly acceptable in the NHI
>>>        driver, or should this move into a PCI backend op / PCI quirk?
>>>
>>> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>>
>> I have no idea why I didn't receive this patch in my mailbox - I'm obviously
>> CC'ed.  But I checked my spam and it's not there either.
>>
>> But anyway, I am wondering if the real issue here is that we're accessing
>> the hardware before it's ready.  If you can readily reproduce the issue, can
>> you try this series to see if it helps?
>>
>> https://lore.kernel.org/linux-pci/20260708152650.536604-1-mario.limonciello@amd.com/
> No, this patch doesn't work.
> I applied this patch on top of the latest mainline kernel
> 58717b2a1365 ("Merge tag 'sound-7.2-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound")
> and the power indicator shows 3 amber and 5 white lights after
> plugging in the tbt dock during suspend.
> 

Thanks for checking.  That code ended up not helping the original issue 
it was for, a different solution for that issue is being provided.

But I'm wondering, is this issue you're working on something to do with 
pm_async?  Could you turn that off and see if it improves anything?

Any chance you can get UART output from the system using a debug board 
over suspend/resume in case there is a panic happening that doesn't 
flush to NVME?

>>
>>> ---
>>>    drivers/thunderbolt/nhi.c | 78 +++++++++++++++++++++++++++++++++++++--
>>>    drivers/thunderbolt/nhi.h |  5 ++-
>>>    drivers/thunderbolt/pci.c |  8 ++++
>>>    3 files changed, 85 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>>> index 698fb124d529..787185c745ae 100644
>>> --- a/drivers/thunderbolt/nhi.c
>>> +++ b/drivers/thunderbolt/nhi.c
>>> @@ -16,6 +16,7 @@
>>>    #include <linux/interrupt.h>
>>>    #include <linux/iommu.h>
>>>    #include <linux/module.h>
>>> +#include <linux/pci.h>
>>>    #include <linux/delay.h>
>>>    #include <linux/property.h>
>>>    #include <linux/string_choices.h>
>>> @@ -40,6 +41,31 @@ static bool host_reset = true;
>>>    module_param(host_reset, bool, 0444);
>>>    MODULE_PARM_DESC(host_reset, "reset USB4 host router (default: true)");
>>> +static bool nhi_quirk_quiesce_on_suspend(const struct tb_nhi *nhi)
>>> +{
>>> +	return nhi->quirks & QUIRK_QUIESCE_ON_SUSPEND;
>>> +}
>>> +
>>> +static void nhi_disable_pci_mem_master(struct tb_nhi *nhi)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(nhi->dev);
>>> +	u16 cmd;
>>> +
>>> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>>> +	cmd &= ~(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
>>> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
>>> +}
>>> +
>>> +static void nhi_enable_pci_mem_master(struct tb_nhi *nhi)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(nhi->dev);
>>> +	u16 cmd;
>>> +
>>> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>>> +	cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
>>> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
>>> +}
>>> +
>>>    static int ring_interrupt_index(const struct tb_ring *ring)
>>>    {
>>>    	int bit = ring->hop;
>>> @@ -988,6 +1014,9 @@ static int __nhi_suspend_noirq(struct device *dev, bool wakeup)
>>>    			return ret;
>>>    	}
>>> +	if (nhi_quirk_quiesce_on_suspend(nhi))
>>> +		nhi_disable_pci_mem_master(nhi);
>>> +
>>>    	return 0;
>>>    }
>>> @@ -1038,6 +1067,18 @@ static int nhi_resume_noirq(struct device *dev)
>>>    	struct tb_nhi *nhi = tb->nhi;
>>>    	int ret;
>>> +	/*
>>> +	 * If the NHI was quiesced on suspend keep it quiescent (bus
>>> +	 * mastering and memory access disabled) across the noirq phase.
>>> +	 * The PCI core restores the config space of the tunneled PCI
>>> +	 * bridges and anything behind them (e.g. a dock) here; letting the
>>> +	 * AMD host router become active now can wedge the PCIe bus before
>>> +	 * the dock side is ready. The controller and domain are brought
>>> +	 * back up in nhi_complete() once the whole system has resumed.
>>> +	 */
>>> +	if (nhi_quirk_quiesce_on_suspend(nhi))
>>> +		return 0;
>>> +
>>>    	/*
>>>    	 * Check that the device is still there. It may be that the user
>>>    	 * unplugged last device which causes the host controller to go
>>> @@ -1064,16 +1105,33 @@ static int nhi_suspend(struct device *dev)
>>>    static void nhi_complete(struct device *dev)
>>>    {
>>>    	struct tb *tb = dev_get_drvdata(dev);
>>> +	struct tb_nhi *nhi = tb->nhi;
>>>    	/*
>>>    	 * If we were runtime suspended when system suspend started,
>>>    	 * schedule runtime resume now. It should bring the domain back
>>> -	 * to functional state.
>>> +	 * to functional state (and undo the quiesce, if any, via
>>> +	 * nhi_runtime_resume()).
>>>    	 */
>>> -	if (pm_runtime_suspended(dev))
>>> +	if (pm_runtime_suspended(dev)) {
>>>    		pm_runtime_resume(dev);
>>> -	else
>>> -		tb_domain_complete(tb);
>>> +		return;
>>> +	}
>>> +
>>> +	/*
>>> +	 * A quiesced NHI (see __nhi_suspend_noirq()) was intentionally
>>> +	 * left with bus mastering and memory access disabled and its
>>> +	 * domain was not resumed in nhi_resume_noirq(). Now that the whole
>>> +	 * system has resumed and the PCI core has finished restoring the
>>> +	 * tunneled bridges, re-enable the controller and bring the domain
>>> +	 * back up so Thunderbolt/USB4 keeps working after resume.
>>> +	 */
>>> +	if (nhi_quirk_quiesce_on_suspend(nhi)) {
>>> +		nhi_enable_pci_mem_master(nhi);
>>> +		tb_domain_resume_noirq(tb);
>>> +	}
>>> +
>>> +	tb_domain_complete(tb);
>>>    }
>>>    static int nhi_runtime_suspend(struct device *dev)
>>> @@ -1091,6 +1149,10 @@ static int nhi_runtime_suspend(struct device *dev)
>>>    		if (ret)
>>>    			return ret;
>>>    	}
>>> +
>>> +	if (nhi_quirk_quiesce_on_suspend(nhi))
>>> +		nhi_disable_pci_mem_master(nhi);
>>> +
>>>    	return 0;
>>>    }
>>> @@ -1100,6 +1162,14 @@ static int nhi_runtime_resume(struct device *dev)
>>>    	struct tb_nhi *nhi = tb->nhi;
>>>    	int ret;
>>> +	/*
>>> +	 * The NHI is quiesced (bus mastering and memory access disabled)
>>> +	 * across runtime suspend as well; re-enable it before resuming the
>>> +	 * domain.
>>> +	 */
>>> +	if (nhi_quirk_quiesce_on_suspend(nhi))
>>> +		nhi_enable_pci_mem_master(nhi);
>>> +
>>>    	if (nhi->ops->runtime_resume) {
>>>    		ret = nhi->ops->runtime_resume(nhi);
>>>    		if (ret)
>>> diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
>>> index d488eadadfce..c8b973150434 100644
>>> --- a/drivers/thunderbolt/nhi.h
>>> +++ b/drivers/thunderbolt/nhi.h
>>> @@ -119,8 +119,9 @@ struct tb_nhi_ops {
>>>    #define PCI_CLASS_SERIAL_USB_USB4			0x0c0340
>>>    /* Host interface quirks */
>>> -#define QUIRK_AUTO_CLEAR_INT	BIT(0)
>>> -#define QUIRK_E2E		BIT(1)
>>> +#define QUIRK_AUTO_CLEAR_INT		BIT(0)
>>> +#define QUIRK_E2E			BIT(1)
>>> +#define QUIRK_QUIESCE_ON_SUSPEND	BIT(2)
>>>    /*
>>>     * Minimal number of vectors when we use MSI-X. Two for control channel
>>> diff --git a/drivers/thunderbolt/pci.c b/drivers/thunderbolt/pci.c
>>> index dbb6badda867..4cf8107f1ce8 100644
>>> --- a/drivers/thunderbolt/pci.c
>>> +++ b/drivers/thunderbolt/pci.c
>>> @@ -43,6 +43,14 @@ static void nhi_pci_check_quirks(struct tb_nhi_pci *nhi_pci)
>>>    	struct tb_nhi *nhi = &nhi_pci->nhi;
>>>    	struct pci_dev *pdev = to_pci_dev(nhi->dev);
>>> +	/*
>>> +	 * AMD USB4 host routers may otherwise become active too early during
>>> +	 * resume after the PCI core restores the saved COMMAND register.
>>> +	 */
>>> +	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
>>> +	    pdev->class == PCI_CLASS_SERIAL_USB_USB4)
>>> +		nhi->quirks |= QUIRK_QUIESCE_ON_SUSPEND;
>>> +
>>>    	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
>>>    		/*
>>>    		 * Intel hardware supports auto clear of the interrupt
>>

