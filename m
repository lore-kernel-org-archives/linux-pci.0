Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:45825 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbcKIAFm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Nov 2016 19:05:42 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Add new resets for pcie-rockchip
Date: Wed, 09 Nov 2016 01:05:15 +0100
Message-ID: <3680897.9Plsy7nyC8@phil>
In-Reply-To: <1477017836-19317-1-git-send-email-shawn.lin@rock-chips.com>
References: <1477017836-19317-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Björn,

Am Freitag, 21. Oktober 2016, 10:43:54 CET schrieb Shawn Lin:
> Hi Bjorn and Heiko,
> 
> Sorry for updating pcie-rockchip so frequently under this development
> cycle. This patch is going to fix a urgent issue of missing control for
> pm_rst, aclk_rst and pclk_rst. These three resets was controlled by rom code
> but now the driver will take over it in order to solve some weird issues
> found by MP test. Thanks to that it is still under MP test internally, so
> the backward compatibility of dtb won't be a big deal.

could you take a look at these patches and maybe think about including them 
still for 4.9?


Thanks
Heiko
