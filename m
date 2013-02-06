Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:53463 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab3BFQiU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 11:38:20 -0500
Received: by mail-ie0-f176.google.com with SMTP id k13so2133735iea.7
        for <linux-pci@vger.kernel.org>; Wed, 06 Feb 2013 08:38:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1357764194-12677-7-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
	<1357764194-12677-7-git-send-email-thierry.reding@avionic-design.de>
Date: Wed, 6 Feb 2013 17:38:20 +0100
Message-ID: <CACRpkdYV5w6BksUjXvXs=88BovUyXgRt-vXSD0twjRpzbZcvFQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] ARM: pci: Keep pci_common_init() around after init
From: Linus Walleij <linus.walleij@linaro.org>
To: Thierry Reding <thierry.reding@avionic-design.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-tegra@vger.kernel.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Murray <andrew.murray@arm.com>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 9, 2013 at 9:43 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:

> When using deferred driver probing, PCI host controller drivers may
> actually require this function after the init stage.
>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

There seem to be a proliferation of these patches now.

Isn't this just papering over the real problem? The discarding
of __init sections need to happen *after* all deferred probes
are complete, lest we have to remove *all* __init sections from
*all* drivers in the kernel, don't we?

Yours,
Linus Walleij
