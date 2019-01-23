Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5D8C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 07:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3CC21019
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 07:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfAWHRr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:17:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47332 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfAWHRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2019 02:17:47 -0500
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gmCnB-0001pX-00
        for linux-pci@vger.kernel.org; Wed, 23 Jan 2019 07:17:45 +0000
Received: by mail-qk1-f197.google.com with SMTP id c84so1189928qkb.13
        for <linux-pci@vger.kernel.org>; Tue, 22 Jan 2019 23:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=St9mV3iKZXKzcGc7dcEFWjwZHYfQyG5DMI1JCAY27WQ=;
        b=eic6BbIj95lj/ta365ZdZvoiz0QxiQUcy8tfo34O52hGeRExVpJfQvy2lkMcaREii0
         5t+8Pa3r/eypW60Cyu2icGILU4toRvZJorxX6JopOmufNzt+PSJgIi7L/mggowGAPCyK
         jEAzhbQCTg2jTGnvuQX13y5e7LcZImY+T/YWHMIkEqnuglKteJj3r3N6pb2PLZ3HIIz+
         r/RsZ4W9DBGX/vSo6ivF4Gnk388BxT2C7J73YIoQsVKj/8PjsZuewJ3OnDge25fFUvSo
         UUZQfW1AbsCZlhJclAMKTmThsl/imIxkaOZV9epNHxyONMGUyPfhmTqqSWR3EIaRdlIz
         6NaA==
X-Gm-Message-State: AJcUukdW4poKOIC/yJWU1SgMhJRaQO/pdJJLuFUIpSWAlnwGB4QjzP0c
        Sq4SWV8ictslVo7Xr1AMHeX4GmaXoSrkbnR+NaHDrDakZ/ktNJSp/wd+wQSfs2HY8m1MR1LPDM9
        mKKsB3tt6LUjUZXEpKgzRvIW3bNmQzleI7NDp8g==
X-Received: by 2002:a0c:8382:: with SMTP id k2mr1033494qva.0.1548227863841;
        Tue, 22 Jan 2019 23:17:43 -0800 (PST)
X-Google-Smtp-Source: ALg8bN60SMpG2vK2ejh9n8cdWd0ef5hwZRZWZYc7doEf7ACVcWwyNSOcHXmrqMXWB7YcamHlUbUxKw==
X-Received: by 2002:a0c:8382:: with SMTP id k2mr1033476qva.0.1548227863629;
        Tue, 22 Jan 2019 23:17:43 -0800 (PST)
Received: from [10.101.46.245] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id x14sm23729980qki.30.2019.01.22.23.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 23:17:43 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190122235134.GE14636@google.com>
Date:   Wed, 23 Jan 2019 15:17:37 +0800
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Jan 23, 2019, at 7:51 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Tue, Jan 22, 2019 at 02:45:44PM +0800, Kai-Heng Feng wrote:
>> There are some e1000e devices can only be woken up from D3 one time, by
>> plugging ethernet cable. Subsequent cable plugging does set PME bit
>> correctly, but it still doesn't get woken up.
>> 
>> Since e1000e connects to the root complex directly, we rely on ACPI to
>> wake it up. In this case, the GPE from _PRW only works once and stops
>> working after that.
>> 
>> So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
>> platform firmwares that have unreliable GPE wake.
> 
> This quirk applies to all 0x15bb (E1000_DEV_ID_PCH_CNP_I219_LM7) and
> 0x15bd (E1000_DEV_ID_PCH_CNP_I219_LM6) devices.  The e1000e driver
> claims about a zillion different device IDs.
> 
> I would be surprised if these two devices are defective but all the
> others work correctly.  Could it be that there is a problem with the
> wiring on this particular motherboard or with the ACPI _PRW methods
> (or the way Linux interprets them) in this firmware?

If this is a motherboard issue or platform specific, do you prefer to use
DMI matches here?

As for _PRW, it’s shared by USB controller, Audio controller and ethernet.
Only the ethernet (e1000e) has this issue.

When this issue happens, the e1000e doesn’t get woken up by ethernet cable
plugging, but inserting a USB device or plugging audio jack can wake up all
three devices. So I think Linux interprets ACPI correctly here.

Their _PRW here:
USB controller:
    Scope (_SB.PCI0)                       
    {                                      
        Device (XDCI)                            
        {                    
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {            
                Return (GPRW (0x6D, 0x04))
            } 

Audio controller:
Scope (_SB.PCI0)                                                                                           
    {                                                                                                          
        Device (HDAS)                                  
        {                                                                             
            …         
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake                 
            {                                        
                Return (GPRW (0x6D, 0x04))           
            }                                  

Ethernet controller:
    Scope (_SB.PCI0)                                                                     
    {                                                                     
        Device (GLAN)                                                  
        {                                                                            
           …
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake                 
            {                                        
                Return (GPRW (0x6D, 0x04))                       
            }                                                              
        }                                                             
    }  


> 
> Would you mind attaching a complete dmesg log and "sudo lspci -vvv"
> output to the bugzilla, please?

Sure.

Kai-Heng

> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/pci/pci-acpi.c | 2 +-
>> drivers/pci/quirks.c   | 8 ++++++++
>> include/linux/pci.h    | 1 +
>> 3 files changed, 10 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index e1949f7efd9c..184e2fc8a294 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -430,7 +430,7 @@ static void pci_acpi_wake_dev(struct acpi_device_wakeup_context *context)
>> 
>> 	pci_dev = to_pci_dev(context->dev);
>> 
>> -	if (pci_dev->pme_poll)
>> +	if (pci_dev->pme_poll && !pci_dev->unreliable_acpi_wake)
>> 		pci_dev->pme_poll = false;
>> 
>> 	if (pci_dev->current_state == PCI_D3cold) {
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index b0a413f3f7ca..ed4863496fa8 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4948,6 +4948,14 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>> DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>> 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>> 
>> +static void quirk_unreliable_acpi_wake(struct pci_dev *pdev)
>> +{
>> +	pci_info(pdev, "ACPI Wake unreliable, always poll PME\n");
>> +	pdev->unreliable_acpi_wake = 1;
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bb, quirk_unreliable_acpi_wake);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bd, quirk_unreliable_acpi_wake);
>> +
>> /*
>>  * Some IDT switches incorrectly flag an ACS Source Validation error on
>>  * completions for config read requests even though PCIe r4.0, sec
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 65f1d8c2f082..d22065c1576f 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -331,6 +331,7 @@ struct pci_dev {
>> 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>> 					   can be generated */
>> 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
>> +	unsigned int	unreliable_acpi_wake:1;	/* ACPI Wake doesn't always work */
>> 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>> 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
>> 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>> -- 
>> 2.17.1
>> 

