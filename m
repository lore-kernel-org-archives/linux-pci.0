Return-Path: <SRS0=1yZ1=4U=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B25C3F2CD
	for <linux-pci@archiver.kernel.org>; Tue,  3 Mar 2020 03:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA552465E
	for <linux-pci@archiver.kernel.org>; Tue,  3 Mar 2020 03:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCCDl4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:41:56 -0500
Received: from yyz.mikelr.com ([170.75.163.43]:57142 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgCCDl4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 22:41:56 -0500
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 7D0933CF20;
        Mon,  2 Mar 2020 22:35:02 -0500 (EST)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Mikel Rychliski <mikel@mikelr.com>
Subject: [PATCH 0/4] Fix loading of radeon BIOS from 32-bit EFI
Date:   Mon,  2 Mar 2020 22:34:53 -0500
Message-Id: <20200303033457.12180-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set fixes an opps when loading the radeon driver on old Macs
with a 32-bit EFI implementation.

Tested on a MacPro 1,1 with a Radeon X1900 XT card and 32-bit kernel.

Mikel Rychliski (4):
  drm/radeon: Stop directly referencing iomem
  PCI: Use ioremap, not phys_to_virt for platform rom
  drm/radeon: iounmap unused mapping
  drm/amdgpu: iounmap unused mapping

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c |  1 +
 drivers/gpu/drm/radeon/radeon_bios.c     | 12 ++++++++----
 drivers/pci/rom.c                        |  5 ++---
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.13.7

