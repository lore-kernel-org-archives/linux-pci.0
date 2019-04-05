Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DDAC282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 19:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF19A2146F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 19:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4gy7m8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfDET2c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:28:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43670 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731563AbfDET2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Apr 2019 15:28:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so9245493wrx.10;
        Fri, 05 Apr 2019 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O48k79zOkOKozGFluaB7cUiPTRJ4uIVmP+LrxtIow3I=;
        b=M4gy7m8G8NSoye0RSk2lrY3R8lbt9/UcIfqLoC8R4wpmXOkvEbOko/Eu1sLVWK8Rhz
         fXTV0JcIRaQ4MFWWyPh2MAgMhEsjR2JGs2WK6dLmmDSM7aQRL8OXZngBlqieZ170kA1D
         +rNxWI7lgeancA1PB07g0iha0dflPaTpkY8J01//VV1SeEAIDcLsXKTDk1GN/L1oJRPE
         p/6o7kSK6ePn+dkkCFQM+T70irCk3IJgWRe6P2St8BEUwICwqxsJpN3LLZNEL0fa6gVC
         xNEqGLIcH8A/An9q8rNvXAEEHPLFFXYedAuS00CSzUYa7yEdwAv+AOUawZ1dlbyWqpnx
         RXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O48k79zOkOKozGFluaB7cUiPTRJ4uIVmP+LrxtIow3I=;
        b=GRf//be8gEnGtfKzsgrU9r6IOt3cxUmGc6qU33osKCVbPEz8JAxzvRKwDttqD4DCs7
         n0Qi7hPnuOm8iLhwNp0P0djYr2Nts59ZljnIGFwxou1xtzD0Z6EIYMJxLm1e1XXgVEUm
         20Lrg/WtwMaehnZ10opd9DwxHCz7zwjpXw6savaHbeXkql0kJjLXSleTsmPaipn6rtEw
         0DLIST+VD6yEgHzZ6Hp4J1AqrRxBITDqAdMZ3yW9xOSc570X9pKmuTmaQdZEHuBGsBaV
         /OGs4zPGN5LefwQeRqfuYFRnFMiQoeKn+45rmjkHUSxfwbSFNr2m+bwzq4HpF9TVqwWt
         yHNg==
X-Gm-Message-State: APjAAAUc7N2wHYskIXqySGVb3uv8+XUcdKXjKwON4Ygpi1cE3bWEas34
        q2MkB5HDWgz8p+1uxyJm3Bo=
X-Google-Smtp-Source: APXvYqyDW1u0Z4GnzVCyVve8tAwcOYgb5VBoERCqNrNQLMKRFRsEDVpokmwjpVamm2OVRbiiu3Dehg==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr10061720wrj.16.1554492510019;
        Fri, 05 Apr 2019 12:28:30 -0700 (PDT)
Received: from ?IPv6:2003:ea:8be1:dd00:c5f4:1013:b1cb:d123? (p200300EA8BE1DD00C5F41013B1CBD123.dip0.t-ipconnect.de. [2003:ea:8be1:dd00:c5f4:1013:b1cb:d123])
        by smtp.googlemail.com with ESMTPSA id c10sm25660151wrt.65.2019.04.05.12.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 12:28:29 -0700 (PDT)
Subject: Re: [PATCH net] r8169: switch off ASPM by default and add sysfs
 attribute to control ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>,
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
 <20190405191024.GD26522@google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <58f445a2-1eb3-7759-62d6-efacd87d52b6@gmail.com>
Date:   Fri, 5 Apr 2019 21:28:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405191024.GD26522@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05.04.2019 21:10, Bjorn Helgaas wrote:
> On Wed, Apr 03, 2019 at 07:45:29PM +0200, Heiner Kallweit wrote:
>> On 03.04.2019 15:14, Bjorn Helgaas wrote:
>>> On Wed, Apr 03, 2019 at 07:53:40AM +0200, Heiner Kallweit wrote:
>>>> On 02.04.2019 23:57, Bjorn Helgaas wrote:
>>>>> On Tue, Apr 02, 2019 at 10:41:20PM +0200, Heiner Kallweit wrote:
>>>>>> On 02.04.2019 22:16, Florian Fainelli wrote:
>>>>>>> On 4/2/19 12:55 PM, Heiner Kallweit wrote:
>>>>>>>> There are numerous reports about different problems caused by
>>>>>>>> ASPM incompatibilities between certain network chip versions
>>>>>>>> and board chipsets. On the other hand on (especially mobile)
>>>>>>>> systems where ASPM works properly it can significantly
>>>>>>>> contribute to power-saving and increased battery runtime.
>>>>>>>> One problem so far to make ASPM configurable was to find an
>>>>>>>> acceptable way of configuration (e.g. module parameters are
>>>>>>>> discouraged for that purpose).
> 
>>>>>>>> +Certain combinations of network chip versions and board
>>>>>>>> +chipsets result in increased packet latency, PCIe errors, or
>>>>>>>> +significantly reduced network performance. Therefore ASPM is
>>>>>>>> +off by default. On the other hand ASPM can significantly
>>>>>>>> +contribute to power-saving and thus increased battery runtime
>>>>>>>> +on notebooks.
> 
>>> That said, I think Frederick has already started working on a plan
>>> for the PCI core to expose sysfs files to manage ASPM.  This is
>>> similar to the link_state files enabled by CONFIG_PCIEASPM_DEBUG,
>>> but it will be always enabled and probably structured slightly
>>> differently.  The idea is that this would be generic and would not
>>> require any driver support.
> 
>> Frederick, is there anything you could share already? Or any timeline?
>> Based on Bjorns info what seems to be best to me:
>> 1. Disable ASPM for r8169 on stable (back to 4.19).
>> 2. Once the generic ASPM sysfs attributes are available, reenable ASPM
>>    for r8169 in net-next.
> 
> This is out of my wheelhouse, but even with a generic sysfs knob, it
> doesn't sound like a good idea to me to enable ASPM by default for
> r8169 if we think it's unreliable on any significant fraction of
> machines.
> 
I was a little bit imprecise. With the second statement I wanted to say:
Keep ASPM disabled per default, but make it possible that setting the
new sysfs attribute enables ASPM. After digging deeper in the ASPM core
code it seems however that we don't even have to touch the driver later.

> Users of those unreliable machines will see poor performance, PCIe
> errors, etc, and they won't have a clue about how to fix them.
> 
> To me it sounds better to leave ASPM disabled by default for r8169,
> then incrementally whitelist systems that are known to work.  Users
> will have poor battery life, but at least things will work reliably.
> 
> Bjorn
> 
Heiner
