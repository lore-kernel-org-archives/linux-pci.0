Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42705 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755776Ab2IRWzN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2012 18:55:13 -0400
Received: by lagy9 with SMTP id y9so277480lag.19
        for <linux-pci@vger.kernel.org>; Tue, 18 Sep 2012 15:55:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1347322773-32283-1-git-send-email-yinghai@kernel.org>
References: <1347322773-32283-1-git-send-email-yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 18 Sep 2012 16:54:52 -0600
Message-ID: <CAErSpo4d2qirLLcbNBdSSdy0u7N87mVD1ArC=uDr9S7q+=dN8A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Check bridge secondary/subordinate bus register
To: Yinghai Lu <yinghai@kernel.org>
Cc: VL <vl.homutov@gmail.com>, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 10, 2012 at 6:19 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Intel DP43BF requires "pci=assign-busses" to discover some devices.
>
> It turns out BIOS set the bridge 00:1e.0 bus register wrong.
>
> Try to check that wrong range and reject so next pass could only assign
> bus for that bridge.
>
>         https://bugzilla.kernel.org/show_bug.cgi?id=18412

Applied to pci/yinghai-misc, thanks!

> Reported-by: VL <vl.homutov@gmail.com>
> Tested-by: VL <vl.homutov@gmail.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: stable@vger.kernel.org
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3cdba8b..a8f1bf6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -729,7 +729,8 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
>
>         /* Check if setup is sensible at all */
>         if (!pass &&
> -           (primary != bus->number || secondary <= bus->number)) {
> +           (primary != bus->number || secondary <= bus->number ||
> +            secondary > subordinate)) {
>                 dev_dbg(&dev->dev, "bus configuration invalid, reconfiguring\n");
>                 broken = 1;
>         }
