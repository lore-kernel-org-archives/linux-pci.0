Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEC7C43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4C32085A
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxmTJFyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfAGSyb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54299 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfAGSyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 13:54:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so1849351wmh.4;
        Mon, 07 Jan 2019 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vxaVvuf0ku/yxN/NgNoKd4H1od+DFvVxieOGvucwD78=;
        b=bxmTJFyjb60GSs7W6Y9H1bRae4gjb8PYVIeZ1eTzlyUQJtcjanfPT6OzhrjNRQCdpL
         XPIfWOp3nfLeQIYsr264Ep/gZU77REKyhCWP3ifkuFJnK/1iLk0DLtMYw4fVEz/rSRuS
         s/slqEgwRsgmC7AneoTaOLKFtJZ2R6pTc+aw5J9w9DnaHVLwk2Q410+IVkaaTQ2hNagz
         BstAQ7co/uVDH/F3uhFjCrtWPSbzs55ZiuMO2ky4tqAi3MKsBGW0UkwpCT/ra4xqAUCi
         2wpHUzzC6jzkdo3o4ojIn3u5ky+2C6LfT1pr9YEyb3Xji6TXKXizuOljjrm741MJgxSA
         dIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vxaVvuf0ku/yxN/NgNoKd4H1od+DFvVxieOGvucwD78=;
        b=UkZ54Qw0+SYsZ5Ualz9vc1434HIil56U7qQHiFcRTb6Gepk7aQHPIGt69ZUYSdhPIW
         +pi0GhgCxLIzyllnsbvdiSMONcheimEA0HwzfV71xgbq/z0OgvDdhIUIonl8kK9DYKB+
         EOx0G8L4hHhW5VdHMU2isylmkvpGe4VndRkEwwVOkNkGF+/s8uniSPNQzbRShvakic3r
         IYa7s4guI3l7iKtrjhaOFvPNCPWJDSEYh7Uu7zofOCSgoukA2Jy6liGGLj2zkxM/3C2l
         yl3Zwr5JhJdcF4dC1SV299th1XVOILOHHUzCyFQJOWnpDLjKlA5SnOvjtrqXeL0Ul2O7
         ANDA==
X-Gm-Message-State: AJcUukcUX07ldO/DOystV8q6XKZsTNrpKYT8BoOSoUXkXO6lK7SePEFm
        4hSOOKC01YwOUNd9VLUfBNS7fk2s
X-Google-Smtp-Source: ALg8bN7wn9T3OqYqTRKVUBVsQzFKoXHozghMzIFvcu/Dn8lTEMMxXTw1yiIEuWw7Vnw4E53R1Hy/gw==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr9157154wmj.138.1546887268850;
        Mon, 07 Jan 2019 10:54:28 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:6944:e497:2993:7f74? (p200300EA8BE2E4006944E49729937F74.dip0.t-ipconnect.de. [2003:ea:8be2:e400:6944:e497:2993:7f74])
        by smtp.googlemail.com with ESMTPSA id r77sm9516440wmd.22.2019.01.07.10.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:28 -0800 (PST)
Subject: Re: [PATCH 0/2] PCI: Fix runtime PME generation from D3hot
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>, Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190107143959.75267-1-mika.westerberg@linux.intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <72961010-c82a-7d2c-5e43-2c3bb301b3d2@gmail.com>
Date:   Mon, 7 Jan 2019 19:54:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107143959.75267-1-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07.01.2019 15:39, Mika Westerberg wrote:
> Hi all,
> 
> Heiner reported [1] that runtime PME generation of his network card does
> not work after commit 0e157e528604 ("PCI/PME: Implement runtime PM
> callbacks") that landed in v4.20. Reverting the commit helps but it has
> another drawback, which I originally tried to solve with the commit, that
> the PCIe hierarchy wakes up immediately after being put into D3cold.
> 
> This series of two patches tries to fix both issues so that PME wakes up
> from D3hot and that the hierarchy does not wake up immediately from D3cold.
> 
> [1] https://www.spinics.net/lists/linux-pci/msg79051.html
> 
> Mika Westerberg (2):
>   Revert "PCI/PME: Implement runtime PM callbacks"
>   PCI: pciehp: Disable Data Link Layer State Changed event on suspend
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 10 ++++++++--
>  drivers/pci/pcie/pme.c           | 27 ---------------------------
>  2 files changed, 8 insertions(+), 29 deletions(-)
> 
Works for me. But that's not a miracle because on my system
CONFIG_HOTPLUG_PCI isn't set and therefore effectively just the
runtime ops are removed again. And we tested before that this
fixes the issue for me. Thanks for the analysis and the fix!

So for the runtime PM PME generation:
Tested-by: Heiner Kallweit <hkallweit1@gmail.com>
