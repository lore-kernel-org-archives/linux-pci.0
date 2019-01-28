Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D2C282C8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1079720881
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfA1HvR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:51:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43777 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfA1HvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 02:51:17 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1go1hJ-0006AJ-Oq
        for linux-pci@vger.kernel.org; Mon, 28 Jan 2019 07:51:14 +0000
Received: by mail-pf1-f197.google.com with SMTP id i3so13513997pfj.4
        for <linux-pci@vger.kernel.org>; Sun, 27 Jan 2019 23:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/E+wvqgvML2gnJk6c1toEQKZlLCIrBjpRFvWrvUmb7E=;
        b=DbaKQahtxquRTVJSsHt4NK9gCDuItPTIjPuI/xhvLOhO0RLEXquksU1snPLbOTVRRS
         RhO7sIP+Fq3qQNyqsN2/Y/8KwnlQlvEB7e7W5dRjx0Qf/WXgkboGNsCWZSR9SUOeaBER
         rIntdwgNebhA3xuRwq9zQuaJSA0SQuCuGR0E4hwNnwv5d8V9CN2EapT59/6PkY9KO+3k
         YFfCgnT4nSbN1cf4bQsU4VwVrMPRI7D+b8TltnaVmHdfMEpDy+hNE2heVXz5y9HA47P1
         pmiPv2r+rIa4kkljy3PSTcYx5vi27kNEa5os7D2Wb+66+q9fePoowh4OlGa27JREO2NO
         gFIA==
X-Gm-Message-State: AJcUukcfq7P9onSX9TW/hyWnPrLlY1lpnJtTrnRWUjFCC8lWkn04IKTy
        KVNdpvowMBAzvMS4AhOKZ/gzRk0uBWVRdOyzF3F3ED66Fv2pzZab5d1BIow1PFB3gbOLPus/BC3
        5iX1jehbZQpEUADE0xWrcdnE7sq4lvYLuha4lCA==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr19041148pgk.397.1548661872392;
        Sun, 27 Jan 2019 23:51:12 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7uq+SsaHOGr0yF2ai2raaqQn+2M9TbAvNvM4jcQrNlphqQ7jLwInt94CVrwu6OQC6UYkmxUg==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr19041126pgk.397.1548661871959;
        Sun, 27 Jan 2019 23:51:11 -0800 (PST)
Received: from [10.101.46.245] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id s84sm63252569pfi.15.2019.01.27.23.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 23:51:11 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190124200508.GH14636@google.com>
Date:   Mon, 28 Jan 2019 15:51:08 +0800
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C7E9B3C9-7E20-4CEB-8B56-D9A8D2E76DD0@canonical.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
 <20190124151524.GF14636@google.com>
 <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
 <20190124200508.GH14636@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Jan 25, 2019, at 4:05 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Thu, Jan 24, 2019 at 11:29:37PM +0800, Kai Heng Feng wrote:
>>> On Jan 24, 2019, at 11:15 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Wed, Jan 23, 2019 at 03:17:37PM +0800, Kai Heng Feng wrote:
>>>>> On Jan 23, 2019, at 7:51 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>> On Tue, Jan 22, 2019 at 02:45:44PM +0800, Kai-Heng Feng wrote:
>>>>>> There are some e1000e devices can only be woken up from D3 one time, by
>>>>>> plugging ethernet cable. Subsequent cable plugging does set PME bit
>>>>>> correctly, but it still doesn't get woken up.
>>>>>> 
>>>>>> Since e1000e connects to the root complex directly, we rely on ACPI to
>>>>>> wake it up. In this case, the GPE from _PRW only works once and stops
>>>>>> working after that.
>>>>>> 
>>>>>> So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
>>>>>> platform firmwares that have unreliable GPE wake.
>>>>> 
>>>>> This quirk applies to all 0x15bb (E1000_DEV_ID_PCH_CNP_I219_LM7) and
>>>>> 0x15bd (E1000_DEV_ID_PCH_CNP_I219_LM6) devices.  The e1000e driver
>>>>> claims about a zillion different device IDs.
>>>>> 
>>>>> I would be surprised if these two devices are defective but all the
>>>>> others work correctly.  Could it be that there is a problem with the
>>>>> wiring on this particular motherboard or with the ACPI _PRW methods
>>>>> (or the way Linux interprets them) in this firmware?
>>>> 
>>>> If this is a motherboard issue or platform specific, do you prefer to use
>>>> DMI matches here?
>>> 
>>> I'm not sure what the problem is yet, so let's hold off on the exact
>>> structure of the fix.
>> 
>> I think DMI table can put in e1000e driver instead of PCI quirk.
> 
> I don't think we should add a quirk or DMI table yet because we
> haven't gotten to the root cause of this problem.  If the root cause
> is a problem in the Linux code, adding a quirk will mask the problem
> for this specific system, but will leave other systems with similar
> problems.
> 
>>> If I understand correctly, e1000e wakeup works once, but doesn't work
>>> after that.  Your lspci (from after that first wakeup, from
>>> https://bugzilla.kernel.org/attachment.cgi?id=280691) shows this:
>>> 
>>> 00:14.0 XHC  XHCI USB
>>>   Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
>>>   Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>>> 00:1f.3 HDAS audio
>>>   Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
>>>   Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>>> 00:1f.6 GLAN e1000e
>>>   Flags: PMEClk- DSI+ D1- D2- ... PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>>   Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME+
>>> 
>>> So the e1000e PME_Status bit is still set, which means it probably
>>> won't generate another PME interrupt, which would explain why wakeup
>>> doesn't work.  To test this theory, can you try this:
>>> 
>>> - sleep
>>> - wakeup via e1000e
>>> # DEV=00:1f.6
>>> # lspci -vvs $DEV
>>> # setpci -s $DEV CAP_PM+4.W
>>> # setpci -s $DEV CAP_PM+4.W=0x8100
>>> - sleep
>>> - attempt another wakeup via e1000e
>>> 
>>> If this second wakeup works, it would suggest that PME_Status isn't
>>> being cleared correctly.  I see code, e.g., in
>>> acpi_setup_gpe_for_wake(), that *looks* like it would arrange to clear
>>> it, but I'm not very familiar with it.  Maybe there's some issue with
>>> multiple devices sharing an "implicit notification" situation like
>>> this.
>> 
>> The PME status is being cleared correctly.
> 
> I was hoping to understand this better via the experiment above, but
> I'm still confused.  Here's the scenario as I understand it:
> 
>  0) fresh boot
>  1) e1000e PME_Status should be 0
>  2) sleep
>  3) wakeup via e1000e succeeds
>  4) e1000e PME_Status should be 0
>  5) sleep
>  6) wakeup via e1000e fails
>  7) wakeup via USB succeeds
>  8) e1000e PME_Status should be 0, but is actually 1

Sorry for not illustrating the scenario more clearly, here’s the test scenario:
 0) fresh boot
 1) no ethernet cable plugged
 2) e1000e runtime suspend
 3) PME_Status is 0
 4) plug ethernet cable
 5) e1000e gets woken up by ACPI wakeup
 6) network connection established
 6) unplug the ethernet cable
 7) e1000e runtime suspend
 8) plug ethernet cable again
 9) PME_Status=1 but it’s not woken up, stays suspended
 10) Plug a USB device, e1000e wakes up.

This shows somehow the ACPI GPE still works for USB controller but not ethernet device.

> 
> If I understand correctly, the bugzilla lspci
> (https://bugzilla.kernel.org/attachment.cgi?id=280691) was collected
> at point 8, and it shows PME_Status=1 when it should be 0.
> 
> If we write a 1 to PME_Status to clear it, and it remains set, that's
> obviously a hardware defect, and Intel should document that in an
> erratum, and a quirk would be the appropriate way to work around it.
> But I doubt that's what's happening.

I’ll ask them if they can provide an erratum.

> 
> If e1000e changes PME_Status from 0 to 1 and we don't get an interrupt
> (in this case, an SCI triggering GPE 0x6d), the problem is something
> in the path outside e1000e.  Since the wakeup works the first time, we
> know e1000e is *capable* of generating an interrupt, and the problem
> is probably something in the way we acknowledge it.
> 
> I want to make sure we're executing the code that clears
> PCI_PM_CTRL_PME_STATUS.  Would you mind applying the patch below,
> turning on CONFIG_ACPI_DEBUG, booting with
> 
>  acpi.debug_layer=0x00000004 acpi.debug_level=0x00000004
> 
> and collecting the dmesg log?  I think you can also set these debug
> flags via /sys/module/acpi/parameters/debug_* if that's easier.

Dmesg with the debug patch applied:
https://bugzilla.kernel.org/attachment.cgi?id=280819

At the end, I re-plugged the ethernet cable, nothing shows.

Kai-Heng

> 
>> The lspci is captured after I plugged the ethernet cable second time,
>> i.e. PME is set but not being woken up.
>> 
>> Kai-Heng
> 
> Bjorn
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c9d8e3c837de..91a70ffdd3a1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1927,7 +1927,7 @@ void pcie_clear_root_pme_status(struct pci_dev *dev)
> bool pci_check_pme_status(struct pci_dev *dev)
> {
> 	int pmcsr_pos;
> -	u16 pmcsr;
> +	u16 pmcsr, pmcsr_orig;
> 	bool ret = false;
> 
> 	if (!dev->pm_cap)
> @@ -1939,6 +1939,7 @@ bool pci_check_pme_status(struct pci_dev *dev)
> 		return false;
> 
> 	/* Clear PME status. */
> +	pmcsr_orig = pmcsr;
> 	pmcsr |= PCI_PM_CTRL_PME_STATUS;
> 	if (pmcsr & PCI_PM_CTRL_PME_ENABLE) {
> 		/* Disable PME to avoid interrupt flood. */
> @@ -1948,6 +1949,9 @@ bool pci_check_pme_status(struct pci_dev *dev)
> 
> 	pci_write_config_word(dev, pmcsr_pos, pmcsr);
> 
> +	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
> +	pci_info(dev, "%s PM_CTRL %#06x -> %#06x\n", __func__, pmcsr_orig, pmcsr);
> +
> 	return ret;
> }
> 
> @@ -2027,18 +2031,22 @@ static void pci_pme_list_scan(struct work_struct *work)
> 
> static void __pci_pme_active(struct pci_dev *dev, bool enable)
> {
> -	u16 pmcsr;
> +	u16 pmcsr, pmcsr_orig;
> 
> 	if (!dev->pme_support)
> 		return;
> 
> 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	pmcsr_orig = pmcsr;
> 	/* Clear PME_Status by writing 1 to it and enable PME# */
> 	pmcsr |= PCI_PM_CTRL_PME_STATUS | PCI_PM_CTRL_PME_ENABLE;
> 	if (!enable)
> 		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
> 
> 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
> +
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	pci_info(dev, "%s PM_CTRL %#06x -> %#06x\n", __func__, pmcsr_orig, pmcsr);
> }
> 
> /**

