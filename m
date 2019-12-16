Return-Path: <SRS0=GIoD=2G=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511D9C43603
	for <linux-pci@archiver.kernel.org>; Mon, 16 Dec 2019 00:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1772072A
	for <linux-pci@archiver.kernel.org>; Mon, 16 Dec 2019 00:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFYxvZ4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLPAq1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 15 Dec 2019 19:46:27 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:39479 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfLPAq1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2019 19:46:27 -0500
Received: by mail-io1-f50.google.com with SMTP id c16so3210506ioh.6
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2019 16:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=YrDQlY3igCX/nfFCN5lHwT2I+1UXfedetiyUunyFClw=;
        b=kFYxvZ4+KpE8j4Ms6N/gwICbSWxAE4iv18uh2AyzFT4eIA1HoXCFNpol/zv0pRKQ/N
         opErEoPmDiYv/nzz/KUXhoHT/0yFbmzynTMyb0Su+1E7JyJ9CY1Ynlk+6criNwvj6CTl
         Ew2mXRFds6L2EwdJ+si/RbgNviESPgcFNMLURfYqACVyZVoMI1RjPxJRKZOp2wvhuhga
         dd7BUrAVMpr+6ZfDJJc+TGMr62zdP8QFg6i7i50W8DleFaxy+oBJ8xptr7IKHyAWxkBN
         /wE6ITJP6WarVNO8pNufCWyzFLGNX7IiIMw4Ih5Yo9+/QHX2nTannvOhwalqC3qY6gm5
         wRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=YrDQlY3igCX/nfFCN5lHwT2I+1UXfedetiyUunyFClw=;
        b=OLNttuw1tLuBJ0OehInCUwKA5rrzenKXY5zPgyUvT5FhoQp0zU+qAOfRnnu0BA9kAC
         PY9syx9ZGbeRkjzHqsp2MZ/HSCSmA9iCXVjC3Hq3mtJ/dXVOk+5pBAPRDb+seV9mte7G
         FcDRJM5hpGYsQ5RXInPHL6m13jSS9DCjx5QrTxS1fxTpJLDvEUdNuxVjyrJ3QBYmu0wl
         EdyjaXx1YzdXekO9K6xt+2ELjVIoS2mkqT90DVX+75ksE4QfRE08AK9xYArod8rupAQ6
         yQfTUfhKsIdHSw2dctunuGI8ChQKLEY2gJcbKnd3z974Wj+4VhXDA6KUKqxAcm5NhYWl
         Jlqg==
X-Gm-Message-State: APjAAAXZ0bMA18Qy2Ca28d3iS9n2w+OUQGmXz9PexIOdmYEK0yd30ilo
        o4JWx4jXI56A8SyRChgrtnsA1hQBIB6VCJQRIWg=
X-Google-Smtp-Source: APXvYqybjSFNQlh0K1LFp8Gj2sFWF1zbABczQQOpNd/nFptH6oLTu66PkXtePL9wW2pqVyncdrW/G19BthbLZXGayDs=
X-Received: by 2002:a5d:9512:: with SMTP id d18mr16359069iom.85.1576457186413;
 Sun, 15 Dec 2019 16:46:26 -0800 (PST)
MIME-Version: 1.0
References: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de> <PSXP216MB0438BE9DA58D0AF9F908070680540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <c9f154e5-4214-aa46-2ce2-443b508e1643@denx.de> <PSXP216MB0438AD1041F6BD7DB51363A380540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438AD1041F6BD7DB51363A380540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Sun, 15 Dec 2019 18:46:15 -0600
Message-ID: <CABhMZUUGTiH-KfPtLQrc6LkXzc7CpkrAcOSmvv6p0Uj4K+_abQ@mail.gmail.com>
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Stefan Roese <sr@denx.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > The logs are also included. Please let me know, if I should do any other
> > tests and provide the logs.

Please include these logs in your mail to the list or post them
someplace where everybody can see them.
