Return-Path: <SRS0=uRTt=SQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF7CC10F13
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 22:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05412082E
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 22:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV3aN9rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDNWYU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 18:24:20 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:39302 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfDNWYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 18:24:20 -0400
Received: by mail-qk1-f178.google.com with SMTP id c189so8777160qke.6
        for <linux-pci@vger.kernel.org>; Sun, 14 Apr 2019 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=bdLYjr1QQzolj0ATyqTqCF6TC/Ans1oc6toXFLe+K4g=;
        b=YV3aN9rwxRCj7WQUnxLuvmLw8YeZrh6DsynN9M6pogWVtKQO5fTpAzsPrvC2gIIgdP
         eVHJiI8tZI02cmfERanNq66C5v+SYI2fx66G2oex688xDwvAeALj3xASivD96Z4f+Hzx
         NGEr8oiy7KScf8djWd/GgerapQRuQFjPgA70c0HzBe8amFlLvPniV3fKJgU+KZA+pSQ0
         SgJFTy2W+NlzYQ0R4h2UK9/yw4Oed4AThvYmvCxkjXbwMeuur4oxe44nE26ScKtd/ouL
         y8joFcAZtfX3WsjAqVBDB8t+TMC1keKVnuMRtJMcE+0gdV46I+FcWf1P9C5h3wzqgSyd
         w7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=bdLYjr1QQzolj0ATyqTqCF6TC/Ans1oc6toXFLe+K4g=;
        b=eZzMpH8EgpLeI4Afxr6q8b1Kr4ipZdYr0DJQRfsDQ6k4+cPqaKHue+lk9gUfCOo2en
         k4dFS7Y3I3D4jJn6b5Fy2CSZv4aqSlRZm1d5ealyFSi5NpGpALYuE7RKB469Q/lGA0Mg
         9s8ER3Cv6mHZvLBlGWpt3QhKiAmped+p7tlL78B+/GtfyryHEHAkX5gME0hxndbL8ONT
         1STs1zWES2oCuBOK7fttMHwwnb0EHiReGOeCAVBhxzdqCRdOkzxuS1YPx77Bogfa15Od
         M6xiuW8HONG5YomzRUOyiWiKUforY6iLL4jSIKfFB6Gg6pYDibTeB+c9maL9oZj5cZEN
         ArCw==
X-Gm-Message-State: APjAAAXd33o/9NIYq66xZyuDCNvMNkz4UYeYhPckqMbcgiHIfd2fOw5x
        TQluUXf+CSeZyt7pBdEvpNERMnw+qYDRDRHU2J0szSflXqc=
X-Google-Smtp-Source: APXvYqyDgS2+bUnEKNrqWIHXNJ0/HMbkwc0EixMvdFO61gMmUWedNN0NfXpcqdmBT0LydLeFmRPwbRprAE+QfD5lBj4=
X-Received: by 2002:a37:4bc1:: with SMTP id y184mr54849346qka.169.1555280659731;
 Sun, 14 Apr 2019 15:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <bug-203303-193951@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203303-193951@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Sun, 14 Apr 2019 17:24:08 -0500
Message-ID: <CABhMZUWEvx62b-w5Wxf3xbjn9rFpZRMMWNvF3iBStgVnemJ5Aw@mail.gmail.com>
Subject: Re: [Bug 203303] New: PCIe Bus Error
To:     bugzilla-daemon@bugzilla.kernel.org
Cc:     bugzilla.pci@gmail.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> pcieport 0000:00:01.7: AER: Corrected error received: 0000:00:01.0
> pcieport 0000:00:01.7: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> pcieport 0000:00:01.7:   device [1022:15d3] error status/mask=00000040/00006000
> pcieport 0000:00:01.7:    [ 6] BadTLP

Can you please attach a complete dmesg log and complete "sudo lspci
-vv" output for the whole system?  Is this reproducible?  Is it a
regression?

Hardware should recover from PCIe correctable errors without software
intervention.  They are reported only for logging purposes.  Does your
system work correctly in spite of logging this error?  Is it possible
the ath10k card is not seated correctly, has dirty contacts, etc?
