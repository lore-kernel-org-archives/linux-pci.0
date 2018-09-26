Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0A5C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 19:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8F621536
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 19:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xnOiVC7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8F621536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeI0Bis (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeI0Bis (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 21:38:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBB7421533;
        Wed, 26 Sep 2018 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537989861;
        bh=52kxYWnShG/EJXrpS8BAP8kF70I6nyYLuOcheKOfeB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xnOiVC7YhhFDlvLQop+nX2n95BapiC2FXcwl56WggjWsxBELsckadgj3KFh0tlCX/
         ZfHEQPSRmT5BPfqeNBQKPfnSMpOP6ejauLLPFjgthVvb/hoFODvcbAqJBYEYoYTY5h
         Yu8zYpF79ypkGz2auFblpbxqI7lD8sBnzsazT2DA=
Date:   Wed, 26 Sep 2018 14:24:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PCI: Fix bus error reset when CONFIG_SYSFS not set
Message-ID: <20180926192419.GB28024@bhelgaas-glaptop.roam.corp.google.com>
References: <20180926152326.14821-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926152326.14821-1-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 26, 2018 at 09:23:26AM -0600, Keith Busch wrote:
> The pci slot component is not compiled if the kernel config does not
> set CONFIG_SYSFS, but a previous commit used a lock symbol from there
> without considering when it isn't defined.
> 
> This patch fixes that by moving the mutex definition to a context outside
> CONFIG_SYSFS. This also made it obvious the implementation missed going
> to the fallback when there were no bus slots, so this is also fixed.
> 
> Fixes: 131b0ca2c7b263fd ("PCI/ERR: Use slot reset if available")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Folded into 131b0ca2c7b263fd ("PCI/ERR: Use slot reset if available")
since it hasn't been merged upstream yet, thanks!  This on pci/hotplug,
headed for v4.20.

> ---
>  drivers/pci/pci.c  | 24 ++++++++++++++----------
>  drivers/pci/slot.c |  1 -
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2b4117011313..f6104a551b60 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -35,6 +35,8 @@
>  #include <linux/aer.h>
>  #include "pci.h"
>  
> +DEFINE_MUTEX(pci_slot_mutex);
> +
>  const char *pci_power_names[] = {
>  	"error", "D0", "D1", "D2", "D3hot", "D3cold", "unknown",
>  };
> @@ -5201,21 +5203,23 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
>  int pci_bus_error_reset(struct pci_dev *bridge)
>  {
>  	struct pci_bus *bus = bridge->subordinate;
> +	struct pci_slot *slot;
>  
>  	if (!bus)
>  		return -ENOTTY;
>  
>  	mutex_lock(&pci_slot_mutex);
> -	if (!list_empty(&bus->slots)) {
> -		struct pci_slot *slot;
> -
> -		list_for_each_entry(slot, &bus->slots, list)
> -			if (pci_probe_reset_slot(slot))
> -				goto bus_reset;
> -		list_for_each_entry(slot, &bus->slots, list)
> -			if (pci_slot_reset(slot, 0))
> -				goto bus_reset;
> -	}
> +	if (list_empty(&bus->slots))
> +		goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list)
> +		if (pci_probe_reset_slot(slot))
> +			goto bus_reset;
> +
> +	list_for_each_entry(slot, &bus->slots, list)
> +		if (pci_slot_reset(slot, 0))
> +			goto bus_reset;
> +
>  	mutex_unlock(&pci_slot_mutex);
>  	return 0;
>  bus_reset:
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 3da03fcc6fbf..c46d5e1ff536 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -14,7 +14,6 @@
>  
>  struct kset *pci_slots_kset;
>  EXPORT_SYMBOL_GPL(pci_slots_kset);
> -DEFINE_MUTEX(pci_slot_mutex);
>  
>  static ssize_t pci_slot_attr_show(struct kobject *kobj,
>  					struct attribute *attr, char *buf)
> -- 
> 2.14.4
> 
