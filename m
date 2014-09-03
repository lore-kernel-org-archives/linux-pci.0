Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:43444 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933082AbaICXgQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 19:36:16 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so9273828qgf.28
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2014 16:36:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1408756512-16885-4-git-send-email-yinghai@kernel.org>
References: <1408756512-16885-1-git-send-email-yinghai@kernel.org> <1408756512-16885-4-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Sep 2014 17:35:53 -0600
Message-ID: <CAErSpo5ZttK0EjT3-kQwiRX9NOK6V0q7Euq1pFks0GO0msAENQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: don't release sibiling bridge resources during hotplug
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 22, 2014 at 7:15 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On hotplug path, we can not touch sibling bridges that is out
> side of the slot.
>
> That could happen when BIOS does not assign some bridge BARs and
> later can not assign resource to them in first try.
>
> Check if fail dev is the parent bridge, then just use subordinate
> bus instead use parent bus.
>
> Reported-by:  Andreas Noever <andreas.noever@gmail.com>

This needs a link to the problem report so we can try to match up the
fix with the problem and see how it works.

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>
> ---
>  drivers/pci/setup-bus.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -1676,10 +1676,16 @@ again:
>          * Try to release leaf bridge's resources that doesn't fit resource of
>          * child device under that bridge
>          */
> -       list_for_each_entry(fail_res, &fail_head, list)
> -               pci_bus_release_bridge_resources(fail_res->dev->bus,
> +       list_for_each_entry(fail_res, &fail_head, list) {
> +               struct pci_bus *bus = fail_res->dev->bus;
> +
> +               if (fail_res->dev == bridge)
> +                       bus = bridge->subordinate;
> +
> +               pci_bus_release_bridge_resources(bus,
>                                                  fail_res->flags & type_mask,
>                                                  whole_subtree);
> +       }
>
>         /* restore size and flags */
>         list_for_each_entry(fail_res, &fail_head, list) {
