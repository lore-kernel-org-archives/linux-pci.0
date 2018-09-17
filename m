Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580C1ECE563
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 05:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111B7214C2
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 05:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9z/hcEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111B7214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeIQLYx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:24:53 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:38702 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeIQLYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 07:24:53 -0400
Received: by mail-qt0-f180.google.com with SMTP id x7-v6so14246284qtk.5;
        Sun, 16 Sep 2018 22:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7WJ+hqzFQ96/YP53IiVcSS6j0tAZZ8UWPTJapmfUqIs=;
        b=Y9z/hcEn93930Kkbg13GbyKto0B5heyHexWe9ygfeYTSTHPL/nGb5K7/tlpdW/3doB
         Re8Zf8qgnJR2qc7t145EEnMBgSGP4cd6XHFo3MC9wufMGKSW5+mwunjHK6waDW7prcKG
         e98YtytcQT4KHpYnZYFwR8yoe+NmiBInI8YLGLGlUD8U914gRJ8cl5RwtcnARcu8/+RI
         f57PSQ0i+Mv76zNQ1KtKK+D/nZdCNcdyqeEPmq0uxvy7Cpp7l3L1qiqGXKwsNfhP6pQK
         pmlCiPKrxTaEf0WqdXDuqJ1BjHtAHwVlwne+KaKLnIjUlworq7z7K0mwkriK5HtPOiY0
         RKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7WJ+hqzFQ96/YP53IiVcSS6j0tAZZ8UWPTJapmfUqIs=;
        b=XC4KXLhNu0fGn0+LmVP9FtBjD5T5iH3F2iXAyDqR3wMUUp9xkl+uJUW7T0akwByAxj
         LuHWoQX8lKRCsnXatREmssW2XoA1D2vjqn4EobGeBmnI9XVJCA0l1GqZVhuM3HvdGpaK
         /MTDh4LaY+8DxVBMRCL9xHH+/Y5yCPFmgKry6P66WrNYKI3oRrBb3BuzuFRNDzO5omiU
         0H/FH3ffvAW25392voTHZR/zC5EQJgBfiwHd1RS55oyYRcocmnSZ/qqK0PX/Oyd3Y6e6
         CN6KWnQYcyczogVNCkXnObkKqJi/MZ/mRffVjfrCYpTlwPLr1XtxvgLXz9efTQHY/3Kr
         Ow4A==
X-Gm-Message-State: APzg51D0w9fyAfm/lLryaQljP0d/JcTBE6hSWwProqj1c72AYcPNQMuC
        6N9SflgWIo815YxLay3RGK2jf5vnsiqhVzEHWw==
X-Google-Smtp-Source: ANB0VdbRxNDEytr3nnEEOl9v99PFLsCIOINHkujqV3TpS1UhdgdsQI291zV8ZvwdNhezg2Vf+33gnLoVR7B+4PRLZsU=
X-Received: by 2002:aed:22cc:: with SMTP id q12-v6mr16584943qtc.145.1537163942063;
 Sun, 16 Sep 2018 22:59:02 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Anemone <peter.anemone@gmail.com>
Date:   Mon, 17 Sep 2018 08:58:50 +0300
Message-ID:
 <CAFtaAxE8G15vU40jCKzqzuwpt_-bDfVpWuaeuy6cQ-sh=Ap2XQ@mail.gmail.com>
Subject: [REGRESSION][BISECTED] Boot stall related to drivers/pci/hotplug/acpiphp_glue.c
To:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917055850.nMQfBOgUlzFMPSW2AmiIj6N07xm_Sl2yHj5hKJ8MUd0@z>

Dear kernel developers
I reported a bug at Bugzilla, but Greg Kroah-Hartman pointed me in
mailing lists. Here's my bug report:

Linux has been unbootable for me from 4.18 upwards. Even the fallback
image does not boot. This has not been fixed yet in 4.19-rc3. acpi=off
kernel parameter lets me boot 4.18.6 and 4.19-rc3.

I used git bisect to track down the first bad commit:
84c8b58ed3addf17d3beb2e5037b001ffa65c5ef

The commit is about:
"ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84c8b58ed3addf17d3beb2e5037b001ffa65c5ef

Linux 4.17 booted fine. Reverting commit
84c8b58ed3addf17d3beb2e5037b001ffa65c5ef makes 4.18 and 4.19-rc3
bootable again (without the acpi=off parameter).

Information about my system:
Model: HP 6730b laptop
CPU: Intel Core 2 Duo P8600
Boot manager: systemd-boot (UEFI)
More information of my system as attachments on the bug report at Bugzilla.

Link to the bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=201127

Thanks for all the good work!
-Peter
