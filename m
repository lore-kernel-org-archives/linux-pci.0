Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8728DC3DA66
	for <linux-pci@archiver.kernel.org>; Fri, 25 Aug 2023 06:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbjHYG14 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Aug 2023 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbjHYG1b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 02:27:31 -0400
Received: from out-56.mta1.migadu.com (out-56.mta1.migadu.com [95.215.58.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F11BF0
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 23:27:28 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692944846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z6lCf1m2RyO5hkgphNEZhqasAxN18arSPKN7RCy/gyY=;
        b=sioG6nFDTUAy8CFxpG2MThcPbp+5KyEr17L9Uls/hwtb2QPUXiazjl+Brl/nDImrMd+Hpl
        fDCVMataoUSDuIWTtNcfkr1kXbnEtIKwI7qjJqfvu4pQwod98SEZV7YZHEqi36V1RaNbfM
        u1kUllzdxvMc3XelSI1oDxUiV4dxKQM=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 0/5] Add the pci_get_base_class() helper and use it
Date:   Fri, 25 Aug 2023 14:27:09 +0800
Message-Id: <20230825062714.6325-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

There is no function that can be used to get all PCI(e) devices in a
system by matching against its the PCI base class code only, while keep
the sub-class code and the programming interface ignored. Therefore, add
the pci_get_base_class() function to suit the need.

For example, if an application want to process all PCI(e) display devices
in a system, it can achieve such goal by writing the code as following:

    pdev = NULL;
    do {
        pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev);
        if (!pdev)
            break;

        do_something_for_pci_display_device(pdev);
    } while (1);

Sui Jingfeng (5):
  PCI: Add the pci_get_base_class() helper
  ALSA: hda/intel: Use pci_get_base_class() to reduce duplicated code
  drm/nouveau: Use pci_get_base_class() to reduce duplicated code
  drm/amdgpu: Use pci_get_base_class() to reduce duplicated code
  drm/radeon: Use pci_get_base_class() to reduce duplicated code

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 20 ++++-----------
 drivers/gpu/drm/nouveau/nouveau_acpi.c   | 11 +++------
 drivers/gpu/drm/radeon/radeon_bios.c     | 20 ++++-----------
 drivers/pci/search.c                     | 31 ++++++++++++++++++++++++
 include/linux/pci.h                      |  5 ++++
 sound/pci/hda/hda_intel.c                | 16 ++++--------
 7 files changed, 59 insertions(+), 55 deletions(-)

-- 
2.34.1

