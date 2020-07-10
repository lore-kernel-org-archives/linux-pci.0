Return-Path: <SRS0=O/bX=AV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D5C433E0
	for <linux-pci@archiver.kernel.org>; Fri, 10 Jul 2020 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736FB2077D
	for <linux-pci@archiver.kernel.org>; Fri, 10 Jul 2020 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594417085;
	bh=QoCZFKF2UTzyJ9vgHFjXLtf6wU4eMddh+PZbc+OUfyA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2uE6X8sEvUu1jJ+8+n+KNCWpd8mgFaOm2QHYSbvCgYWvOekmUR1lW1ceazUtaSIUc
	 p1rts0J1y+pL9VmHXDXbHjdvcfWSnNfUfqG1d7jgI4ZeXDEfxdlGcYyy2Q0kcJnqxq
	 03psEzuurq+I0L/Pu2NSExaYHtOgbD0VdL0RQFU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGJViB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgGJViB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 17:38:01 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF71206C3;
        Fri, 10 Jul 2020 21:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594417081;
        bh=QoCZFKF2UTzyJ9vgHFjXLtf6wU4eMddh+PZbc+OUfyA=;
        h=From:To:Cc:Subject:Date:From;
        b=oYMFYtSZF9JDrt+eB3t5VsnMWTsg7BPD7EH4m91z0JM6MH08/11kJavgsAlIbhzJZ
         paBMMfRvn/42ZM01UvoniCHNE393zn6QIEmudN7MBNV4ziOnNUmTSWnNPRKfPXeNur
         7FpIzX3YVIzRdwW6ueECMsSgTsXxVK2WSJWynC3k=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI/ACPI: Unexport pci_root.c functions
Date:   Fri, 10 Jul 2020 16:37:51 -0500
Message-Id: <20200710213753.83420-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Unexport a couple functions that are no longer needed by modules.

Bjorn Helgaas (2):
  PCI/ACPI: Unexport acpi_pci_osc_control_set()
  PCI/ACPI: Unexport acpi_pci_find_root()

 drivers/acpi/pci_root.c | 5 ++---
 include/linux/acpi.h    | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)


base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
2.25.1

