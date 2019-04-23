Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B14C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 14:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7BA21738
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 14:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ql1sS65D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfDWOd5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:33:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50656 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWOd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 10:33:56 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so508112itk.0;
        Tue, 23 Apr 2019 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3At1fI9N1eg8Et4ARVC2n3zebSL8yuqB5lEKY2h0dSk=;
        b=ql1sS65DR0KntPdZVz6uwIbO8SrThBVzgrNvMccR91gAW9Wh9zacS3KuFhHSkxNjpv
         yFyRonqcql2Yb4l+iDD9KqRsYNmH9Ug/yQSQPoEJz7BmNKSBTYCyqDZ8ZeMGJqzq7RC0
         RI6h2OdUi9Yk5r+21jMF5BoZQndbkj5jMZUUy294IdbNZYm/HMb1ToyhAbUU5TjAaMF5
         0obT1HeDVMmdKA/0XTvTLlTw7lwhl5whPUctPfPPGvm/kKYxrLTXlhcqBMg4aQqMgKEk
         2DDAZjdfYZnF7YiKGXXA1G/FoWJ8XYAKt5XLE+yMN3bik1mz+qT4vV3bhWSRsaDbDgeO
         X/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3At1fI9N1eg8Et4ARVC2n3zebSL8yuqB5lEKY2h0dSk=;
        b=GEkZoEzctwEKbTBx5HjyDYWT7abQRtTP7MlIvtzRgDADBu4R4ibfB239kyOKy3FKjn
         SDVLUhf5zZaQphQH1WME2HjUGO2ZJkF/eg0fqmzALIejnffQiW/joDMk98LJ9qu5evKK
         WZBLrS9ghf1fMMNGYOAP+qkACXxekWD9+XXlJeEcpjgGnLVpxBoy+6hN3eTz3/4XVq5U
         XysxcsL3nCfKoxnj0uXHjGqqpnMrhChhN0v/GcMFQgfNappVBliNLWES6e4qoMOzVs7U
         qUJvziEEGISGpnAIuRq3QuZxqaD75EWQVNYE30A9t1O/JKyraPOoSua7WsY1j8oJEtWw
         cpUg==
X-Gm-Message-State: APjAAAV9Yk7V4Vnch5smXc++shtHgfTynBDVPr7n0kQavoDeaPCobKn8
        0JklX12yT4ffx7TgLKhkHNVg13HaAEU=
X-Google-Smtp-Source: APXvYqwUgbHS3oYuC72vkff/txi9Q60U44fdAkw5t90f34rtlCcE6LxJoyFL3uNLtonRujktTxd1Cw==
X-Received: by 2002:a24:51:: with SMTP id 78mr2506373ita.20.1556030035724;
        Tue, 23 Apr 2019 07:33:55 -0700 (PDT)
Received: from nukespec.gtech ([2601:2c1:8501:182d::6fe])
        by smtp.gmail.com with ESMTPSA id g1sm5374656ion.2.2019.04.23.07.33.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:33:55 -0700 (PDT)
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
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <84300da7-9bbd-4f32-c7fa-23724db60b88@gmail.com>
Date:   Tue, 23 Apr 2019 09:33:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422183347.51ba522c@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/22/19 7:33 PM, Alex Williamson wrote:
> On Mon, 22 Apr 2019 19:05:57 -0500
> Alex G <mr.nuke.me@gmail.com> wrote:
>> echo 0000:07:00.0:pcie010 |
>> sudo tee /sys/bus/pci_express/drivers/pcie_bw_notification/unbind
> 
> That's a bad solution for users, this is meaningless tracking of a
> device whose driver is actively managing the link bandwidth for power
> purposes. 

0.5W savings on a 100+W GPU? I agree it's meaningless.

> There is nothing wrong happening here that needs to fill
> logs.  I thought maybe if I enabled notification of autonomous
> bandwidth changes that it might categorize these as something we could
> ignore, but it doesn't.
> How can we identify only cases where this is
> an erroneous/noteworthy situation?  Thanks,

You don't. Ethernet doesn't. USB doesn't. This logging behavior is 
consistent with every other subsystem that deals with multi-speed links. 
I realize some people are very resistant to change (and use very ancient 
kernels). I do not, however, agree that this is a sufficient argument to 
dis-unify behavior.

Alex
