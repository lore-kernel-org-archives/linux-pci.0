Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34901 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbbIUBjR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Sep 2015 21:39:17 -0400
Received: by vkao3 with SMTP id o3so56561287vka.2
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2015 18:39:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150918223059.GO25767@google.com>
References: <1441877628-28879-1-git-send-email-lorenzo.pieralisi@arm.com>
	<20150918223059.GO25767@google.com>
Date: Sun, 20 Sep 2015 18:32:32 -0700
Message-ID: <CAE9FiQXMZzQ+eB5X8N=zMEV8BWxLfpmASK7Jdfz-UKFzaHk+_A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix pci_claim_bridge_resource() resource claiming
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 18, 2015 at 3:30 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> commit a4ad03352739c96842af5d06387595665cdd875e
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Sep 18 17:15:01 2015 -0500
>
>     PCI: Clear IORESOURCE_UNSET when clipping a bridge window
>
>     c770cb4cb505 ("PCI: Mark invalid BARs as unassigned") sets IORESOURCE_UNSET
>     if we fail to claim a resource.  If we tried to claim a bridge window,
>     failed, clipped the window, and tried to claim the clipped window, we
>     failed again because of IORESOURCE_UNSET.
>
>     When pci_bus_clip_resource() clips a bridge window to fit inside an
>     upstream window, we're reassigning the window, so clear the
>     IORESOURCE_UNSET flag.  Also clear IORESOURCE_UNSET in our copy of the
>     unclipped window so we can see exactly what the original window was and how
>     it now fits inside the upstream window.
>
>     Fixes: c770cb4cb505 ("PCI: Mark invalid BARs as unassigned")
>     Based-on-patch-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org  # 4.1+
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 6fbd3f2..d3346d2 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -256,6 +256,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
>
>                 res->start = start;
>                 res->end = end;
> +               res->flags &= ~IORESOURCE_UNSET;
> +               orig_res.flags &= ~IORESOURCE_UNSET;
>                 dev_printk(KERN_DEBUG, &dev->dev, "%pR clipped to %pR\n",
>                                  &orig_res, res);
>

I put this patch in
https://bugzilla.kernel.org/show_bug.cgi?id=85491

after niam <mailto:niaminbox@gmail.com> test that, you may apply that directly.
