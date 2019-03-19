Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85806C4360F
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 02:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAAA2173C
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 02:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITC3hSdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCSCIX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:08:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41792 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCSCIX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 22:08:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1so19206140wrs.8;
        Mon, 18 Mar 2019 19:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GxDi+nnEkBmFR+dwvAIZx1HmUdi9EKh99I6tfjS80f0=;
        b=ITC3hSdBdzSW5NQbuXfAs4/2sRif7mDOLI2xba8wKMWSrnSoGS9gCqOALb4+8EeCRS
         RKKq9qhvhAwbz1asjGIQH8gQSmon1Fh3nOT7stqm4jMbd/ovsNa3yGUXvmv2hVlx8r1M
         4XYo8BSkO2cte3MWDX+0Cfd5n9VZxA8GmlhOE6WDavhKTpWZGtwYSYy/h6Iipq38ZC13
         T21WEO4l9+ETegTd0X0OPzRFoevCt1USZlgkUN8pjmGOvN7Fzi1V6vO0YHYp4n3m8WTK
         oz6vhsD/qNfGyIXKGjyMHJbiRBrqUygsaIz+/iRFH0eDFIDVqTIYhFP0a8FQDQ9z20Fk
         aMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GxDi+nnEkBmFR+dwvAIZx1HmUdi9EKh99I6tfjS80f0=;
        b=LUyVzTOOzogD18LpLYnVtQvoY0rEUI5nogpT3G940QEd0VLdWYJkLLJrU1sPN79EHu
         R6tU9VbMdAI3LJ0acEHHnLP0SJWn3stBHUOYHI9fiiSYCOTcOmkUDEUszXOkhzR6SVlA
         nYsNvLVWNWMr62qakxPcVriy5iFnwwhoZdgFzt2i9kqEmYahzERiWTcm0kVCGYtC1rXH
         U1iPSQklOEzLmcW6XbEB8CWA/8N9haUkRVJMzfz5h8GqnHAAStK+MASNhacnSsc5Rh17
         pla8eBFxClNuoJS8JS7nZPlFNm1kNM125yostjxUC9leYmzAATiueMJ8Sv+ntRM8uFOV
         PaIQ==
X-Gm-Message-State: APjAAAWInD4g3KOseIixtnqD1giOnHKCEebGxRCYueTZvoWI8FRJ+bl3
        uyuS2t2DGCG7xJ7fxkeOvyw9+OAc
X-Google-Smtp-Source: APXvYqxEqdaSH15m7sIS6PO+Si/SgIjAPW3pXkgXLLZQm0JHdR5ZGJnjTz53/2n/4kJIcGK768tljQ==
X-Received: by 2002:adf:eac9:: with SMTP id o9mr3259845wrn.85.1552961301064;
        Mon, 18 Mar 2019 19:08:21 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id d9sm23516406wrn.72.2019.03.18.19.08.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:08:20 -0700 (PDT)
Subject: Re: [PATCH 2/3] PCI: rcar: Allow 64bit MSI addresses
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <20190317000608.24881-2-marek.vasut@gmail.com> <20190317091228.GB2268@kunai>
 <940fd646-0049-890a-ac00-8bc9361b2431@gmail.com>
 <CAMuHMdVXEqqRjkXR-9WPVVpNXu_C3Xg6yeZ0Nrhr1KbmHPuouw@mail.gmail.com>
 <CAMuHMdWOL33eTMOWaHmxXpZoLmvMOtrcZN6Mi0REMbJvKwp+XQ@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <22e66804-574a-ed5a-e04e-00c8a29e9dc3@gmail.com>
Date:   Tue, 19 Mar 2019 02:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWOL33eTMOWaHmxXpZoLmvMOtrcZN6Mi0REMbJvKwp+XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/18/19 10:30 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Mon, Mar 18, 2019 at 9:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Mon, Mar 18, 2019 at 12:39 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>>> On 3/17/19 10:12 AM, Wolfram Sang wrote:
>>>> On Sun, Mar 17, 2019 at 01:06:07AM +0100, marek.vasut@gmail.com wrote:
>>>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>>
>>>>> The MSI address can be 64bit. Switch the data type used to hold the
>>>>> result of virt_to_phys() to phys_addr_t to reflect it's properties
>>>>> correctly and program the top 32bits of PA into PCIEMSIAUR.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>
>>>> Looks sane. Not being a PCI expert, I wonder: Were we just lucky to not
>>>> hit a 64-bit MSI address before?
>>>
>>> I wonder about that, virt_to_phys(__get_free_pages(GFP_KERNEL, 0)) would
>>> happily return 64bit address, but with the cards I tested (a few intel
>>> NICs [igb, e1000e], PCIe NVME SSDs and xHCI HCD), I am getting the MSIs
>>> either way.
>>
>> No doubt you would be receiving the MSIs, if you have RAM at the truncated
>> address, but wouldn't that cause memory corruption?
>>
>> Fixes: 290c1fb358605402 ("PCI: rcar: Add MSI support for PCIe")
>>
>> When MSI support was added, only R-Car H1 and Gen2 were supported.
>> H1 doesn't have LPAE. Gen2 has, but it might have been disabled.
> 
> Correction: as this is always mapped kernel memory, LPAE doesn't matter.
> So the bug matters for arm64 only.

And since the address is in the 0x7_3xxx_xxxx range on H3 S-XS, there is
no visible memory corruption. Joy ...

-- 
Best regards,
Marek Vasut
