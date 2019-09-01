Return-Path: <SRS0=YFck=W4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECB7C3A5A4
	for <linux-pci@archiver.kernel.org>; Sun,  1 Sep 2019 21:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7B322CF7
	for <linux-pci@archiver.kernel.org>; Sun,  1 Sep 2019 21:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DYVZfSWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfIAVq0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 1 Sep 2019 17:46:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40005 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfIAVqZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Sep 2019 17:46:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id y39so1867281ota.7
        for <linux-pci@vger.kernel.org>; Sun, 01 Sep 2019 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8TZLebnGbANzOw8CueGexyIqbu30cWweQAWlVJcgqY=;
        b=DYVZfSWJhmJpXCtDFZW+YgBkRAycI/cKRtW8n3Z804rBLcJz7zbIlM6e3SgucS+bgN
         PlGJcbtsoBL7rDlp8KGBhursAXFOhlERP98LEQ7wAm31zgSQQH04mzYC7qZ+ndmkKIvJ
         QqRrysLFv7EyeDI6ylnnEvEcfH7yaE/N4YQU+g9Ui32PjSNgQxkKL6z5zA2uRwJ36UVw
         L6+/dw6M18NJjeeLjHNrFsrqxj6lOT3lJtQTTRxvPkYn4OniK2g8mBVS1EAs7f3SALOd
         ZvGYfvkYnC/yk95yzj/5NoJ/kFg6XCWN3PtXkpw6xqaRSi17XRQCTlr09Ku03V3ChygA
         3WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8TZLebnGbANzOw8CueGexyIqbu30cWweQAWlVJcgqY=;
        b=AqfxVBtY5QPcw9S5GM/hq8eSQzmy4D4x0h+/iBgn3pRvSQ1paJ1yd77t0gWGQakfNa
         uilw6oOBRH/hbNnkiSDmGE+lEZ9yTVfR5NCKmFz6ON8C7V+JIlxV1c5IHQfbYIHw6hkX
         VLVn9qgIiWIH8SaAavqd87tRZyAaT4zSvwypRDfa5lGVJ5j/ySNC8ljKpHdn03NIp7pL
         OvrgFO+85xU/AI8Uwd1ynV2cssgZuIQPVDOVvCt1hXpnpWBUxlhFG8W0s/NxH9mTZbev
         gkQqMfRtYCX2HZ7zlMldZGypM8VlF6BLzB/yo+jwdnNhE56kjKMjKapu6nbYioNuMbrY
         NGCg==
X-Gm-Message-State: APjAAAXBPuj2Cr/wigD8XTaK5lmdglMSsuUQgMwntjdd99X0Rzj9F2nH
        5GuzsntZ7LTR1n8uLYrKBETw9OOWU3i93FBCrYI=
X-Google-Smtp-Source: APXvYqz8GsC7TJh2aUM9UBDKb4Ai81sj3noSRYLczdX8vjsdCZhPjPyzF5VvAjNsJ8zLy73WbsQMoc097YprC18nqv8=
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr22152068otk.81.1567374385279;
 Sun, 01 Sep 2019 14:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190901133915.12899-1-repk@triplefau.lt>
In-Reply-To: <20190901133915.12899-1-repk@triplefau.lt>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 1 Sep 2019 23:46:14 +0200
Message-ID: <CAFBinCD-eH8A7XqiCDBfdejHRVQc2+RVTRB+ZJfnG47Gs3fUuw@mail.gmail.com>
Subject: Re: [PATCH] PCI: amlogic: Fix reset assertion via gpio descriptor
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Yue Wang <yue.wang@amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-pci@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 1, 2019 at 3:30 PM Remi Pommarel <repk@triplefau.lt> wrote:
>
> Normally asserting reset signal on gpio would be achieved with:
>         gpiod_set_value_cansleep(reset_gpio, 1);
>
> Meson PCI driver set reset value to '0' instead of '1' as it takes into
> account the PERST# signal polarity. The polarity should be taken care
> in the device tree instead.
>
> This fixes the reset assertion meaning and moves out the polarity
> configuration in DT (please note that there is no DT currently using
> this driver).
>

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe
controller driver")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
