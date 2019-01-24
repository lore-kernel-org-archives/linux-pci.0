Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAC3C282C6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7E8218A2
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 15:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfAXP3r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:29:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57214 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfAXP3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 10:29:46 -0500
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gmgwp-0001nV-8R
        for linux-pci@vger.kernel.org; Thu, 24 Jan 2019 15:29:43 +0000
Received: by mail-pf1-f198.google.com with SMTP id 68so4882365pfr.6
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 07:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WFa4kIbVYiPOqZcfzasMHxpPdhKLumUqFyMF55zRdiA=;
        b=T4D5nXRy0INJ1nIk7PUlAbt7/m9ndyCfc5vT4OzhXIXO3FgIjADMG5nIV/lKRHcXrp
         2iRroYmGfF2h1Qf12uK8FCoiQ51raknaJHjJ0cnT2FylTjoc7STV/M+7lDdeVw081MiL
         ECgblS477skdzlQGA/ywaCH9317i2yVEgR1kKI+1C8jJ5KTOz2OlU7cpIklNFvNWIe/E
         sIQefsprR/vBLzXYcwW6dOmxwJd0B/Xmu5MDZaRzwO58Z9FutAIN80daNpDODrQHRLB3
         0ovw7vIc/sb9AePYwCPBziy+fscwKg8EricphdY26OSQxi+eqNHl49JAM5KZMUuE+6Dg
         KwLA==
X-Gm-Message-State: AJcUukdYDsGUSVYZGKFZ61OjU7C6pzuPIGad/j8MGDDqo7ELDnwCv2Hf
        S24DDimp3N9Bu/YSwbnSuCi5JZkC66krtooOXPTMTcC7DiUJSgsbaZ9Uyl51T3WB7+8RPh5a0DG
        5+iRtyYNQl52q2AJ35rDBBh2A/zpYz9V9ZRy0gA==
X-Received: by 2002:a62:9719:: with SMTP id n25mr7158645pfe.240.1548343781875;
        Thu, 24 Jan 2019 07:29:41 -0800 (PST)
X-Google-Smtp-Source: ALg8bN53acravPO7ZkfjWLyguRfeG2d939Ztia9IiljET0MsMrXQQJdArx8czcP104wtnG4lIZF8Hw==
X-Received: by 2002:a62:9719:: with SMTP id n25mr7158629pfe.240.1548343781469;
        Thu, 24 Jan 2019 07:29:41 -0800 (PST)
Received: from [192.168.1.215] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id l22sm39687370pfj.179.2019.01.24.07.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 07:29:40 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190124151524.GF14636@google.com>
Date:   Thu, 24 Jan 2019 23:29:37 +0800
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
 <20190124151524.GF14636@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Jan 24, 2019, at 11:15 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Wed, Jan 23, 2019 at 03:17:37PM +0800, Kai Heng Feng wrote:
>>> On Jan 23, 2019, at 7:51 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Tue, Jan 22, 2019 at 02:45:44PM +0800, Kai-Heng Feng wrote:
>>>> There are some e1000e devices can only be woken up from D3 one time, by
>>>> plugging ethernet cable. Subsequent cable plugging does set PME bit
>>>> correctly, but it still doesn't get woken up.
>>>> 
>>>> Since e1000e connects to the root complex directly, we rely on ACPI to
>>>> wake it up. In this case, the GPE from _PRW only works once and stops
>>>> working after that.
>>>> 
>>>> So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
>>>> platform firmwares that have unreliable GPE wake.
>>> 
>>> This quirk applies to all 0x15bb (E1000_DEV_ID_PCH_CNP_I219_LM7) and
>>> 0x15bd (E1000_DEV_ID_PCH_CNP_I219_LM6) devices.  The e1000e driver
>>> claims about a zillion different device IDs.
>>> 
>>> I would be surprised if these two devices are defective but all the
>>> others work correctly.  Could it be that there is a problem with the
>>> wiring on this particular motherboard or with the ACPI _PRW methods
>>> (or the way Linux interprets them) in this firmware?
>> 
>> If this is a motherboard issue or platform specific, do you prefer to use
>> DMI matches here?
> 
> I'm not sure what the problem is yet, so let's hold off on the exact
> structure of the fix.

I think DMI table can put in e1000e driver instead of PCI quirk.

> 
> If I understand correctly, e1000e wakeup works once, but doesn't work
> after that.  Your lspci (from after that first wakeup, from
> https://bugzilla.kernel.org/attachment.cgi?id=280691) shows this:
> 
>  00:14.0 XHC  XHCI USB
>    Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
>    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>  00:1f.3 HDAS audio
>    Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
>    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>  00:1f.6 GLAN e1000e
>    Flags: PMEClk- DSI+ D1- D2- ... PME(D0+,D1-,D2-,D3hot+,D3cold+)
>    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME+
> 
> So the e1000e PME_Status bit is still set, which means it probably
> won't generate another PME interrupt, which would explain why wakeup
> doesn't work.  To test this theory, can you try this:
> 
>  - sleep
>  - wakeup via e1000e
>  # DEV=00:1f.6
>  # lspci -vvs $DEV
>  # setpci -s $DEV CAP_PM+4.W
>  # setpci -s $DEV CAP_PM+4.W=0x8100
>  - sleep
>  - attempt another wakeup via e1000e
> 
> If this second wakeup works, it would suggest that PME_Status isn't
> being cleared correctly.  I see code, e.g., in
> acpi_setup_gpe_for_wake(), that *looks* like it would arrange to clear
> it, but I'm not very familiar with it.  Maybe there's some issue with
> multiple devices sharing an "implicit notification" situation like
> this.

The PME status is being cleared correctly.

The lspci is captured after I plugged the ethernet cable second time,
i.e. PME is set but not being woken up.

Kai-Heng

> 
>> As for _PRW, it’s shared by USB controller, Audio controller and ethernet.
>> Only the ethernet (e1000e) has this issue.
>> 
>> When this issue happens, the e1000e doesn’t get woken up by ethernet cable
>> plugging, but inserting a USB device or plugging audio jack can wake up all
>> three devices. So I think Linux interprets ACPI correctly here.
>> 
>> Their _PRW here:
>> USB controller:
>>    Scope (_SB.PCI0)                       
>>    {                                      
>>        Device (XDCI)                            
>>        {                    
>>            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
>>            {            
>>                Return (GPRW (0x6D, 0x04))
>>            } 
>> 
>> Audio controller:
>> Scope (_SB.PCI0)                                                                                           
>>    {                                                                                                          
>>        Device (HDAS)                                  
>>        {                                                                             
>>            …         
>>            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake                 
>>            {                                        
>>                Return (GPRW (0x6D, 0x04))           
>>            }                                  
>> 
>> Ethernet controller:
>>    Scope (_SB.PCI0)                                                                     
>>    {                                                                     
>>        Device (GLAN)                                                  
>>        {                                                                            
>>           …
>>            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake                 
>>            {                                        
>>                Return (GPRW (0x6D, 0x04))                       
>>            }                                                              
>>        }                                                             
>>    }  
>> 
>> 
>>> 
>>> Would you mind attaching a complete dmesg log and "sudo lspci -vvv"
>>> output to the bugzilla, please?
>> 
>> Sure.
>> 
>> Kai-Heng
>> 
>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/pci/pci-acpi.c | 2 +-
>>>> drivers/pci/quirks.c   | 8 ++++++++
>>>> include/linux/pci.h    | 1 +
>>>> 3 files changed, 10 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>>> index e1949f7efd9c..184e2fc8a294 100644
>>>> --- a/drivers/pci/pci-acpi.c
>>>> +++ b/drivers/pci/pci-acpi.c
>>>> @@ -430,7 +430,7 @@ static void pci_acpi_wake_dev(struct acpi_device_wakeup_context *context)
>>>> 
>>>> 	pci_dev = to_pci_dev(context->dev);
>>>> 
>>>> -	if (pci_dev->pme_poll)
>>>> +	if (pci_dev->pme_poll && !pci_dev->unreliable_acpi_wake)
>>>> 		pci_dev->pme_poll = false;
>>>> 
>>>> 	if (pci_dev->current_state == PCI_D3cold) {
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index b0a413f3f7ca..ed4863496fa8 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -4948,6 +4948,14 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>>>> DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>>>> 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>>>> 
>>>> +static void quirk_unreliable_acpi_wake(struct pci_dev *pdev)
>>>> +{
>>>> +	pci_info(pdev, "ACPI Wake unreliable, always poll PME\n");
>>>> +	pdev->unreliable_acpi_wake = 1;
>>>> +}
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bb, quirk_unreliable_acpi_wake);
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bd, quirk_unreliable_acpi_wake);
>>>> +
>>>> /*
>>>> * Some IDT switches incorrectly flag an ACS Source Validation error on
>>>> * completions for config read requests even though PCIe r4.0, sec
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 65f1d8c2f082..d22065c1576f 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -331,6 +331,7 @@ struct pci_dev {
>>>> 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>>>> 					   can be generated */
>>>> 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
>>>> +	unsigned int	unreliable_acpi_wake:1;	/* ACPI Wake doesn't always work */
>>>> 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>>>> 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
>>>> 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>>>> -- 
>>>> 2.17.1

