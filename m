Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA9C10F0C
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659692147C
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfCKJdH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:33:07 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35627 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfCKJdG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2019 05:33:06 -0400
Received: by mail-vs1-f66.google.com with SMTP id e81so2265621vsd.2;
        Mon, 11 Mar 2019 02:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czbqtuyWrbsk1OCsTd/wUvFudhRF24RM00TjeGqv93M=;
        b=P1QiA0GbR37fcwy4us3GS45JdfGl18EMKWOGSBf6k2NtpPkqTmscYv5FqLNUKcjZhB
         8oWrKOkl1t7GnpArbFnNlaoD0LVPuy6X65ApqvY1s72RRwUh3Iq7D753GY/B0QEpBCOy
         OrDOzFtueavG0KXe33GCVsRZxaaV/0w2TpIcuxDmO0CMZ4FFTRwRylEpvSJhwIyc854g
         FpFmsALAi004YlQVwfQKcIFGNjRryjHv5D224DDxZtfPHa+deqmVRAmdYZjRJh5e3+c3
         qU+ycPYJ44F2fto15l+xO0asfg5EwT/GePYpm6wjzeRt0gnzXlGPqfCDdgz+yHAdG8H5
         htdg==
X-Gm-Message-State: APjAAAXL1jiJDwRYjiaPd9xZc+o5WMqkQY55rycljSG7Mmn3Llt8x5ra
        MteCN+bvMmZczPRGhkoFSOwvM8HItbnpwoZn5A4GdmlV
X-Google-Smtp-Source: APXvYqxUzowaWQBp3VxZ8XVodxcgOiJzN63RyzkTcGPj3EWfowzfbUD99BNstPCS4nHDiIR6BbRxMR7YaGDfktn/AX4=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr16433048vsp.166.1552296785126;
 Mon, 11 Mar 2019 02:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190309005613.1493-1-marek.vasut@gmail.com>
In-Reply-To: <20190309005613.1493-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Mar 2019 10:32:53 +0100
Message-ID: <CAMuHMdUvcXyQ5DLzDp9ub3a1eQ05byCoEgxD7SV2=a6yVEtx+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rcar: Clean up remaining macros defining bits
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

On Sat, Mar 9, 2019 at 1:56 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Replace macros using constants with BIT()s instead, no functional change.
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
