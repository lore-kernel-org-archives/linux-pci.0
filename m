Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36718C10F06
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 19:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD6B2082C
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 19:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="kZnzUddy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDCTTC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:19:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55879 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCTTC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 15:19:02 -0400
Received: by mail-it1-f196.google.com with SMTP id z126so12931237itd.5
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2019 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bMCOGXmLF5wjvy9jA5PszKgas1/60CqLKpYfkvXW+aM=;
        b=kZnzUddyz8wcYLBEeZ2gVuoYBXU59hy4n5B0jyGx/eDBqnhDo4sceNITNrl51p3p1v
         sEgUzxvcQsArxbm3fAsedt0DtJL8X1LDWECUBv0ms8CURY86vqze4ePvtKoYg7BFnx+o
         Re+GdmF5RN6lfaq7pbxvmOFtbODdCrdl5TsRMNF5qkKsqKdj3HxocldjE3w1ekw5jPsH
         iNjR0l3qyHvlle0b5Gyo33Bbf2qQm921LFx7aB4CX1G3qkF3UhGv6/c2awaQ+NOzndWF
         bvfMn74ho4zspIC6T8fjsobKCK1306P//G+58lPOBX2xKLhhZ08k/ptVue739SufzOXx
         lJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bMCOGXmLF5wjvy9jA5PszKgas1/60CqLKpYfkvXW+aM=;
        b=Gw9IkyutL67zjdsOVhmZaXOdjlgmkdXeIuniMZgudVZOj+AreZmeqAGoWjusRBbZaM
         sY14mB4M2KIOabbNieUw5li8cp65gp/hH9bhLN2hQ7hm65j8qYDT1vO6bMW7qHl+ENUH
         dOEjDUcVXZavjGY3XB128txnUIPWXDVe/dX1m0uFX1fyhDBXLIsb1/1wnQWSHIwvrEKC
         pATkb394VtTRuX3j70TGTbHZS96fiQe+sNgqMFw4TTA6dS5HLFLaC3r/dLsJablxDQhI
         iEfXSVNmYqGc153/SV2EW/zN8UMXc3sLzRkmllwhLsX4vNebSANf+AhyD6nDVTKvjDmq
         gwBg==
X-Gm-Message-State: APjAAAUz2Zz/5wUPEg/6GXS0RxAJrP9hVel2epVbJdvJtqPotHdUn3ZZ
        6kU09qydSIATsk9dXMhDJCqy4w==
X-Google-Smtp-Source: APXvYqxPqMm+KIUlKUBHneIOA/4976+5rup3TduQMJ2tTgJb3p6hLzI7oR6nJBHVnOU2njVrVyC+VQ==
X-Received: by 2002:a02:8c4d:: with SMTP id j13mr1745823jal.48.1554319140613;
        Wed, 03 Apr 2019 12:19:00 -0700 (PDT)
Received: from Fredericks-MacBook-Pro.local ([150.199.191.185])
        by smtp.gmail.com with ESMTPSA id b129sm1345553ita.14.2019.04.03.12.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 12:18:59 -0700 (PDT)
Subject: Re: [PATCH net] r8169: switch off ASPM by default and add sysfs
 attribute to control ASPM
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>
References: <275eb60f-8cfe-9ff6-97bc-39d9ef280d36@gmail.com>
 <0640ba80-519f-ab76-a86d-e42833df46fb@gmail.com>
 <4f0e0f6c-20b7-73f8-e524-9798dfbac6d9@gmail.com>
 <20190402215752.GG141706@google.com>
 <436d3d44-27ab-2d4b-988e-8411b8ea3759@gmail.com>
 <20190403131446.GH141706@google.com>
 <b8787012-0928-e613-bbf6-4de3e462f055@gmail.com>
From:   Frederick Lawler <fred@fredlawl.com>
Message-ID: <7c6cad89-1901-f2be-37c6-dd3deffc25d2@fredlawl.com>
Date:   Wed, 3 Apr 2019 14:18:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 PostboxApp/6.1.13
MIME-Version: 1.0
In-Reply-To: <b8787012-0928-e613-bbf6-4de3e462f055@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Heiner Kallweit wrote on 4/3/19 12:45 PM:
> On 03.04.2019 15:14, Bjorn Helgaas wrote:
>> [+cc Frederick]
>>
>> On Wed, Apr 03, 2019 at 07:53:40AM +0200, Heiner Kallweit wrote:
>>> On 02.04.2019 23:57, Bjorn Helgaas wrote:
>>>> On Tue, Apr 02, 2019 at 10:41:20PM +0200, Heiner Kallweit wrote:
>>>>> On 02.04.2019 22:16, Florian Fainelli wrote:
>>>>>> On 4/2/19 12:55 PM, Heiner Kallweit wrote:
>>>>>>> There are numerous reports about different problems caused by ASPM
>>>>>>> incompatibilities between certain network chip versions and board
>>>>>>> chipsets. On the other hand on (especially mobile) systems where ASPM
>>>>>>> works properly it can significantly contribute to power-saving and
>>>>>>> increased battery runtime.
>>>>>>> One problem so far to make ASPM configurable was to find an acceptable
>>>>>>> way of configuration (e.g. module parameters are discouraged for that
>>>>>>> purpose).
>>>>>>>
>>>>>>> As a new attempt let's switch off ASPM per default and make it
>>>>>>> configurable by a sysfs attribute. The attribute is documented in
>>>>>>> new file Documentation/networking/device_drivers/realtek/r8169.txt.
>>>>
>>>> Both module parameters and sysfs attributes are a poor user
>>>> experience.  It's very difficult for users to figure out that
>>>> a tweak is needed.
>>>>
>>>>>> I am not sure this is where it should be solved, there is
>>>>>> definitively a device specific aspect to properly supporting the
>>>>>> enabling of ASPM L0s, L1s etc, but the actual sysfs knobs should
>>>>>> belong to the pci_device itself, since this is something that
>>>>>> likely other drivers would want to be able to expose. You would
>>>>>> probably want to work with the PCI maintainers to come up with a
>>>>>> standard solution that applies beyond just r8169 since presumably
>>>>>> there must be a gazillion of devices with the same issues.
>>>>
>>>> The Linux PCI core support for ASPM is poor.  Without more details,
>>>> it's impossible to tell whether these issues are hardware or firmware
>>>> defects on the device itself, or something that Linux is doing wrong.
>>>> There are several known defects, especially related to L1 substates
>>>> and hotplug.
>>>>
>>> The vendor refuses to release datasheets or errata. Only certain
>>> combinations of board chipsets (and maybe BIOS versions) and network
>>> chip versions (from the ~ 50 supported by the driver) seem to be
>>> affected. One typical symptom is missed RX packets, maybe the RX FIFO
>>> isn't big enough to buffer all packets until PCIe has woken up.
>>> The Windows vendor driver uses a hack, they dynamically disable ASPM
>>> under load.
>>
>> I'm not super sympathetic to vendors like that or to OEMs that work
>> with them.  If we can make the NIC work reliably by disabling ASPM,
>> that's step one.  If we can figure out how to extend battery life by
>> enabling ASPM in some cases, great, but we have to be careful to do it
>> in a way that is supportable and doesn't generate lots of user
>> complaints that require debugging.
>>
>> That said, I think Frederick has already started working on a plan for
>> the PCI core to expose sysfs files to manage ASPM.  This is similar to
>> the link_state files enabled by CONFIG_PCIEASPM_DEBUG, but it will be
>> always enabled and probably structured slightly differently.  The idea
>> is that this would be generic and would not require any driver
>> support.
>>
> Thanks, Bjorn!
> Frederick, is there anything you could share already? Or any timeline?

Heiner,

I've been on hold for this pet project for a bit. If you're willing to 
take this one on, all the merrier :)

The plan is the sysfs files would sit on the endpoint devices, and given 
a supported state value, configure the link(s) for the endpoints 
upstream port to its immediate root port or switch downstream port. 
Then, this allows something else handle the walking of the tree via the 
ABI. We don't necessarily want to configure sibling links under a switch.

I'm currently traveling, and I can't get you patches until this weekend.

> Based on Bjorns info what seems to be best to me:
> 1. Disable ASPM for r8169 on stable (back to 4.19).
> 2. Once the generic ASPM sysfs attributes are available, reenable ASPM
>     for r8169 in net-next.
> 
>> Bjorn
>>
> Heiner
> 

Frederick Lawler

