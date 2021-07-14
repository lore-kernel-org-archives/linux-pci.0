Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53634C07E9C
	for <linux-pci@archiver.kernel.org>; Wed, 14 Jul 2021 08:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B63861361
	for <linux-pci@archiver.kernel.org>; Wed, 14 Jul 2021 08:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbhGNI6O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbhGNI6O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 04:58:14 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4375C06175F;
        Wed, 14 Jul 2021 01:55:21 -0700 (PDT)
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de [79.242.177.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 768882DF;
        Wed, 14 Jul 2021 10:55:19 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 0/2] PCI/ACPI: Simplify PCIe _OSC feature negotiation
Date:   Wed, 14 Jul 2021 10:55:10 +0200
Message-Id: <20210714085512.2176-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

here is the second version of my patch(es) to simplify the _OSC
negotiation of PCIe features between Linux and the firmware.

The main part is in patch 1, which removes the _OSC call for supported
features by merging it with the actuall _OSC call to negotiate the
features with the firmware.

This allows some simplifications of the code, notably the removal of
the acpi_pci_osc_support() function and the control=NULL special
casing in the acpi_pci_query_osc() function.

Please review.

Thanks,

	Joerg

Joerg Roedel (2):
  PCI/APCI: Move acpi_pci_osc_support() check to negotiation phase
  PCI/ACPI: Remove OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS

 drivers/acpi/pci_root.c | 116 ++++++++++++++++++----------------------
 include/linux/acpi.h    |   2 -
 2 files changed, 52 insertions(+), 66 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.31.1

