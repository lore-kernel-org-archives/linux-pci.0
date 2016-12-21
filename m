Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:38943 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbcLUKTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2016 05:19:04 -0500
Date: Wed, 21 Dec 2016 11:19:15 +0100
From: Lukas Wunner <lukas@wunner.de>
To: John Crispin <john@phrozen.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH] pci: add kernel config option for disabling common PCI
 quirks
Message-ID: <20161221101915.GC14781@wunner.de>
References: <1482306784-29224-1-git-send-email-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482306784-29224-1-git-send-email-john@phrozen.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 21, 2016 at 08:53:04AM +0100, John Crispin wrote:
> From: Gabor Juhos <juhosg@openwrt.org>
> 
> These quirks do not effect small small plastic routers. These routers tend
> to have very little flash space. This patch adds a new option that allows
> us to build a kernel without including the common quirks, thus saving us
> valuable flash space.
> 
> When building an image for a MIPS/Ralink router with this option enabled
> it will reduce the size of an uncompressed uImage by 12KB.

There's already a PCI_QUIRKS config option defined in init/Kconfig,
why isn't this sufficient?  Do you want *some* quirks but not others?

Thanks,

Lukas
