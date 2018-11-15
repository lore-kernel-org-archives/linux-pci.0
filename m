Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23475C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 11:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56442245E
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 11:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VK6svXw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56442245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeKOVQF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:16:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41097 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOVQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 16:16:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so16915696ljb.8
        for <linux-pci@vger.kernel.org>; Thu, 15 Nov 2018 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycBf29sIaN5VQ2JHnb77IwBI7KrQXoEagmFxshM/On4=;
        b=VK6svXw1KyJrNgJVBUEgirh+93W/zLU+GHUOFzQ05IXCYcX49SD93mKzRqk/RA3izi
         wX5EynUQv9Q8XTI4/rmy+cyX1dfyghpixEsPp9uUe5rSGXD+pAxcoLy6IXjdYXSiE5rn
         rn0XHPRYoFCu/ae5wRRaMKVdUKYkr4pYTcH34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycBf29sIaN5VQ2JHnb77IwBI7KrQXoEagmFxshM/On4=;
        b=RrndIWSbrVXwuLyfAi7Aa+8D/X7zMcPwZOpY55gFnVCQ2PUqPJOvcwRMFKqDWUXWqb
         jK7i+I1csD6jDrAou58s4YM6YUJGC5yO1ceDChXAiceCPkJFXFW1B3sA6byGaA214qg1
         ayJwr2mFPfdaKIGD/ytr2UVofqGk1wiAji9VA0Y/LMdyX5Ux/CbThVtaBh9NrNmAQ7Ad
         Tcs/FRwx4QkGI7anHGkIUbNfEAUtWPkLujjooMQl0euVnK9CrApFUSCcRj1cSyCsDbmi
         oPUrsJ/FtRp0P1WewRLPL7vCTdNC/OmQRshnz9YWdiYeTKqXW1b5sHJa2zjVIynh0cH6
         acEg==
X-Gm-Message-State: AGRZ1gIcDCALNVn+ruLI40ZjIL+NoDUvRMMz0iL+86wt4YDTDH/wCkEm
        p1dLwzXgLOKun4RSIKOLKML5CbQzuF24bmvNyGW6bA==
X-Google-Smtp-Source: AJdET5cy9JDQPi1aKQXRvTh5cZbZo2C37j+zofPsdsIh8s0aiLCiVWaQM1vyoDPRfH/STw9UDjMRjLfyLI24EKE9GJQ=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr3338231ljp.12.1542280119895;
 Thu, 15 Nov 2018 03:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 12:08:27 +0100
Message-ID: <CACRpkdabENLZQbYgJufF9_Bcn5QTsETLPN8zT=+BKs982P0NCw@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: Move Rohm vendor ID to generic list
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     vkoul@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 7, 2018 at 8:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Move the Rohm vendor ID to pci_ids.h from dozen of drivers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please merge it in a way that doesn't upset Greg! :)

Yours,
Linus Walleij
