Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:37011 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBTOE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Feb 2018 09:04:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180220085813.1897-1-christian.koenig@amd.com>
References: <20180220085813.1897-1-christian.koenig@amd.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Feb 2018 16:04:54 +0200
Message-ID: <CAHp75VdOdwDpJpe-Xg2ogEx0sZ2QsnO0Xcc+Ajn5aaRh2p3h9g@mail.gmail.com>
Subject: Re: [PATCH] PCI: stop crashing in pci_release_resource
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:58 AM, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
> Is it entirely possible that the BIOS wasn't able to assign resources to
> a device. In this case don't crash in pci_release_resource() when we try
> to resize the resource.

>         struct resource *res =3D dev->resource + resno;
>
> +       if (!res->parent)
> +               return;
> +
>         dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);

I would find info message is useful even in such case.

>         release_resource(res);
>         res->end =3D resource_size(res) - 1;

--=20
With Best Regards,
Andy Shevchenko
