Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B76ECE564
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 21:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA1521524
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 21:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA1521524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbeITDYH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:24:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46794 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbeITDYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 23:24:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so6468728oie.13;
        Wed, 19 Sep 2018 14:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwklSjHjal4QuLWwU4kewYTcJPFjRGu3jB8GSx6RG5w=;
        b=onCozdgfjPL2OvHh5HoWct6Sem9DV4yrNftvCNpbh4ki5fD/+3k2zElbKRUvru4GEZ
         iS1ViwX4pQhNrGh0S30FtGiL2LNHeh4T2izy+qQCC1J7Akwj8BfI5PCHAkkMloimriDi
         sdO9AL5vpH1yz6ejVvFGk8KNHkeL49TAfJebxEQ8c5PtyW2EbISW4vnBTGfeur/sWom5
         DJ0LzQQAZdKZNP+Z7qargDaQWEX3LXwbRZIeq7RouME1lLskaCXde8u97ik1qZKIKoEW
         35gsiSTpvBRW3DhFFYzl/r3yTyrZqnKyz3lziTQg/TL4hiozwOxmeIB7uGupkhY2q480
         EfPg==
X-Gm-Message-State: APzg51DXzjIorT3KojAcDDSbcrtj3Bq6Rg8YNPUHEmjg1Q0V2MFvJyIG
        JvPGuhSjRV4zWBlS1l32/xZwqxL71XrieNXXr10=
X-Google-Smtp-Source: ANB0VdaSQfgcCcvjMh+7OZlBhTIIGkuqIXPfWaDqC4huNumgvcV+b63OQw/MP5haKksXuU/BevJ4i2Yj5ks2WUOmswc=
X-Received: by 2002:aca:e8c9:: with SMTP id f192-v6mr2752802oih.87.1537393454998;
 Wed, 19 Sep 2018 14:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180919113247.4274-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20180919113247.4274-1-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Sep 2018 23:44:02 +0200
Message-ID: <CAJZ5v0ir_S3gXP905-Ex9K7OQkG3OJD=pnLt0dKZ0jbSFe_BWQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Don't scan for non-hotplug bridges
 if slot is not bridge
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, peter.anemone@gmail.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 1:32 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> HP 6730b laptop has an ethernet NIC connected to one of the PCIe root
> ports. The root ports itself are native PCIe hotplug capable. Now,
> during boot after PCI devices are scanned the BIOS triggers ACPI bus
> check directly to the NIC:
>
>   [    0.942239] ACPI: \_SB_.PCI0.RP06.NIC_: Bus check in hotplug_event()
>
> It is not clear why it is sending bus check but regardless the ACPI
> hotplug notify handler calls enable_slot() directly (instead of going
> through acpiphp_check_bridge() as there is no bridge) which ends up
> handling special case for non-hotplug bridges with native PCIe hotplug.
> This results a crash of some kind but the reporter only sees black
> screen so it is hard to figure out the exact spot and what actually
> happens. Based on few fix proposals it was tracked to crash somewhere
> inside pci_assign_unassigned_bridge_resources().
>
> In any case we should not really be in that special branch at all
> because the ACPI notify happened to a slot that is not a PCI bridge (it
> is just a regular PCI device).
>
> Fix this so that we only go to that special branch if we are calling
> enable_slot() for a bridge (e.g the ACPI notification was for the bridge).
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201127
> Fixes: 84c8b58ed3ad ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug
> Reported-by: Peter Anemone <peter.anemone@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index ef0b1b6ba86f..fa2d82ae6ccd 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -457,17 +457,20 @@ static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
>  /**
>   * enable_slot - enable, configure a slot
>   * @slot: slot to be enabled
> + * @bridge: Bridge if the hotplug was directly to the bridge. %NULL
> + *         otherwise.
>   *
>   * This function should be called per *physical slot*,
>   * not per each slot object in ACPI namespace.
>   */
> -static void enable_slot(struct acpiphp_slot *slot)
> +static void enable_slot(struct acpiphp_slot *slot,
> +                       const struct acpiphp_bridge *bridge)
>  {
>         struct pci_dev *dev;
>         struct pci_bus *bus = slot->bus;
>         struct acpiphp_func *func;
>
> -       if (bus->self && hotplug_is_native(bus->self)) {
> +       if (bridge && bus->self && hotplug_is_native(bus->self)) {

AFAICS "bridge" is used as a bool here.  What would be wrong with
using the bool data type for this arg?

>                 /*
>                  * If native hotplug is used, it will take care of hotplug
>                  * slot management and resource allocation for hotplug
> @@ -701,7 +704,7 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>                                         trim_stale_devices(dev);
>
>                         /* configure all functions */
> -                       enable_slot(slot);
> +                       enable_slot(slot, bridge);
>                 } else {
>                         disable_slot(slot);
>                 }
> @@ -785,7 +788,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
>                 if (bridge)
>                         acpiphp_check_bridge(bridge);
>                 else if (!(slot->flags & SLOT_IS_GOING_AWAY))
> -                       enable_slot(slot);
> +                       enable_slot(slot, NULL);
>
>                 break;
>
> @@ -973,7 +976,7 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
>
>         /* configure all functions */
>         if (!(slot->flags & SLOT_ENABLED))
> -               enable_slot(slot);
> +               enable_slot(slot, NULL);
>
>         pci_unlock_rescan_remove();
>         return 0;
> --
> 2.18.0
>
