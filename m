Return-Path: <SRS0=VK9V=S5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB3CC43218
	for <linux-pci@archiver.kernel.org>; Sat, 27 Apr 2019 19:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13A0212F5
	for <linux-pci@archiver.kernel.org>; Sat, 27 Apr 2019 19:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="PoiIWk5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfD0TNN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:13:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41752 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TNN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Apr 2019 15:13:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id v23so5346769oif.8
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2019 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=eTIIevnGbywDzoALYamaP3HztM1TpmwOzPz93oeTM94=;
        b=PoiIWk5yvC8UYzKgx1IxEQG+tSHY7eBX3jYAT5n3LYbNcKn3Mx5JAyguk9L6OlaJE+
         /n84tyUGmg8H810IxGQqeLwE2+r6EP9ga7XKx5582tpopEzy/1X/8jplC5+Nhg4cMekv
         WODd+SlO5UyjnCy5FRf1KJ+cUKAkcNAhb8t2/DvzKvBUviZQj9Iq+cI4sg3OPMDt/CLs
         HoOGEOB6j2L+ZyzDi/7GibkxmOLrb3v21xQoAQEq+sVrVohLWAkFdZ395QjccAt3kpeb
         zUi9SvC+Je7hP/3OMsgHUZ26UCiZ80Umfkpeksk6LFxmYC+ysNkTWVkURzoBdANrtMeD
         vGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eTIIevnGbywDzoALYamaP3HztM1TpmwOzPz93oeTM94=;
        b=suzkwdHfCc5xfEG99H6nLRd74z7alK8/p//JkryDFzW4AKAF5YixhXdrO/M3bTaVLM
         fv6rVF99UDYc1SWWuug+zn7gLBuGiyajNRbMLsZBD22GHPdM8V0rGjhwYfnQ+scBabaE
         FfPDTfbvqtHgA62hPurnA02Cpt1GuOdyW1RbUD1gVegS3KNIlqB+vp/l5WlKc7+PQazI
         6hEaaeEVQJMXCcP7Lb5Ch+t7Ln2OLVvfBkbT4uI4Rkt3Kx+DQfYYqOqH44u17+WLnVYe
         SUM+GZRI3AbP5cFiYxirtIKcXlrOnWJ9mkrIyV8HWSMp2lCNlFwpHFmBAmto+TSWbf4k
         4jDg==
X-Gm-Message-State: APjAAAVHQbYo1Rdunyh32hXiUAWOuaxubI0r6dNs1AQaQcQMiChTr6Ks
        EVRIlJ91IggWiw69Vtlv1zkD6A==
X-Google-Smtp-Source: APXvYqyDzpCDVOm0Dg6UA+JdPS37uvTTrbHu3Iw/0UvX/maTUQvPFAEJU0sMFdKHonMvdY5HWQpU0Q==
X-Received: by 2002:aca:efc6:: with SMTP id n189mr11741429oih.34.1556392392697;
        Sat, 27 Apr 2019 12:13:12 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:3d43:9acc:6ecc:a72c])
        by smtp.gmail.com with ESMTPSA id b133sm5768473oia.0.2019.04.27.12.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 12:13:11 -0700 (PDT)
From:   fred@fredlawl.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH 0/4] PCI: Use PCIe service name in dmesg logs
Date:   Sat, 27 Apr 2019 14:13:00 -0500
Message-Id: <20190427191304.32502-1-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frederick Lawler <fred@fredlawl.com>

In referrence to [1], PCIe services did not have unifrom logging via pci_*()
printk wrappers. This patch series first replaces left over dev_*() calls
for port services. Then, replaces all hotplug ctrl_*() calls with pci_*() to
bring hotplug in line with the other services, and removes the custom
ctrl_*() definitions. Lastly, to satisfy [1], add in dev_fmt()'s to each of
the services.

1. https://lore.kernel.org/linux-pci/20190308180149.GD214730@google.com/

Frederick Lawler (4):
  PCI: Replace dev_*() printk wrappers with pci_*() printk wrappers
  PCI: pciehp: Replace ctrl_*() with pci_*()
  PCI: pciehp: Remove unused macro definitions
  PCI/portdrv: Add dev_fmt() to port drivers

 drivers/pci/hotplug/pciehp.h       |  27 -----
 drivers/pci/hotplug/pciehp_core.c  |  25 +++--
 drivers/pci/hotplug/pciehp_ctrl.c  |  88 +++++++++--------
 drivers/pci/hotplug/pciehp_hpc.c   | 154 ++++++++++++++++-------------
 drivers/pci/hotplug/pciehp_pci.c   |  12 ++-
 drivers/pci/pcie/aer.c             |  16 +--
 drivers/pci/pcie/aer_inject.c      |   6 +-
 drivers/pci/pcie/bw_notification.c |   2 +
 drivers/pci/pcie/dpc.c             |  29 +++---
 drivers/pci/pcie/pme.c             |   2 +
 10 files changed, 187 insertions(+), 174 deletions(-)

--
2.17.1

