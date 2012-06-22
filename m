Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53182 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab2FVRPE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 13:15:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Date: Fri, 22 Jun 2012 17:14:52 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <4FDA2DDA.1030704@wwwdotorg.org> <CAErSpo56=S2oQ0usYfH28T0178SQUBD=5jqmcKWCT6M5WUQF6g@mail.gmail.com> <201206221653.31817.arnd@arndb.de>
In-Reply-To: <201206221653.31817.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201206221714.53172.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 22 June 2012, Arnd Bergmann wrote:
> The part that is specific to PCs is that they don't have PCI domains
> normally.

Scratch that, PCs have moved on beyond that long ago, I just wasn't
aware that they also do that now. That was only true before mmconfig.

	Arnd
