Return-Path: <SRS0=VK9V=S5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49095C43219
	for <linux-pci@archiver.kernel.org>; Sat, 27 Apr 2019 20:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A142064A
	for <linux-pci@archiver.kernel.org>; Sat, 27 Apr 2019 20:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfD0UDE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:03:04 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:51821 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfD0UDE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Apr 2019 16:03:04 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id D1CA110295D2C;
        Sat, 27 Apr 2019 22:03:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 86BDD24F2EF; Sat, 27 Apr 2019 22:03:01 +0200 (CEST)
Date:   Sat, 27 Apr 2019 22:03:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     fred@fredlawl.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH 2/4] PCI: pciehp: Replace ctrl_*() with pci_*()
Message-ID: <20190427200301.tujp2535jxmlqttr@wunner.de>
References: <20190427191304.32502-1-fred@fredlawl.com>
 <20190427191304.32502-3-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427191304.32502-3-fred@fredlawl.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 27, 2019 at 02:13:02PM -0500, fred@fredlawl.com wrote:
> Hotplug useses custom ctrl_*() dev_*() printk wrappers for logging
> messages. To make hotplug conform to pci logging, replace uses of these
> wrappers with pci_*() printk wrappers. In addition, replace any
> printk() calls with pr_*() wrappers.

A lot of pciehp's messages are preceded by "Slot(%s): ", where %s is
replaced by the Physical Slot Number in the Slot Capabilities register
(which is cached in struct controller) plus an optional suffix if the
same PSN is used by multiple slots.  For some reason (probably a
historic artefact), this prefix is included only in *some* of the
messages.

I think it would be useful to make the messages consistent by *always*
including the "Slot(%s): " prefix.  However the prefix is unknown until
pci_hp_initialize() has been called.  I'd solve this by keeping the
ctrl_*() wrappers and amending them to print the "Slot(%s): " prefix,
then making sure that ctrl_*() is not called before pci_hp_initialize().
(pci_*() has to be used instead).


> @@ -182,39 +184,39 @@ static int pciehp_probe(struct pcie_device *dev)
>  
>  	if (!dev->port->subordinate) {
>  		/* Can happen if we run out of bus numbers during probe */
> -		dev_err(&dev->device,
> -			"Hotplug bridge without secondary bus, ignoring\n");
> +		pci_err(dev->port, "Hotplug bridge without secondary bus, ignoring\n");

Hm, the string was likely deliberately put on a new line to avoid
exceeding 80 chars, so I'd keep it that way.

Thanks,

Lukas
