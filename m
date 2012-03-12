Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:60748 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab2CLMG3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2012 08:06:29 -0400
Date: Mon, 12 Mar 2012 12:06:11 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Liam Girdwood <lrg@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Olof Johansson <olof@lixom.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
Message-ID: <20120312120610.GA14020@sirena.org.uk>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F59253D.7070100@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 08, 2012 at 02:31:41PM -0700, Stephen Warren wrote:
> On 03/08/2012 07:51 AM, Thierry Reding wrote:

> > +- vdd-supply: power supply for controller (1.05V)

> Should those *-supply properties really be optional? I got the
> impression talking to Mark in a different thread that all regulators
> should exist, although their implementation may be via a fixed
> regulator, with no GPIO, as determined by the board design.

Depends on the electronics, if the device can function without a supply
then it is OK for it to be optional.  This is moderately unusual but not
unknown.  It's obviously also OK to omit the supply if the system
doesn't use software regulators at all, though a kernel with regulator
support enabled would need to use dummy regulators to stub things out.
