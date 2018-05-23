Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:30112 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934223AbeEWTjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 15:39:00 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 0/5] add missing of_node_put
Date: Wed, 23 May 2018 21:07:11 +0200
Message-Id: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

---

 drivers/gpu/drm/rockchip/rockchip_lvds.c   |    4 +++-
 drivers/pci/hotplug/pnv_php.c              |    8 ++++++--
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c |    9 +++++++--
 drivers/pinctrl/pinctrl-at91-pio4.c        |    4 +++-
 drivers/soc/ti/knav_dma.c                  |    1 +
 5 files changed, 20 insertions(+), 6 deletions(-)
