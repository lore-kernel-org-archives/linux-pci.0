Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBEECDE46
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 13:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F532075D
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 13:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VYJXLZ4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F532075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJYW2Y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:28:24 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:44460 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbeJYW2X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Oct 2018 18:28:23 -0400
Received: by mail-lf1-f45.google.com with SMTP id m18-v6so6863195lfl.11
        for <linux-pci@vger.kernel.org>; Thu, 25 Oct 2018 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pF6Ntyek8lzhI14RsHZQtcUKXPUe3XVye+Z+HZsCvU0=;
        b=VYJXLZ4fNBBbs0hP5YoWWqI7Z5nJSveS2c1i8xY6/FuT494OAmyNGOig2YQW0m4VVX
         SBDn1JoWNmqrtVE7zt9ufP/S8BdntMeEluxMN43QG4WY/M7dDsbZXxT7a0raZEGJ492/
         G7CizwGBieTnGOFNuhP0pm+dCKRFIYswZzi4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pF6Ntyek8lzhI14RsHZQtcUKXPUe3XVye+Z+HZsCvU0=;
        b=MjYN/K+YjHDbAPTsxbb8LN2CXbCnTcqhnsiXJxgNDA9hDIYP2xsODutH3mKBNh0oNK
         SyrxZRpZUi2IdzjgitLcMXwkLiIchj8k4zUG/3aaCktbj21OZG7x9OaQ4kHGZ6G7mnYn
         NXrQHNm3qqTMXtI81VDcIDhaBl+dYiP4ASa3UyaWA8mgihylwL+/YDx+dbyLOhPBPTG5
         fX3s9qsIe2cL9EL2LtaxLHa0x3qc0IiFij4dRw/9smN7bUxlv9vqR9gykgDLmag3wvDN
         rxUBkHTCyAr9NI9/fJXaEHT0kHKF1tnF32R5R76Wm3fUqzrFJybKcazOACr03eHY3xcc
         0LeQ==
X-Gm-Message-State: AGRZ1gJcD2cGFy6tg2bizFYNUu7PTH0wiKGhWh9AhKgYQ53k2lOzYIQg
        9Tx6gdNEmkZ3ae9l2VrKH2m7lmRN9BFEa0+R
X-Google-Smtp-Source: AJdET5ddkwGR/i3Lz9UQmZ8vYBzW8pdLE0AK2s3rpo1zIA6sbueMjqJyBEZI8hNroDHN4y3DtrdG/Q==
X-Received: by 2002:a19:4d8d:: with SMTP id a135mr1336070lfb.80.1540475730199;
        Thu, 25 Oct 2018 06:55:30 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id g92-v6sm1172058lji.24.2018.10.25.06.55.28
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:55:29 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id c16so6855652lfj.8
        for <linux-pci@vger.kernel.org>; Thu, 25 Oct 2018 06:55:28 -0700 (PDT)
X-Received: by 2002:a19:111b:: with SMTP id g27mr1293580lfi.135.1540475728189;
 Thu, 25 Oct 2018 06:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 06:55:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTnb=o9JomnD68ob-6wNKHbBsYKKD1XmNwDBW0NjvkPA@mail.gmail.com>
Message-ID: <CAHk-=wiTnb=o9JomnD68ob-6wNKHbBsYKKD1XmNwDBW0NjvkPA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v4.20
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lorenzo.pieralisi@arm.com, Greg KH <gregkh@linuxfoundation.org>,
        bvanassche@acm.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 23, 2018 at 10:39 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> PCI changes:

Pulled,

                        Linus
