Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:43037 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeGAOGg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Jul 2018 10:06:36 -0400
Date: Sun, 1 Jul 2018 16:06:34 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, ray.jui@broadcom.com
Subject: Re: [PATCH v2 1/3] PCI: Data corruption happening due to race
 condition
Message-ID: <20180701140634.GA22322@wunner.de>
References: <1530268061-17324-1-git-send-email-hari.vyas@broadcom.com>
 <1530268061-17324-2-git-send-email-hari.vyas@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530268061-17324-2-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 29, 2018 at 03:57:39PM +0530, Hari Vyas wrote:
> Fix moves device addition is_added bit to separate private flag
> variable and use different atomic functions to set, clear and
> retrieve device addition state. As is_added shares different
> memory location so race condition is avoided.

As 0-day has already discovered, you need to squash all 3 patches
together to avoid breaking the build.


> +static inline int pci_dev_set_added(struct pci_dev *dev, void *unused)
> +{
> +	set_bit(PCI_DEV_ADDED, &dev->priv_flags);
> +	return 0;
> +}
> +
> +static inline int pci_dev_clear_added(struct pci_dev *dev, void *unused)
> +{
> +	clear_bit(PCI_DEV_ADDED, &dev->priv_flags);
> +	return 0;
> +}

You don't need the "unused" parameter here and you can return void.
pci_dev_set_disconnected() has the parameter because the function is
passed in to pci_walk_bus() in a few places, but you're not doing that
AFAICS.

What you *could* do however is collapse pci_dev_set_added() and
pci_dev_clear_added() into a single function, pass in a bool "added",
then use assign_bit() to set or clear it.  It would save 6 LoC.

Thanks,

Lukas
