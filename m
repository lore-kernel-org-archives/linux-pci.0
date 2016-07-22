Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34276 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbcGVUjq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2016 16:39:46 -0400
Received: by mail-pa0-f52.google.com with SMTP id fi15so42619592pac.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2016 13:39:46 -0700 (PDT)
Date: Fri, 22 Jul 2016 13:39:42 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
Message-ID: <20160722203941.GA58807@google.com>
References: <1468802533-17699-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468802533-17699-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 18, 2016 at 08:42:12AM +0800, Shawn Lin wrote:
> This patch adds a binding that describes the Rockchip PCIe controller
> found on Rockchip SoCs PCIe interface.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Brian Norris <briannorris@chromium.org>
