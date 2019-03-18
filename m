Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E0C10F00
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA321741
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 08:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCRIUk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:20:40 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34025 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRIUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 04:20:40 -0400
Received: by mail-vs1-f68.google.com with SMTP id e126so8703257vse.1;
        Mon, 18 Mar 2019 01:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlHVI5FfEgn5ZvejHyEKOKyXpuCIPhO0e8g2ZVtqZ0I=;
        b=ptzWTQUO9jfTRyNTcm9+7hrgP3Y+DaH7vD77G2VGO+Ru8AVd21tgxh9E0Ob2JP5re6
         9XiK1uDQfQYoHVhA0iVI1jotZHr3+GaysZd+wAm4X4YWe/OExZK89cmjSuZqJ568is/v
         6LSgnpOqy3jJgsTH3ywv7+iJ1UleSw/hQtEoNTeWgGQ1pD+BDU7Mh0Szx9LWXhUDsyK9
         e/S60D9nW1gT6fMsjaZItXZ+jdpuYgtN1u/E57gZFxK3ri3x/AwVZHsVN7o0+FCWne3l
         V8HktrTzpNCHp6M50zCpnmeNcyI0sV6aPVCdPMrolcVvaJJGSypwDBTequ+nvW7UlRBd
         81Gw==
X-Gm-Message-State: APjAAAUy/Hdbd1YhkrcTPWmlrKh3jKO8wKqeYfoEpWxpXRZWeYMcUB6D
        Y7I7s6vv4HGciP3/xIcq6vY4GwptN8/kKarQXiU=
X-Google-Smtp-Source: APXvYqyywp4MZ0to8ZmsKOg8dA9uCPpg7Q85tAPoNNbM1oQRX3h65bSAX+pKbadLQCheXM/cn+lE3guCw5+PUu6y/Sw=
X-Received: by 2002:a67:8317:: with SMTP id f23mr4679472vsd.63.1552897239582;
 Mon, 18 Mar 2019 01:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190317000608.24881-1-marek.vasut@gmail.com> <20190317000608.24881-3-marek.vasut@gmail.com>
In-Reply-To: <20190317000608.24881-3-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Mar 2019 09:20:27 +0100
Message-ID: <CAMuHMdXTz3408iNbdO8uCvSCVP5Jc6KuWkKVSVxED3pqRRtBrA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: rcar: Clean up debug messages
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 17, 2019 at 1:06 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Drop useless casts from debug messages, they are no longer needed
> due to the data type cleanup.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
