Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35005 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbdD1P0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2017 11:26:07 -0400
Received: by mail-wr0-f181.google.com with SMTP id z52so35637865wrc.2
        for <linux-pci@vger.kernel.org>; Fri, 28 Apr 2017 08:26:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170428085548.15942-1-weiyj.lk@gmail.com>
References: <20170428085548.15942-1-weiyj.lk@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Apr 2017 10:25:45 -0500
Message-ID: <CAErSpo6vvbut5YROVih_Ex2NTdsJP9JNFP0PyBsn74kRApaOWQ@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: endpoint: functions: Fix return value check in pci_epf_test_probe()
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 28, 2017 at 3:55 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fix the return value check which testing the wrong variable
> in pci_epf_test_probe().
>
> Fixes: 79ba640e377b ("PCI: endpoint: functions: Add an EP function
> to test PCI")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

This fix looks obviously correct, so I folded it into the original
commit for v4.12.  Thanks!

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index d6a7a12..53fff80 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -441,7 +441,7 @@ static int pci_epf_test_probe(struct pci_epf *epf)
>         struct device *dev = &epf->dev;
>
>         epf_test = devm_kzalloc(dev, sizeof(*epf_test), GFP_KERNEL);
> -       if (!epf)
> +       if (!epf_test)
>                 return -ENOMEM;
>
>         epf->header = &test_header;
>
