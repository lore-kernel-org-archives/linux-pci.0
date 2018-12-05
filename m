Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51846C04EB9
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C902F213A2
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 09:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C902F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeLEJsV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:48:21 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:53461 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbeLEJsV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2018 04:48:21 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6304C280021B4;
        Wed,  5 Dec 2018 10:48:18 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 1F62C24531; Wed,  5 Dec 2018 10:48:18 +0100 (CET)
Date:   Wed, 5 Dec 2018 10:48:18 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181205094818.jmdy2mg6b6is7jy3@wunner.de>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
 <20181204204049.4zr7onei267t4pic@wunner.de>
 <20181205092034.GI2469@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205092034.GI2469@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 05, 2018 at 11:20:34AM +0200, Mika Westerberg wrote:
> On Tue, Dec 04, 2018 at 09:40:49PM +0100, Lukas Wunner wrote:
> > > I wonder if our pci_bridge_d3_possible() heuristics would need to be
> > > refined somehow? At least if this blacklist starts growing.
> > 
> > We do blacklist such non-native hotplug ports, but of course only if
> > the Hot-Plug Capable bit is set:
> > 
> > 	/*
> > 	 * Hotplug ports handled by firmware in System Management Mode
> > 	 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
> > 	 */
> > 	if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
> > 		return false;
> > 
> > I guess your question boils down to, is there any better way to recognize
> > ports which are handled by the platform firmware?
> > Does acpiphp bind to this port?
> 
> It does, yes but AFAIK it binds to any PCI bus (bridge) if it has an
> ACPI companion.

Does the root port have a _RMV and/or _SUN object?  We could e.g.
disallow runtime PM for any bridge with _RMV present and the HPC
bit not set in the Slot Capabilities.

This could be checked by extending acpi_pci_bridge_d3() to return
either true, false or a "don't know" value.  Or by adding another
platform_pci_bridge_no_d3() hook.

Thanks,

Lukas
