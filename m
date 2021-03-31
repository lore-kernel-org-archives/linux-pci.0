Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E675C433C1
	for <linux-pci@archiver.kernel.org>; Wed, 31 Mar 2021 11:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273886195D
	for <linux-pci@archiver.kernel.org>; Wed, 31 Mar 2021 11:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhCaLPh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbhCaLPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Mar 2021 07:15:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB83C061574
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 04:15:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z2so19258332wrl.5
        for <linux-pci@vger.kernel.org>; Wed, 31 Mar 2021 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iBM/rkVLNcgTvEmA6IdfAd7T+C/EhjJkuEclYvbMWjM=;
        b=qiHeFgu4bPnnnZgOYmeYNr48oBF9hzo0h3jECuoj7uFWDnH80FyQ6eC5Wtk1wfzW9W
         QB1u/GIfKRawi0edBIvrIDGZkFY428M07OcYkcEMaE8YibGct8V/eA5BZQSWJWJy3oNM
         tAyUcPQztNldLumEIxUdwGa+JhFkrNBhmybtgCW3dh3hi+H9agNfh0/+t8A4qymkrl95
         gWxNT9B2fjI8ic0Ad3SRmt5WRAaf6PSwRK/IfZdRpO3+QJe6fBY+h+dvBRxe8vEB0Xbi
         JsqgKntjaii/cID69ngfb3BnqXGYv0QXVI11UDfo8AlilsXJbcUGxlwxFfbCUcXPEs0S
         N6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iBM/rkVLNcgTvEmA6IdfAd7T+C/EhjJkuEclYvbMWjM=;
        b=h5XK1sUGwzfliS2EV2h9cie0mcuLOPZmXhLDiOsc+CpWoF1YyCma9/rHjz/aV3ipQJ
         ioTLl1dHj6XcJUq3FFNZYx1zUvTFudJk6tszEq6aJLyuRnyswirqhQyszWXyffiio92h
         MLmkezdbuzGXc6mIlDLtZIm+OCuToIfGL5g1zJVtO5WTq8dQvvx1fPpbnIRNdXYbxPvE
         GKf7/A0wLfE+nPUXuy9XP/iy86f8Z3Kh1JQHaKW+5h8srbzvOfUVB+HmgfzdDtWiPzkj
         oH99MTMfruAB/B6GJkV7yPjynRppMrLqjeaYKv2x5Lfky0Jm9EC8Na4vcRfcEut2nJfO
         AZmQ==
X-Gm-Message-State: AOAM5330mG91rRa+cJuJvm5BQidH6Uer7mKReusPbvgMVO5g45iK4jur
        V3dQiIjVIrobt3cTMyFa5ZYf+BZnptyQOVeP
X-Google-Smtp-Source: ABdhPJz9BJ18Skq7nNhUlU3NeN1duh/b+i1L4M9olpKywB3tM0lO/1KAXOsBr7zDZKy/sQVcDeSuYg==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr3050657wru.220.1617189303149;
        Wed, 31 Mar 2021 04:15:03 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:953:1e7:27d8:7327? (p200300ea8f1fbb00095301e727d87327.dip0.t-ipconnect.de. [2003:ea:8f1f:bb00:953:1e7:27d8:7327])
        by smtp.googlemail.com with ESMTPSA id o62sm18127890wmo.3.2021.03.31.04.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 04:15:02 -0700 (PDT)
Subject: Re: [PATCH] PCI/VPD: Silence warning if optional VPD PROM is missing
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210330195611.GA1305306@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <541f7965-b981-c277-21b5-6de0a47118ac@gmail.com>
Date:   Wed, 31 Mar 2021 13:14:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330195611.GA1305306@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30.03.2021 21:56, Bjorn Helgaas wrote:
> On Sun, Mar 07, 2021 at 10:34:25PM +0100, Heiner Kallweit wrote:
>> On 07.03.2021 19:27, Krzysztof Wilczyński wrote:
>>> Hi Heiner,
>>>
>>>> Realtek RTL8169/8168/8125 NIC families indicate VPD capability and an
>>>> optional VPD EEPROM can be connected via I2C/SPI. However I haven't
>>>> seen any card or system with such a VPD EEPROM yet. The missing EEPROM
>>>> causes the following warning whenever e.g. lscpi -vv is executed.
>>>>
>>>> invalid short VPD tag 00 at offset 01
>>>>
>>>> The warning confuses users, I think we should handle the situation more
>>>> gentle. Therefore, if first VPD byte is read as 0x00, assume a missing
>>>> optional VPD PROM as and silently set the VPD length to 0.
>>> [...]
>>>
>>> True.  I saw people on different forum and IRC asking for clarification
>>> assuming their NIC broke, or that something is wrong, so this would
>>> indeed save them some worry, nice!
>>>
>>> Having said that, I also saw this particular warning showing up for some
>>> storage controllers (often some SAS cards), so a question here: would it
>>> warrant adding a pci_dbg() with an appropriate message rather than just
>>> returning 0?  I wonder if this might be useful for someone who is trying
>>> to troubleshoot and/or debug some issues with their device.
>>>
>>> What do you think?
>>>
>> I don't have a strong opinion here, but yes, that's something we could do.
> 
> How about if we just downgrade the pci_warn() to a pci_info()?
> 
pci_info() would still expose a quite cryptic message to users and leave
them with the question whether something is wrong. If in case of VPD tag 00
a message is desired, I'd say it should be rephrased to something like:
"VPD tag 00 at offset 01, assuming missing optional VPD EPROM"
