Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD132C10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 17:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D18A20857
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 17:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb18YrbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDIRc1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:32:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56079 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfDIRc0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2019 13:32:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so4511532wmf.5;
        Tue, 09 Apr 2019 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X261A1nWhIMtPfAybiSRGSuKS4aNvdeB80nl9jAxAnY=;
        b=Zb18YrbDJHK9vk1ekP+skbGu0ydkx8PATx/lT+rxsoNOi8F7qrbX5RhxzsELIe48TA
         u1y++AhEi9EzkhN33BbOc2tyOjw838CGN0e9TRiJhioHwaUFm5x8r9VXrX0ydmVlG+S/
         xc8vVaPj8qGgS18g1W65MA2KyJc9TwRJU9p/kggmtfqcRd4NbldSIyVqekBoK89Mb2kB
         I87qWDAOqL3MyuhhvNEAhn9HgWKNubwxEurfhGQNLmIdWT4J7aZiaZ/xDIBS127QU8B8
         pbSJSGzTU+of7TLbbfzjkc35sPm6R9Lclmj8QIjpu8Al09cG4r1J6ocNm2PHLdmzEGEq
         mVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X261A1nWhIMtPfAybiSRGSuKS4aNvdeB80nl9jAxAnY=;
        b=dEpgFVUBbHrQBM7q9Slx0rw3UG7+l09dSjBfLUUSHECTZ1hK4FF0sZ/gODrepm5iPU
         C4xs9CITqxjNTPVVv2Q+BZ1Z2HLwqihuOfBLIQ9NXvaCuCzDy2B+Ar0R37NTJzlMcE88
         jJ0R5xuxrzh9vvfenSSzWTYyvvJoUbsnkpVwvOyI0ywtk5T4bzqDMSkMIPcaqX77S0nW
         XpU1Jhse9ECWRwdQRl/LVuV73jPojcFu0KLky71I1JPp+1umU27uOMHdhbXsojoI4mp2
         ji6BrpssE9cy8lTgITlzJs+RKtekix0cu8VyqoHtwvZS62Yq9dNEY5gN8iR3mMDykUbG
         C6hg==
X-Gm-Message-State: APjAAAVmWX6drr2CpIAi/tAes2tIqD5YB2E+Rp0qGAzJl6sY42TD+D7j
        tZmC8ickxXvV2eY5finBFWU=
X-Google-Smtp-Source: APXvYqxu/1+X/2W3hRMh9H1XxuY4FK9+ZH8xDWzoORlIm/eHu7tRnmdFSmctW/8EtC+vdcFAyKlEng==
X-Received: by 2002:a1c:2087:: with SMTP id g129mr22466420wmg.114.1554831144056;
        Tue, 09 Apr 2019 10:32:24 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bde:d800:c598:c5b:52d1:ebd6? (p200300EA8BDED800C5980C5B52D1EBD6.dip0.t-ipconnect.de. [2003:ea:8bde:d800:c598:c5b:52d1:ebd6])
        by smtp.googlemail.com with ESMTPSA id c20sm62404481wre.28.2019.04.09.10.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 10:32:22 -0700 (PDT)
Subject: Re: [PATCH net] r8169: switch off ASPM by default and add sysfs
 attribute to control ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
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
Message-ID: <2698cdee-91b9-8955-5b29-b5ba4e656526@gmail.com>
Date:   Tue, 9 Apr 2019 19:32:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <58f445a2-1eb3-7759-62d6-efacd87d52b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05.04.2019 21:28, Heiner Kallweit wrote:
> On 05.04.2019 21:10, Bjorn Helgaas wrote:
>> On Wed, Apr 03, 2019 at 07:45:29PM +0200, Heiner Kallweit wrote:
>>> On 03.04.2019 15:14, Bjorn Helgaas wrote:
>>>> On Wed, Apr 03, 2019 at 07:53:40AM +0200, Heiner Kallweit wrote:
>>>>> On 02.04.2019 23:57, Bjorn Helgaas wrote:
>>>>>> On Tue, Apr 02, 2019 at 10:41:20PM +0200, Heiner Kallweit wrote:
>>>>>>> On 02.04.2019 22:16, Florian Fainelli wrote:
>>>>>>>> On 4/2/19 12:55 PM, Heiner Kallweit wrote:
>>>>>>>>> There are numerous reports about different problems caused by
>>>>>>>>> ASPM incompatibilities between certain network chip versions
>>>>>>>>> and board chipsets. On the other hand on (especially mobile)
>>>>>>>>> systems where ASPM works properly it can significantly
>>>>>>>>> contribute to power-saving and increased battery runtime.
>>>>>>>>> One problem so far to make ASPM configurable was to find an
>>>>>>>>> acceptable way of configuration (e.g. module parameters are
>>>>>>>>> discouraged for that purpose).
>>
>>>>>>>>> +Certain combinations of network chip versions and board
>>>>>>>>> +chipsets result in increased packet latency, PCIe errors, or
>>>>>>>>> +significantly reduced network performance. Therefore ASPM is
>>>>>>>>> +off by default. On the other hand ASPM can significantly
>>>>>>>>> +contribute to power-saving and thus increased battery runtime
>>>>>>>>> +on notebooks.
>>
>>>> That said, I think Frederick has already started working on a plan
>>>> for the PCI core to expose sysfs files to manage ASPM.  This is
>>>> similar to the link_state files enabled by CONFIG_PCIEASPM_DEBUG,
>>>> but it will be always enabled and probably structured slightly
>>>> differently.  The idea is that this would be generic and would not
>>>> require any driver support.
>>
>>> Frederick, is there anything you could share already? Or any timeline?
>>> Based on Bjorns info what seems to be best to me:
>>> 1. Disable ASPM for r8169 on stable (back to 4.19).
>>> 2. Once the generic ASPM sysfs attributes are available, reenable ASPM
>>>    for r8169 in net-next.
>>
>> This is out of my wheelhouse, but even with a generic sysfs knob, it
>> doesn't sound like a good idea to me to enable ASPM by default for
>> r8169 if we think it's unreliable on any significant fraction of
>> machines.
>>
> I was a little bit imprecise. With the second statement I wanted to say:
> Keep ASPM disabled per default, but make it possible that setting the
> new sysfs attribute enables ASPM. After digging deeper in the ASPM core
> code it seems however that we don't even have to touch the driver later.
> 

ASPM has been disabled again for r8169: b75bb8a5b755 ("r8169: disable ASPM
again"). So, coming back to controlling ASPM via sysfs:
My first thought would be to extend pci_disable_link_state with support
for disabling L1.1/L1.2, and then basically expose pci_disable_link_state
via sysfs (attribute reading being handled with a direct read from
pcie_link_state->aspm_disable).

Is this what you were planning or do you have some other approach in mind?

>> Users of those unreliable machines will see poor performance, PCIe
>> errors, etc, and they won't have a clue about how to fix them.
>>
>> To me it sounds better to leave ASPM disabled by default for r8169,
>> then incrementally whitelist systems that are known to work.  Users
>> will have poor battery life, but at least things will work reliably.
>>
>> Bjorn
>>
> Heiner
> 
Heiner
