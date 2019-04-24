Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E79C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10CD2175B
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AME1sDCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfDXTKc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:10:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39482 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbfDXTKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 15:10:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so6618488wmk.4;
        Wed, 24 Apr 2019 12:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=S/zxi2ylVDkqZZBbgyooXrxhGjXILZWxNPyecty54tU=;
        b=AME1sDCz7IsznAaDKCRLuMso2ULXcX84VgNd/onrA55lmWTjEfne7pilAe89L/ReV1
         YL9MkF8MqachlqSB3wJTEJH6MOv/gQGRB/O6DAvToz1PH+1DMgeNpO9tu88O2ydj0pnt
         kTJeApTO6c4GDURe1RXAU3UHmaMbKeM3+mEx1Ec/d8AQj61u9u1ioGmeWYVfwKvsSYDQ
         EotF34SOSdUwn1gBDqLatg2zIixPBW6W5UjcJteZumeVE0IWtAIalsL6g+2Ga9zeo+pp
         +2D73T8neDESABr59mxcT8taWO4ION6zMrpk16S+v+ncVCXBdCxaN+Tv7youENwXFOaQ
         4UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=S/zxi2ylVDkqZZBbgyooXrxhGjXILZWxNPyecty54tU=;
        b=EMZ9RW8eeovdBN15lZDL/wlodjNiGYof2z6AAHkawduJsu5Fya3F+DTW/YsS96qUuu
         7zB/9ieX51JUQO/2O+f6ovKDww7dpRXn9+HuVJcmsFkjnJ1cC5dAyCBjB1QjC2sxP7dJ
         rArEKsbW+2WJovOWCykivQ5iuL0tH0QiP5gI6qb38I+HEhOEvENHIvF1sfWjCRIp9V24
         GwvbCmUegmnUor95HkYnhbFwx43rdvn4BVAsuOHXycAgkfGzs5FVA8CRusY3Xkr5nDue
         nMXvhE32KgMugWNxWMpR+D2H0tssCoESCbSyNM58N7YaOycFXrEKnmkJ4CH0IKFsoPyT
         2CCg==
X-Gm-Message-State: APjAAAV8b0gIxFHMWlrjY4EFA7r5htx5pupTm8nhjWE93hHD0Ae+KfUp
        kwaSMXuxXUGFnPmFBFGn8ogkmb4Zjx7mhg==
X-Google-Smtp-Source: APXvYqwve8fzbjDfRoaAHshs/aKdK6nujPjOor6S8/pTST7pGm1teWfE5s7YlHOGCSqyrGCrLN3GMw==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr449512wma.120.1556133029543;
        Wed, 24 Apr 2019 12:10:29 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5? (p200300EA8BD45700C498EE8FFF0A13E5.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:c498:ee8f:ff0a:13e5])
        by smtp.googlemail.com with ESMTPSA id t17sm17020471wrr.26.2019.04.24.12.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:10:28 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/9] PCI: add help pci_dev_id
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD KFD" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER" 
        <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Message-ID: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Date:   Wed, 24 Apr 2019 21:10:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In several places in the kernel we find PCI_DEVID used like this:
PCI_DEVID(dev->bus->number, dev->devfn) Therefore create a helper
for it.

v2:
- apply the change to all affected places in the kernel

Heiner Kallweit (9):
  PCI: add helper pci_dev_id
  PCI: use helper pci_dev_id
  r8169: use new helper pci_dev_id
  powerpc/powernv/npu: use helper pci_dev_id
  drm/amdkfd: use helper pci_dev_id
  iommu/amd: use helper pci_dev_id
  iommu/vt-d: use helper pci_dev_id
  stmmac: pci: use helper pci_dev_id
  platform/chrome: chromeos_laptop: use helper pci_dev_id

 arch/powerpc/platforms/powernv/npu-dma.c         | 14 ++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c        |  3 +--
 drivers/iommu/amd_iommu.c                        |  2 +-
 drivers/iommu/intel-iommu.c                      |  2 +-
 drivers/iommu/intel_irq_remapping.c              |  2 +-
 drivers/net/ethernet/realtek/r8169.c             |  3 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c |  2 +-
 drivers/pci/msi.c                                |  6 +++---
 drivers/pci/search.c                             | 10 +++-------
 drivers/platform/chrome/chromeos_laptop.c        |  2 +-
 include/linux/pci.h                              |  5 +++++
 11 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.21.0

