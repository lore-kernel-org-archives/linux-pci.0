Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5DCC10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 18:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5C52077C
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 18:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcEUWT/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDIS2H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:28:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37976 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDIS2H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2019 14:28:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so22198464wro.5;
        Tue, 09 Apr 2019 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rI2dHktFf29LMpaXP3wlLg3G3s7n8KVzhX1gsAI8cmM=;
        b=jcEUWT/IRJM0aHI8eBnAR1S5OFKzRpMfbAN4OvwetUXi7pD8xVPdg5K3DQrfJohruj
         fXboccIXV+GjnFzuAlySHynSJuRfe6Uj7Mi5ltlAbbiO9o1EN1Qe4lRVy7eOfodqCFPj
         hamCCF59UmgTG/S8AB5QHyk32PIEFaWhrim6aW69BkeoRqdX6/tLJxB4L8reu87o7KT5
         ePp4hXRCvKE+6qACke40uiQcFpsZ7cQ3FkFvByoCskvKFVy3YEUcboJ+AaICHqPZ1NC1
         CdIXRL8Rl0mFe3vWvkXn7U6qo7GMdEPo7n+O6cIzYKxCP+RzAjnc1lfBKNRLOyMwsi2G
         b7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rI2dHktFf29LMpaXP3wlLg3G3s7n8KVzhX1gsAI8cmM=;
        b=cquo7TjMrgSJIBU75uXIG87VWwnbAPkxC9st5tm3MnCYVK88jCGvgIGSMkYvwObZO3
         kWmr2MicVNlreJUsIWItXSs+M9McPlwRPNOCD8vzH2h/1qBuQsiXRq5VdvHrO1/tA8lb
         FX+1g6L4MWZEk/o6ZMWXC8K/qZoeI+SYEPVLb/f6PWVhfew4Q5UAffP9lIvyY9Wa5aTK
         FQtBC2/XiImcPoMiP9U3r2nymvH4NRaU9+xCdKsRTaVQnLfBc1V9tJ5aGapW5vdfPlZl
         L910yLwqyX0xxNSpAATjli4azFJ9fMVaLG6zuKQgokS6FYr3wbPBB0H8Ug90hITvJfNa
         RbBA==
X-Gm-Message-State: APjAAAVczmf5Fmxpa/3TesQBZ4EBYXbrsl7d65Kz6MMQtdjCCprS5lJW
        SS6X6rg4rqhc/aW/Z8sH5VlsCGmq
X-Google-Smtp-Source: APXvYqzqyj1DXiEvJevI8+z2vLpq97Ezx4M4BR7SrXI7JJbZt/o3en2iO1cM+samNJQ3mv+Sjf51wg==
X-Received: by 2002:adf:df0f:: with SMTP id y15mr2645214wrl.175.1554834484796;
        Tue, 09 Apr 2019 11:28:04 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bde:d800:c598:c5b:52d1:ebd6? (p200300EA8BDED800C5980C5B52D1EBD6.dip0.t-ipconnect.de. [2003:ea:8bde:d800:c598:c5b:52d1:ebd6])
        by smtp.googlemail.com with ESMTPSA id h131sm4465375wmh.1.2019.04.09.11.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 11:28:04 -0700 (PDT)
Subject: Re: [PATCH net] r8169: switch off ASPM by default and add sysfs
 attribute to control ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Frederick Lawler <fred@fredlawl.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
 <20190405191024.GD26522@google.com>
 <58f445a2-1eb3-7759-62d6-efacd87d52b6@gmail.com>
 <2698cdee-91b9-8955-5b29-b5ba4e656526@gmail.com>
 <20190409182039.GB256045@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <69d40db5-9ce7-3444-76d1-52652b3fadc6@gmail.com>
Date:   Tue, 9 Apr 2019 20:27:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409182039.GB256045@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09.04.2019 20:20, Bjorn Helgaas wrote:
> On Tue, Apr 09, 2019 at 07:32:15PM +0200, Heiner Kallweit wrote:
>> On 05.04.2019 21:28, Heiner Kallweit wrote:
>>> On 05.04.2019 21:10, Bjorn Helgaas wrote:
>>>> On Wed, Apr 03, 2019 at 07:45:29PM +0200, Heiner Kallweit wrote:
>>>>> On 03.04.2019 15:14, Bjorn Helgaas wrote:
>>>>>> On Wed, Apr 03, 2019 at 07:53:40AM +0200, Heiner Kallweit wrote:
>>>>>>> On 02.04.2019 23:57, Bjorn Helgaas wrote:
>>>>>>>> On Tue, Apr 02, 2019 at 10:41:20PM +0200, Heiner Kallweit wrote:
>>>>>>>>> On 02.04.2019 22:16, Florian Fainelli wrote:
>>>>>>>>>> On 4/2/19 12:55 PM, Heiner Kallweit wrote:
>>>>>>>>>>> There are numerous reports about different problems caused by
>>>>>>>>>>> ASPM incompatibilities between certain network chip versions
>>>>>>>>>>> and board chipsets. On the other hand on (especially mobile)
>>>>>>>>>>> systems where ASPM works properly it can significantly
>>>>>>>>>>> contribute to power-saving and increased battery runtime.
>>>>>>>>>>> One problem so far to make ASPM configurable was to find an
>>>>>>>>>>> acceptable way of configuration (e.g. module parameters are
>>>>>>>>>>> discouraged for that purpose).
>>>>
>>>>>>>>>>> +Certain combinations of network chip versions and board
>>>>>>>>>>> +chipsets result in increased packet latency, PCIe errors, or
>>>>>>>>>>> +significantly reduced network performance. Therefore ASPM is
>>>>>>>>>>> +off by default. On the other hand ASPM can significantly
>>>>>>>>>>> +contribute to power-saving and thus increased battery runtime
>>>>>>>>>>> +on notebooks.
>>>>
>>>>>> That said, I think Frederick has already started working on a plan
>>>>>> for the PCI core to expose sysfs files to manage ASPM.  This is
>>>>>> similar to the link_state files enabled by CONFIG_PCIEASPM_DEBUG,
>>>>>> but it will be always enabled and probably structured slightly
>>>>>> differently.  The idea is that this would be generic and would not
>>>>>> require any driver support.
>>>>
>>>>> Frederick, is there anything you could share already? Or any timeline?
>>>>> Based on Bjorns info what seems to be best to me:
>>>>> 1. Disable ASPM for r8169 on stable (back to 4.19).
>>>>> 2. Once the generic ASPM sysfs attributes are available, reenable ASPM
>>>>>    for r8169 in net-next.
>>>>
>>>> This is out of my wheelhouse, but even with a generic sysfs knob, it
>>>> doesn't sound like a good idea to me to enable ASPM by default for
>>>> r8169 if we think it's unreliable on any significant fraction of
>>>> machines.
>>>>
>>> I was a little bit imprecise. With the second statement I wanted to say:
>>> Keep ASPM disabled per default, but make it possible that setting the
>>> new sysfs attribute enables ASPM. After digging deeper in the ASPM core
>>> code it seems however that we don't even have to touch the driver later.
>>
>> ASPM has been disabled again for r8169: b75bb8a5b755 ("r8169: disable ASPM
>> again"). So, coming back to controlling ASPM via sysfs:
>> My first thought would be to extend pci_disable_link_state with support
>> for disabling L1.1/L1.2, and then basically expose pci_disable_link_state
>> via sysfs (attribute reading being handled with a direct read from
>> pcie_link_state->aspm_disable).
>>
>> Is this what you were planning or do you have some other approach in mind?
> 
> I can't remember the details of what Frederick and I talked about, but
> I think that's the general approach.
> 
Thanks, good to hear. Then let's see whether Frederick wants to add something,
and based on the feedback I'd set working on this feature on my agenda.

> Bjorn
> 
Heiner
