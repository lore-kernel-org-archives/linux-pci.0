Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FCBC4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 17:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656B206DF
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 17:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRi9+Oeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDCRpj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:45:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42359 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCRpj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 13:45:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so22575061wrx.9;
        Wed, 03 Apr 2019 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ASBaQce5m6AuYGoEb0Us5O7ZWrd+DRD4Qy7hrVciAP0=;
        b=tRi9+Oegu2N5yyzc2Wla/xPbQv9WeDeJOlI/N5kQp94bu7LTfQas23+4DBKWuBpxcW
         5oumr2nopBuM/aRXH0IrPk6ZUcrh+tf4TXjYr1FaKwrj0lxdUO1c+j7tgZq9MigPQ55p
         UmUCyz7FAEFLlJhz2Zt7dEGstJN6GAEHjarUTMAnZKBrA2u7Ukb9Cp9Q7fkwmufqLvDs
         B/qfcZ6QKmtDW5lmKD/AX3JSRiCyoAk7CdRko0i8eWjhlir4cTI7NA718/7qSZNIaR7j
         Qo4o053QY5y/HEW+GbbtqtWkMBDcH1buZny6DbluUDeCK9T0vRvclN2xAKNGfKvlsH4K
         F8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ASBaQce5m6AuYGoEb0Us5O7ZWrd+DRD4Qy7hrVciAP0=;
        b=Uy9YMuBmpoQpysuyIFluROHPfjNLOeABMORELSpUPEMzaKd0WBgG4LmaZW0eiQl2LT
         jU1Cr2D+aG/v9QZOZoFD1FlaTO/UltyO6IwVLuMzCg5DmpMpq0k5Tn0ihUEZN7P+J4dU
         z3jA5WYYb4RWwiMAXCaRd4aGIv+iDNvxPKwnoMOKylSt/VmJ1M04UZyb68CUQHbs7F9Y
         8kDJ/AYxOP+CUa97oHPJGlSkpU6iP8hYTQNRTIuvCvAl6vvhvRxC/s3+hWFGeTVaIvQ8
         Rr3/hDO8v17oSvAwgHNinfzurl1HUdouwECijDwQ2HyAI8jJfSJb3uUL5O4YeMMaqrtn
         NuAw==
X-Gm-Message-State: APjAAAXk8eG2MYSNX7pzhPmMqABc7U8QV5Bgc1BZBwMyU2yXHp0m+KWL
        j5nFKt/JwNRGAjXCdiCttEw=
X-Google-Smtp-Source: APXvYqzRoganwZB2Hscd29KmRNWF5sdG+XICEHbMrej1Rb0Q9LaI6QT18xRak/d5DyEtt7qRiZ6bkQ==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr564753wrm.233.1554313536729;
        Wed, 03 Apr 2019 10:45:36 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be1:dd00:ed2b:516:5ae8:487f? (p200300EA8BE1DD00ED2B05165AE8487F.dip0.t-ipconnect.de. [2003:ea:8be1:dd00:ed2b:516:5ae8:487f])
        by smtp.googlemail.com with ESMTPSA id v14sm18979629wrr.20.2019.04.03.10.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:45:36 -0700 (PDT)
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <b8787012-0928-e613-bbf6-4de3e462f055@gmail.com>
Date:   Wed, 3 Apr 2019 19:45:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403131446.GH141706@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03.04.2019 15:14, Bjorn Helgaas wrote:
> [+cc Frederick]
> 
> On Wed, Apr 03, 2019 at 07:53:40AM +0200, Heiner Kallweit wrote:
>> On 02.04.2019 23:57, Bjorn Helgaas wrote:
>>> On Tue, Apr 02, 2019 at 10:41:20PM +0200, Heiner Kallweit wrote:
>>>> On 02.04.2019 22:16, Florian Fainelli wrote:
>>>>> On 4/2/19 12:55 PM, Heiner Kallweit wrote:
>>>>>> There are numerous reports about different problems caused by ASPM
>>>>>> incompatibilities between certain network chip versions and board
>>>>>> chipsets. On the other hand on (especially mobile) systems where ASPM
>>>>>> works properly it can significantly contribute to power-saving and
>>>>>> increased battery runtime.
>>>>>> One problem so far to make ASPM configurable was to find an acceptable
>>>>>> way of configuration (e.g. module parameters are discouraged for that
>>>>>> purpose).
>>>>>>
>>>>>> As a new attempt let's switch off ASPM per default and make it
>>>>>> configurable by a sysfs attribute. The attribute is documented in
>>>>>> new file Documentation/networking/device_drivers/realtek/r8169.txt.
>>>
>>> Both module parameters and sysfs attributes are a poor user
>>> experience.  It's very difficult for users to figure out that
>>> a tweak is needed.
>>>
>>>>> I am not sure this is where it should be solved, there is
>>>>> definitively a device specific aspect to properly supporting the
>>>>> enabling of ASPM L0s, L1s etc, but the actual sysfs knobs should
>>>>> belong to the pci_device itself, since this is something that
>>>>> likely other drivers would want to be able to expose. You would
>>>>> probably want to work with the PCI maintainers to come up with a
>>>>> standard solution that applies beyond just r8169 since presumably
>>>>> there must be a gazillion of devices with the same issues.
>>>
>>> The Linux PCI core support for ASPM is poor.  Without more details,
>>> it's impossible to tell whether these issues are hardware or firmware
>>> defects on the device itself, or something that Linux is doing wrong.
>>> There are several known defects, especially related to L1 substates
>>> and hotplug.
>>>
>> The vendor refuses to release datasheets or errata. Only certain
>> combinations of board chipsets (and maybe BIOS versions) and network
>> chip versions (from the ~ 50 supported by the driver) seem to be
>> affected. One typical symptom is missed RX packets, maybe the RX FIFO
>> isn't big enough to buffer all packets until PCIe has woken up.
>> The Windows vendor driver uses a hack, they dynamically disable ASPM
>> under load.
> 
> I'm not super sympathetic to vendors like that or to OEMs that work
> with them.  If we can make the NIC work reliably by disabling ASPM,
> that's step one.  If we can figure out how to extend battery life by
> enabling ASPM in some cases, great, but we have to be careful to do it
> in a way that is supportable and doesn't generate lots of user
> complaints that require debugging.
> 
> That said, I think Frederick has already started working on a plan for
> the PCI core to expose sysfs files to manage ASPM.  This is similar to
> the link_state files enabled by CONFIG_PCIEASPM_DEBUG, but it will be
> always enabled and probably structured slightly differently.  The idea
> is that this would be generic and would not require any driver
> support.
> 
Thanks, Bjorn!
Frederick, is there anything you could share already? Or any timeline?
Based on Bjorns info what seems to be best to me:
1. Disable ASPM for r8169 on stable (back to 4.19).
2. Once the generic ASPM sysfs attributes are available, reenable ASPM
   for r8169 in net-next.

> Bjorn
> 
Heiner
