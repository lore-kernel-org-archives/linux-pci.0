Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFACCCA486
	for <linux-pci@archiver.kernel.org>; Wed,  8 Jun 2022 01:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbiFHBC5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588476AbiFGXyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 19:54:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5EE44A07;
        Tue,  7 Jun 2022 16:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 037FBB82475;
        Tue,  7 Jun 2022 23:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CB1C3411E;
        Tue,  7 Jun 2022 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654643476;
        bh=oVYqK/0JGUVxA40hqtkxUoCBbKWyupsiiQCi9jG6aqM=;
        h=From:To:Cc:Subject:Date:From;
        b=TODwYeDxp3rkB9pChXaGC6C2OJWJtQMiJjapUpvVZFHb2Z/f2eOJr+5QFq/iGJnhr
         xDN4F+xgtWDlidfpsbNlobeXiJRHngrRcsmlz48zMKUd9i2IYPbwhCcX8WQb11toj0
         QzoqtyqdCY0f/TI5/eJwGxxV2m5EMjLT/qsnIYd3vCMcZTcPGBFd3WCPbEHNtzH15G
         35jNS/UsCwKt+gJiFOrFEMl/V8Z2rD1z/IYfbjuTBPVtGIdYkRYoOLjyhU1Io07GCx
         jAqJAyjG/6nacyW68E25sNFF8mJ4c3JJsDPpWQT3xGHJVSo/YqDON12im/kvOJXZ2s
         JtDZt0U6ti1Jw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] video: fbdev: Convert from PCI to generic power management
Date:   Tue,  7 Jun 2022 18:11:10 -0500
Message-Id: <20220607231112.354165-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

PCI-specific power management (pci_driver.suspend and pci_driver.resume) is
deprecated.  If drivers implement power management, they should use the
generic power management framework, not the PCI-specific hooks.

No fbdev drivers actually implement PCI power management, but there are a
cirrusfb has some commented-out references to it and skeletonfb has
examples of it.  Remove these.

Bjorn Helgaas (2):
  video: fbdev: cirrusfb: Remove useless reference to PCI power
    management
  video: fbdev: skeletonfb: Convert to generic power management

 drivers/video/fbdev/cirrusfb.c   |  6 ------
 drivers/video/fbdev/skeletonfb.c | 13 +++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

-- 
2.25.1

