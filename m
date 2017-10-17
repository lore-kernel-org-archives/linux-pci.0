Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:54760 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933143AbdJQQWZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 12:22:25 -0400
Received: by mail-io0-f170.google.com with SMTP id e89so2872406ioi.11
        for <linux-pci@vger.kernel.org>; Tue, 17 Oct 2017 09:22:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508242263-73684-1-git-send-email-weiyongjun1@huawei.com>
References: <1508242263-73684-1-git-send-email-weiyongjun1@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Oct 2017 18:22:23 +0200
Message-ID: <CACRpkdZFykqQ+SoO1NSJrXcPxGbQQmL2_-Fk4n31yQ5N4LcsPQ@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: faraday: Fix wrong pointer passed to PTR_ERR()
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 2:11 PM, Wei Yongjun <weiyongjun1@huawei.com> wrote:

> PTR_ERR should access the value just tested by IS_ERR, otherwise
> the wrong error code will be returned.
>
> Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Whoops, thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
