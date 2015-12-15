Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:65232 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbbLOK4z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2015 05:56:55 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, rogerq@ti.com, nsekhar@ti.com,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	tony@atomide.com, t-kristo@ti.com
Subject: Re: [PATCH v3 0/9] phy: use syscon framework APIs to set ctrl mod reg
Date: Tue, 15 Dec 2015 11:56:34 +0100
Message-ID: <725110094.6UkMkcy8u7@wuerfel>
In-Reply-To: <1450170968-11282-1-git-send-email-kishon@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 15 December 2015 14:45:59 Kishon Vijay Abraham I wrote:
> This series is basically to deprecate using phy-omap-control and use
> syscon APIs to program the control module registers.
> 
> Changes from v2:
> No changes.
> 
> Changes from v1:
> *) cleanup ti_pipe3_probe in multiple steps
> *) other minor cleanups
> 
> Changes from [1] in PHY patches include
> *) cleanup ti_pipe3_probe
> *) have mask, power_on and power_off values in usb_phy_data for
>    omap-usb2 phy
> 
> The patches have been pushed to
>         git://git.ti.com/linux-phy/linux-phy.git syscon
> 
> [1] -> https://lkml.org/lkml/2015/6/23/189
> 
> All the testing was done both before applying the dt patches and after
> applying the dt patches (dt patches will be posted shortly).
> 

Can you explain here what the conversion is good for? Why do you
prefer the syscon mapping over a high-level driver in this case?

	Arnd
