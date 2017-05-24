Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36685 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940020AbdEXMgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2017 08:36:25 -0400
Received: by mail-it0-f49.google.com with SMTP id o5so37291233ith.1
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2017 05:36:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170524122802.29493-1-pbrobinson@gmail.com>
References: <20170524122802.29493-1-pbrobinson@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 24 May 2017 14:36:23 +0200
Message-ID: <CACRpkdZ_7rNznqeLEnbzsXhEenWtExqKCauB__UgzfkZFt+4WA@mail.gmail.com>
Subject: Re: [PATCH] pci: host: FTPCI100: Add dependency on ARCH_GEMINI
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 24, 2017 at 2:28 PM, Peter Robinson <pbrobinson@gmail.com> wrote:

> Add dependency on ARCH_GEMINI and compile test
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Why? This is a generic IP block that also exist in Andestech,
Faraday reference design and possibly others. If they want
to reuse this driver they would have to patch this away again,
seems pointless to me.

Yours,
Linus Walleij
