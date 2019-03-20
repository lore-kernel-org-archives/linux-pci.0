Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB17AC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F1921850
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 13:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxQ/vaff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfCTNsh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:48:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35299 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCTNsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2019 09:48:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so1841814oib.2;
        Wed, 20 Mar 2019 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cA1zRjifYYUZsslLpFV4lvRCNma1Rgg78zIhKwqsCl0=;
        b=UxQ/vaffwC5Q1convGfI8bS0PfpQkgji1oTTjYBBDrAgQwK7lqnjMv7YiwMGmyYXAW
         3x+uUxIG5r+/DL2Rpae4H/vnXHE2xbS4NDwWQGxswCurLtJRbNKkIwBGpMvpP6gBVS2F
         fRtLNAdwnwTw2ZAChKj6GeQzLfUwoX7damRfPbqRAYF6U8amufk51WyOwdHQOrzC0owF
         C40JYd2hYFS4KYM67JrGOLLrrfCgClCDsf/dve3aMy+0WnPCULsF6SmVdY8d7otn3Ltt
         OqZYff1sv/tCSNzNbmmPSIegviNfYK3P7sQMEQAEq56hTmVRXuRR0NLp/7eksYmzQqjt
         CX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cA1zRjifYYUZsslLpFV4lvRCNma1Rgg78zIhKwqsCl0=;
        b=Uwgvef6hSBcJPeXbL2XGKUBHLA1m2xXnq/+vabIeKBZZWYHGSuwYFbbQiV3cnqu5qA
         fM0/SkPYp7hbS5tO5GWxYmdS0fDSqUhvmFHpJiJP/EgwulHOzzCSK5dHV35K5LaJ3/sH
         Q7eqJJ5XRO44i6N5vac98mA9T/sJnMeSSUMpMqi159G/SWw4CVBIKJf6g0BRTH6RZSIe
         uM2apPmxDyn7BERhe0vZKrOBEFNKVwUjeMp9NbcD2omGA0A/RttQH0BVbxK9CV5AsEqO
         Xlv3ezk7ePAbDIwLG7GcduyNv8TgihGly8Zpmg0/ZsFtO+K7ZiAwLOnX93s4dcsqi2ni
         LJ3g==
X-Gm-Message-State: APjAAAUlyoOQ1T24ER1ZaIOKwbpXh/tSBRx0HjQU8N2UtdFQle6cYj1P
        IYjBE0wWKBxTedxAHOS4TmxdrKbzcho=
X-Google-Smtp-Source: APXvYqyhsu9b9rVaSIq2NvkynRJctGeEu64CgRhqNDDPpGv4rdUw8Ge8WAWFEgX+gTBLHCxRvg9AGw==
X-Received: by 2002:aca:f389:: with SMTP id r131mr5009326oih.31.1553089715706;
        Wed, 20 Mar 2019 06:48:35 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id r124sm740921oih.7.2019.03.20.06.48.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 06:48:34 -0700 (PDT)
Subject: Re: [PATCH] PCI/LINK: bw_notification: Do not leave interrupt handler
 NULL
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
 <20190319011214.7847-1-mr.nuke.me@gmail.com>
 <20190320134632.GA251185@google.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <dc22ee5c-5c63-a28d-c709-986287bb4a7e@gmail.com>
Date:   Wed, 20 Mar 2019 08:48:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190320134632.GA251185@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/20/19 8:46 AM, Bjorn Helgaas wrote:
> Hi Alexandru,
> 
> On Mon, Mar 18, 2019 at 08:12:04PM -0500, Alexandru Gagniuc wrote:
>> A threaded IRQ with a NULL handler does not work with level-triggered
>> interrupts. request_threaded_irq() will return an error:
>>
>>    genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
>>    pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22
>>
>> For level interrupts we need to silence the interrupt before exiting
>> the IRQ handler, so just clear the PCI_EXP_LNKSTA_LBMS bit there.
>>
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> What's your thought regarding Lukas' comment?  If you do repost this,
> please add a Fixes: tag to help connect this with the initial commit.

I like Lukas's idea. I should have this re-posted by end of week, unless 
there's an urgency to get it out earlier.

Alex
