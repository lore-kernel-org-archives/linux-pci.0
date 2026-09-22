Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D64AB1D2
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063438; cv=none; b=Mr9XoR22oSyt12oqiIZkOdyashD5fUnUcg5lj11oNnq9QZF6WiNYgkn0W1XYDVQheUIZE7hRD8QPFZhsrI3hTAQw6/Z5fil5TUOA1zQzM8XXU0ySbUChOsJY/Hif6psCTOk9JQ9Jo8JRRlodcGzLW2kkcIHLmBUiPqsCeLQFmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063438; c=relaxed/simple;
	bh=2G+8ClGgxJZ5VfoKlqNqGgItPRWdyTQo0DsxftmvuLU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y+Vy81rUzz+4fx9XgzzSvs1lQ7C/LbFbFHjfq++vmOwBj7i05CAzF3nEHdCEsZo6AZEWJlY/9V5W7M6plqu2epVoccet22UIuxtz0lwYyXGPMiWmH+4uuYOZ+DwAyNLXNSjXjYb9ylX6VcmFlpQ4INYe1vj3uV7KZzCcSjULpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HPT/Z2jS; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HPT/Z2jS"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so20464185e9.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1790063426; x=1790668226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rp4zfkTur43gBpVU56VQnfOytch6U2a6G3T7yU9uyVA=;
        b=HPT/Z2jSOR7ajHDOBu3gHqoiZ4EHlG/LLAf08KhW3UJYX2CvzFS7nVBZHOl2dhmPV5
         rTZe+RlS3HUxAU138y4/OMBqfrCF3OL+sDi0SwMesZCLmxjbfz5uxAUa+psmFYSdnfCC
         fGSl1ZhuAIGrHCOubd7Lu5eOXdYck9ttpGOIriXx2Vr8PwRJ5vOUuhfXRPaod4kXhSEz
         evrLVUrJvYyMTLRTeCQQge/xPheh2rQePBNc3Tv4Xwq4FxWPa+TtxxpzWxJTuy7Wm2m/
         vHyk69UH/yQeLORLdelFY2wePOXX05uRU7j0MmB5tcUciqv5PiwoBPPlpreRL0pPxCfD
         R0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790063426; x=1790668226;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rp4zfkTur43gBpVU56VQnfOytch6U2a6G3T7yU9uyVA=;
        b=fvWstEowX5wEetY1IeHUiOHp6wmAvnNGzR2jVjIf2KaZLM3dAmDPSD0aC2nmiwMdRT
         e0CydrCNncQ2sCtO/7uELphGqjiWrZ1/0ynvlTLLTIzonNgCMPO1YDBr5zfS0vH1XMsq
         AVx3CIKl40RUdoGAOLxrWY2bRVQ3in1ZcaRvWNCfcfdc9UVSvN8XmEX7x0YT75yZ8OQu
         TqcBZr6Gijf+RmR2m7m+MF4KXqk3iLMi/kAlBE5vW6UiVnFS5Py0fX1/6Uh4R1q79MRC
         0tOhF09v0/nDF7xUTLUPcMrM2BvcVq1TKVILZcFZd/NZfaRUrQJvWfB3g4d4ozJGYWfn
         QHmw==
X-Forwarded-Encrypted: i=1; AKwUvBzdwIrqhODx9Hdix8dVhfMXsLPLE2XTNckgJb3kj8v8HMcO+oRmq+B3dme4wd3+lhz0sioGQG79Kzo=@vger.kernel.org
X-Gm-Message-State: AFuF++k/5C+Fix56QSZgLDY4BuEVcmXSG7JgyLtVBHusz+TtZy9cuovD
	hzk9GFdrAdV6gA4jqlJk0hCZbYOYm+DoPQd9CbJ6VSGSQ0sIWLsy7VoIeQLGu7j9A8A=
X-Gm-Gg: AYBFou3S/Woep+gFZX5PWSBwU1Vomi7WodbeNhWlN10E67v8VLbuwKfiN7wterMK5Qb
	0do4tjj7hOXWhLlP/vMZc3QCZQjvw7XujgmnzbS0eOjBmE3i8b4BelFmUfLwW1K1SRxH4+8OBUR
	rVIybHpJQQYc7Ty9UxG9F19v1StSCK5zgw74pyxQ4jbZ+9+bn1BuoHbzLo6IBEv1BnwlJQRxJfX
	ULUZkatTFY+OsFL/Oqm7bQ7NmEyl3yELiEmWXu/82lcMA3Zouoz8mOqmZeYcVOQ5OHR4cND+xmi
	r2ODy95pry+ovlXrBpOvEHZUYe5t1SfKLPT25LJrp59a8wx3smFV1eKm+f9Y7Io6YpkpPXmZFRO
	/dxG2+5zfDMStXWiqfbV2nspO8hnVNpjrLfBJpYBfG8IsUBP1FunauIsl/t6ZfJiKpPzcFY0EQL
	ToQhxiZ43niMlK0xkG92XRDtfe6dZa5d/Q8j3+rYtiqDBl74xwI2jzo2EAIbG0WdUVqxSEsYniL
	jY+v4Q9ZFBUHf0=
X-Received: by 2002:a05:600c:3b0f:b0:49f:cbf1:e765 with SMTP id 5b1f17b1804b1-49fcbf1e936mr162741265e9.0.1790063426306;
        Tue, 22 Sep 2026 00:50:26 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cc05f9sm53886955e9.3.2026.09.22.00.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 00:50:25 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Message-ID: <004c9d3b-6f9b-4bd7-85a3-4acdd5d95924@tuxon.dev>
Date: Tue, 22 Sep 2026 10:50:24 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
 p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Madieu <john.madieu.xa@bp.renesas.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
 <20260814141312.2947972-8-claudiu.beznea+renesas@tuxon.dev>
 <a7koqtuhya3psx7mmest3io5h775jxscivumouv64kbu23pssv@xkkqondobxui>
 <9c8fe3e4-1dcc-4663-8e3f-684ec4e09daa@tuxon.dev>
 <n7cafny3y6rr63tx6rkt5umxl3f4rsxpu2ojze7luudzzr4flb@egj7dru2bnhq>
Content-Language: en-US
In-Reply-To: <n7cafny3y6rr63tx6rkt5umxl3f4rsxpu2ojze7luudzzr4flb@egj7dru2bnhq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/26 19:49, Manivannan Sadhasivam wrote:
> On Fri, Sep 11, 2026 at 03:14:25PM +0300, claudiu beznea wrote:
>> Hi, Mani,
>>
>> On 9/10/26 17:38, Manivannan Sadhasivam wrote:
>>> On Fri, Aug 14, 2026 at 05:13:12PM +0300, Claudiu Beznea wrote:
>>>> From: John Madieu <john.madieu.xa@bp.renesas.com>
>>>>
>>>> The RZ/G3{E, S}, RZ/V2{H(P), N} PCIe controllers does not expose the
>>>> standard PCIe Slot Capability registers, so the generic pciehp driver
>>>> cannot be used. The only link-state signal the hardware provides is the
>>>> DL_UpDown bit in the PEIS0 event status register, which is raised on every
>>>> Data Link layer up/down transition.
>>>>
>>>> Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
>>>> can react to link-state changes: a device that trains after boot gets
>>>> enumerated, and a device that disappears on link loss is removed. This
>>>> provides hotplug-like behavior without the PCI hotplug core, which is
>>>> unavailable for the reason above.
>>>>
>>>> On a DL_UpDown event the handler acks the W1C status bit and schedules a
>>>> worker that inspects PCSTAT1.DL_DOWN_STS:
>>>>
>>>>     - link up: re-run max link speed negotiation, wait for the link to
>>>>       settle and pci_rescan_bus() the root bus;
>>>>     - link down: reset the root port, walk the bus in reverse and
>>>>       pci_stop_and_remove_bus_device() each child.
>>>>
>>>> Both paths take pci_lock_rescan_remove() to serialize against the PCI
>>>> core.
>>>>
>>>> While enumeration succeeds without resetting the root port, performing
>>>> reads and writes to an NVMe endpoint after a link down/link up cycle
>>>> results in failures on some devices. Address this by implementing
>>>> pci_host_bridge::reset_root_port() for the RZ/G3S PCIe driver.
>>>>
>>>> The implementation of pci_host_bridge::reset_root_port() masks all
>>>> enabled interrupts and synchronizes them before resetting the controller
>>>> to prevent asynchronous events from interfering with the reset operation.
>>>>
>>>> After the controller is reset, all previously masked interrupts are
>>>> restored.
>>>>
>>>> Since rzg3s_pcie_host_stop() or rzg3s_pcie_host_start() can fail
>>>> during a root port reset, introduce struct rzg3s_pcie_host::state to
>>>> track the host controller state. The interrupt handlers and register
>>>> access paths consult this state to avoid accessing the controller after a
>>>> failed reset. This was implemented to be able to re-use the
>>>> rzg3s_pcie_host_stop()/rzg3s_pcie_host_start() as is (since they call
>>>> functions which can sleep).
>>>>
>>>> The introduced states are START, STOP, PROCESS, and PORT_RESET. The initial
>>>> state is STOP. After the controller is initialized, the state is switched
>>>> to START. Any API exposed through struct pci_ops switches the controller
>>>> to the PROCESS state, as do the interrupt handlers.
>>>>
>>>> rzg3s_pcie_host_reset_root_port() switches the state to PORT_RESET to
>>>> prevent any controller access while the Root Port reset is in progress.
>>>>
>>>> A controller left in a broken state (STOP) after a failed root port reset
>>>> can recover after a system suspend/resume cycle, since
>>>> rzg3s_pcie_host_start() is invoked again during resume.
>>>>
>>>> Link events are processed only after the controller has been fully
>>>> initialized.
>>>>
>>>> While at it, make probe tolerant of an absent device. Previously, if the
>>>> link failed to come up during rzg3s_pcie_host_init(), probe tore the
>>>> controller back down and failed. Distinguish this case with -ENODEV,
>>>> leave the controller and refclk running, and let the link-up path
>>>> enumerate the device once it appears.
>>>>
>>>
>>> Please split the DL_UpDown addition and reset_root_port() into separate patches.
>>
>> If splitting, it would mean the DL_UpDown patch will be broken (at least for
>> RZ/G3S SoC). Would that be OK with you?
>>
> 
> It will not be broken, but just that the RP won't be reset through platform
> specific reset hook. So it is OK to have the successive commit add that
> functionality, provided it is mentioned in the commit message.

OK, will split it as suggested.

> 
>>>
>>>> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>>>> Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> - added RZG3S_PCI_PEIE0_DL_UPDOWN
>>>> - re-worked the support by implemeting
>>>>     struct pci_host_bridge::reset_root_port()
>>>> - introduced the struct rzg3s_pcie_host::state to:
>>>> -- avoid touching the controller while a reset root port is in progress
>>>> -- and avoid touching the controller in case a reset root port failed
>>>> -- and to be able to re-use the already existing code in the reset
>>>>      root port function
>>>> -- and added CLASS() constructs helpers for it to keep the state handling
>>>>      code simpler
>>>> - updated the patch description to reflect the updates
>>>>
>>>>    drivers/pci/controller/pcie-rzg3s-host.c | 375 +++++++++++++++++++++--
>>>>    1 file changed, 356 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
>>>> index 4765ac1befba..b3531468ef38 100644
>>>> --- a/drivers/pci/controller/pcie-rzg3s-host.c
>>>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>>>> @@ -86,6 +86,7 @@
>>>>    #define RZG3S_PCI_MSGRCVIS_MRI			BIT(24)
>>>>    #define RZG3S_PCI_PEIE0				0x200
>>>> +#define RZG3S_PCI_PEIE0_DL_UPDOWN		BIT(9)
>>>>    #define RZG3S_PCI_PEIS0				0x204
>>>>    #define RZG3S_PCI_PEIS0_RX_DLLP_PM_ENTER	BIT(12)
>>>> @@ -310,6 +311,24 @@ struct rzg3s_pcie_port {
>>>>    	u32 device_id;
>>>>    };
>>>> +/**
>>>> + * enum rzg3s_pcie_host_state - RZ/G3S PCIe Host state
>>>> + * @RZG3S_PCIE_HOST_STATE_STOP: Host is stopped (initial state, reached from
>>>> + *                              PORT_RESET, START)
>>>> + * @RZG3S_PCIE_HOST_STATE_START: Host is started (reached from STOP, PROCESS,
>>>> + *                               PORT_RESET)
>>>> + * @RZG3S_PCIE_HOST_STATE_PROCESS: Host is started and is processing requests
>>>> + *                                 (reached from START)
>>>> + * @RZG3S_PCIE_HOST_STATE_PORT_RESET: Host root port is resetting (reached from
>>>> + *                                    START)
>>>> + */
>>>> +enum rzg3s_pcie_host_state {
>>>> +	RZG3S_PCIE_HOST_STATE_STOP,
>>>> +	RZG3S_PCIE_HOST_STATE_START,
>>>> +	RZG3S_PCIE_HOST_STATE_PORT_RESET,
>>>> +	RZG3S_PCIE_HOST_STATE_PROCESS,
>>>> +};
>>>> +
>>>>    /**
>>>>     * struct rzg3s_pcie_host - RZ/G3S PCIe data structure
>>>>     * @axi: base address for AXI registers
>>>> @@ -323,6 +342,8 @@ struct rzg3s_pcie_port {
>>>>     * @msi: MSI data structure
>>>>     * @port: PCIe Root Port
>>>>     * @hw_lock: lock for access to the HW resources
>>>> + * @state: PCIe controller state
>>>> + * @event_irq: PCIe event interrupt for DL_UpDown detection
>>>>     * @intx_irqs: INTx interrupts
>>>>     * @max_link_speed: maximum supported link speed
>>>>     * @controller_id: PCIe controller identifier, used for System Controller access
>>>> @@ -340,6 +361,8 @@ struct rzg3s_pcie_host {
>>>>    	struct rzg3s_pcie_msi msi;
>>>>    	struct rzg3s_pcie_port port;
>>>>    	raw_spinlock_t hw_lock;
>>>> +	atomic_t state;
>>>> +	int event_irq;
>>>>    	int intx_irqs[PCI_NUM_INTX];
>>>>    	int max_link_speed;
>>>>    	enum rzg3s_pcie_controller_id controller_id;
>>>> @@ -348,6 +371,61 @@ struct rzg3s_pcie_host {
>>>>    #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
>>>> +/**
>>>> + * struct rzg3s_pcie_host_atomic_state - RZ/G3S PCIe state data structure
>>>> + * @state: Atomic state variable to operate on. Should point to
>>>> + *         struct rzg3s_pcie_host::state.
>>>> + * @expect: Expected host state. The host state is not changed if the
>>>> + *          current host state differs from the expected state.
>>>> + * @saved: Saved host state. When the host state is changed, the previous
>>>> + *         state is saved in this variable. This is necessary to restore
>>>> + *         the previous state after the protected section is executed.
>>>> + *
>>>> + * This structure is necessary for state setting and restoration using
>>>> + * CLASS() constructs.
>>>> + */
>>>> +struct rzg3s_pcie_host_atomic_state {
>>>> +	atomic_t *state;
>>>> +	enum rzg3s_pcie_host_state expect;
>>>> +	enum rzg3s_pcie_host_state saved;
>>>> +};
>>>> +
>>>> +static struct rzg3s_pcie_host_atomic_state
>>>> +rzg3s_pcie_host_atomic_state_save(atomic_t *state, int expect, int newval)
>>>> +{
>>>> +	return (struct rzg3s_pcie_host_atomic_state){
>>>> +		.state = state,
>>>> +		.expect = expect,
>>>> +		.saved = atomic_cmpxchg(state, expect, newval),
>>>> +	};
>>>> +}
>>>> +
>>>> +static void
>>>> +rzg3s_pcie_host_atomic_state_restore(struct rzg3s_pcie_host_atomic_state state)
>>>> +{
>>>> +	if (state.saved == state.expect)
>>>> +		atomic_xchg(state.state, state.expect);
>>>> +}
>>>> +
>>>> +DEFINE_CLASS(rzg3s_pcie_host_state_lock,
>>>> +	     struct rzg3s_pcie_host_atomic_state,
>>>> +	     rzg3s_pcie_host_atomic_state_restore(_T),
>>>> +	     rzg3s_pcie_host_atomic_state_save(state, expect, newval),
>>>> +	     atomic_t *state, int expect, int newval)
>>>> +
>>>> +/* Use it to change the state w/o the need to restore it on function exit. */
>>>> +#define RZG3S_PCIE_HOST_STATE_CHANGE(_state, _from, _to) \
>>>> +	CLASS(rzg3s_pcie_host_state_lock, _lock) \
>>>> +	      (_state, RZG3S_PCIE_HOST_STATE_##_from, \
>>>> +		       RZG3S_PCIE_HOST_STATE_##_to) \
>>>> +
>>>> +/*
>>>> + * Use it to check if the state change failed. _from is the initial state.
>>>> + * Use it in conjunction with RZG3S_PCIE_HOST_STATE_CHANGE().
>>>> + */
>>>> +#define RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(_from) \
>>>> +	(_lock.saved != RZG3S_PCIE_HOST_STATE_##_from)
>>>> +
>>>
>>> I don't really see a need for all these state management. None of the other
>>> controller drivers are doing and the serialization provided by the PCI core
>>> using pci_lock should be enough. If you find any issue or race, please share it
>>> here.
>>
>> The problems I see are the following:
>>
>> 1/ In theory, the rzg3s_pcie_host_start() in .reset_root_port() can fail. If
>>     that happens the controller is left with the clocks and resets disabled.
>>     Accessing  it later in this state may lead to sync aborts, and the system
>>     being fully blocked. This is how the HW behaves. Re-enabling clocks and
>>     resets in this situation may lead to unbalanced  reference counters for them.
>>
> 
> Once reset_root_port() fails, the controller is literally dead and the error is
> propagated to the PCI core. So who is going to access it later?

Actually, here I wanted to sustain that we need this to properly decide what to 
do with the clocks and resets on suspend/resume. Could use a bool as suggested 
bellow.

> 
>> 2/ In theory, struct pci_ops::{read, write} ops could be called while the reset
>>     is in progress, if I'm not wrong. That can be avoided by using a common spin
>>     lock but we can't use it in .reset_root_port() since this calls APIs
>>     that could sleep (e.g. clk_prepare_enable()/clk_disable_unprepare())
>>
> 
> AFAICS, 'block_cfg_access' will be set for the entire duration of the
> reset_root_port() invocation and it will prevent config space accessors to race
> with the reset.

I wasn't aware of this, thanks for sharing.

> 
>> 3/ Since at the moment the .suspend() is called the IRQs are enabled, the link
>>     event and the .suspend() can race. This could also be avoided by using
>>     a spin lock but, again, there are APIs on .reset_root_port() that can sleep.
>>
> 
> suspend/resume callbacks are only invoked in the no_irq phase.

I was referring to wakeup IRQs. At the moment we don't handle any wakeup IRQs in 
this driver. So, I think we should be safe dropping the code as you suggested.

> 
>> 4/ To keep sane the reference counted resources, handled in
>>     rzg3s_pcie_host_stop()/rzg3s_pcie_host_start(), the state track would be
>>     needed, for .reset_root_port() failure case and racing, since these functions
>>     are also called in suspend/resume
>>
> 
> You can solve it using a simple bool flag.

OK

> 
> So I still do not see a real need for these complex state management.

OK

Thank you,
Claudiu
