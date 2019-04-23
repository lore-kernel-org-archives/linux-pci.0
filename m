Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6ECC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5B720645
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STvDEAji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfDWQ1n (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:27:43 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:38685 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQ1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:27:43 -0400
Received: by mail-io1-f47.google.com with SMTP id y6so5427692ior.5;
        Tue, 23 Apr 2019 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EaG1bM9BbWD7P+GDCmRCRrskk/n5umqv6QafV9NwxpI=;
        b=STvDEAjiD+Evu9IbCHlaqTyuoPWXDxLLwtjzKKYfWaYyHRHSUiKQsxRAB52jI/vAhU
         hBvc++RuyPcHF9qzrXbLg91d4yVQYdpIflfokAd0RiOY6FaliYS8wcRLacPT2whlnDv7
         eMu2xQ9rCY0iDowHswM/NIOf1U+YS9MIEumIUGUyScxkdCGDCcMwnYeKg++PkiuzWQ9k
         m9AhkLkMYq36JGBxZ96OPits29i54jejDzfgh8b9FHgViXVRf6+wUXzBQ41cZ0nxz8Pn
         wNdZYDw4Ri/Sf3I57TWHbC8EvU7vZBDeOm8mIk2sjQcZ5gvkQNyctdXva9cMAmK2XAgj
         PB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EaG1bM9BbWD7P+GDCmRCRrskk/n5umqv6QafV9NwxpI=;
        b=r6XaKo1mpnEcFUOB2a+BpsXKeqn6dZ1531YTca3gGg28w9nigawYXJ0fPw8ocfaz6N
         0YYWBL9sCOJuiJOJUNDBKyJx1DO0RMiyNif7G2+JNfGJJs5ipIq3rpDOW2NRsF8e+TTx
         GfNX7Nda4UYpyKeGPoIm6lXu0WQkDOjl2HCBKvBx1GnOSSaZcgQcMIkQYQP5xp3gzlFv
         +giV9N5xhQFI5LT+hdAUytH59HejVU1FdRPIYkgHDgPm/lFbTUgsqlgKufUlTyVIUmU7
         /tPU/OjNx94AC5MudTY+O4UTdv9XuJ2xL2X28kUdhWJ7dQ8URxSECqGrBu0S2kYRrW6w
         x19w==
X-Gm-Message-State: APjAAAUcMOoUL8CQJ5rYvwF8ULGa2Zg3oCnWgmSZ7XVIVpryjE2LxxS4
        NXzVu3so1rpEhJId5fOLkdheLmoBK1w=
X-Google-Smtp-Source: APXvYqzs/j+Ugv0Py3lZIhL2qTVA0BMKLsWHtyc+FXMvGTfnkIC3aiZZxPScpEmEvzQGdvmTCwEBbQ==
X-Received: by 2002:a6b:5c0a:: with SMTP id z10mr1693112ioh.138.1556036862045;
        Tue, 23 Apr 2019 09:27:42 -0700 (PDT)
Received: from nukespec.gtech ([2601:2c1:8501:182d::6fe])
        by smtp.gmail.com with ESMTPSA id t78sm7450604itb.39.2019.04.23.09.27.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:27:41 -0700 (PDT)
Subject: Re: [PATCH] PCI/LINK: Account for BW notification in vector
 calculation
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <155597243666.19387.1205950870601742062.stgit@gimli.home>
 <d1126250-14e0-192c-f219-f143f62c9cdd@gmail.com>
 <20190422183347.51ba522c@x1.home>
 <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
 <20190423093408.16b07efc@x1.home>
 <88bd2962-bce4-8259-c38f-1a7e9fdde300@gmail.com>
 <20190423102253.4fd9a019@x1.home>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <e992aad4-a80d-53e1-deb7-8e4523b5027c@gmail.com>
Date:   Tue, 23 Apr 2019 11:27:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423102253.4fd9a019@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/23/19 11:22 AM, Alex Williamson wrote:
> Nor should pci-core decide what link speed changes are intended or
> errors.  Minimally we should be enabling drivers to receive this
> feedback.  Thanks,

Not errors. pci core reports that a link speed change event has occured. 
Period.

Alex
