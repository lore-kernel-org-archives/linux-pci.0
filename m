Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D5C520D3
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 22:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9482080F
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 22:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak5FriCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9482080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbeKUJHD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:07:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44286 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeKUJHD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2018 04:07:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so1648016otl.11;
        Tue, 20 Nov 2018 14:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f6e3NUzPk6E23/41NUbfQh9v7P2qiL3eVMmbh9RoicY=;
        b=Ak5FriCFZt5VJR+qtIQ8a/UiE7D4bGL08LLZqFaH+8E4ym5XI/PIjL61hYrgwqYKoO
         zQf3XM8UrtfYfpOrHI4rzLzx5Dfm41k0iNtJBPbQp2p9WN5iobXp6fTzoqRKWK91TnkP
         lYh0Ol6HpjqQCNsQAlw8o1uRexsV39ROpAhDka9OWZ5KRoKvKtFzloUuGLFmNoS2yJXb
         nrEf58pXoP6hOa2CQx3Ekz0MNOEJHO75+kCc8t27ytO96yIgu1LP9x8z/D2kf9JsMZSy
         099Iw/pup8y9HPXms1n+ZEJPoxEK03RR3msOIDqtBGk84zTlAoUE2JNY0YLi1UxUGu84
         Q6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f6e3NUzPk6E23/41NUbfQh9v7P2qiL3eVMmbh9RoicY=;
        b=V43PnWZ2lBvmHNfpghvbGv0gGLIiqxkMqsbDIyCY0GJDu91VQNvLwwq6CbVCOkoS2p
         bZQd8yIu2I0cCbb2ZxSAKCCYWbTcj10VHIQXuj70fUFrVibaU8PIEZvi3fLosSE/vmg6
         OkdrMMvo0/8HbkzejM03mlcU7+b+0c8GMnczId+3iPdyW9uf20ndt+cq6TU+04K4Nsra
         ZXLwG4DXwyz9fmSV9bbHgHud6rb7fIM1C3PtVK2NCZaizr2jJzhG16IMIOGgo5enZ4Jn
         r5I3xbXsxpLgFc6DzVs8CvsdKDmJpFSfqYfX4Yf+N70JRCYwYKbqegdqdQYZ2CvtH+Nh
         9Lrw==
X-Gm-Message-State: AA+aEWaANTos7qw5eCJ/OJG91hj9BCpgZ08uojKn77UgoGhIQInjbwX1
        J37+MgeV9is726PkfN1SHGs=
X-Google-Smtp-Source: AFSGD/UcY3SmSgFUsBhzA32ONPDix5NpCanc/tXefrFbm5RFdyI9a+c5r9DIuoEaG0J1n5Tu5bA+mg==
X-Received: by 2002:a9d:dd:: with SMTP id 29mr2413509otk.90.1542753335840;
        Tue, 20 Nov 2018 14:35:35 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id s132-v6sm155467oif.4.2018.11.20.14.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 14:35:35 -0800 (PST)
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To:     Sinan Kaya <okaya@kernel.org>, Keith Busch <keith.busch@intel.com>
Cc:     Alex_Gagniuc@Dellteam.com, baicar.tyler@gmail.com,
        Austin.Bolen@dell.com, Shyam.Iyer@dell.com, lukas@wunner.de,
        bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <20181120214243.GG26707@localhost.localdomain>
 <bace940c-70d9-6631-9818-43338d194327@kernel.org>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <ea1048ed-7e9c-4ab5-4a05-01cbddae5c19@gmail.com>
Date:   Tue, 20 Nov 2018 16:35:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bace940c-70d9-6631-9818-43338d194327@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/20/2018 04:28 PM, Sinan Kaya wrote:
> On 11/20/2018 4:42 PM, Keith Busch wrote:
>> How does that work? If the OS takes control, it sets up MSIs that FW 
>> don't
>> react to, and disables system errors through PCIe Root Control. Aren't
>> those sys errs the mechanism FW knows it has something to do, which
>> means the OS can effectively fence it off?
> 
> I think this is all implementation detail and doesn't necessarily apply
> to all firmware-first implementation flavors.
> 
> Assumptions are:
> 1. both FW and OS are listening to MSI interrupts

On hax86, I'm not sure FW can listen to MSI interrups. FW only exists in 
SMM, not ring 1-4.

> 2. FW monitors the system errors
> 
> Some FF implementation could route the AER interrupt to a higher privilege
> level. Some other implementation could use INTx or a side-band channel 
> interrupt
> for firmware-interrupt too.
> 
> I have seen all 3 except MSI :) and also firmware never monitored the 
> system
> error bits. I was curious if anybody ever used those legacy bits. Now, I 
> know
> someone is using it.
