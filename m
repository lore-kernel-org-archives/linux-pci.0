Return-Path: <SRS0=WZ4f=NE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F71ECDE46
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 22:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A8A20831
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 22:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl0op/x6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A8A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeJYGnw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbeJYGnw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 02:43:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8DD2075D;
        Wed, 24 Oct 2018 22:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540419240;
        bh=I0/HoZy/5Qtiq/LDZOlUyb8v4svXUYh+DkT8SAyu4P0=;
        h=Subject:From:To:Cc:Date:From;
        b=Rl0op/x6cUBgIJQhh1nAguCg9QcZshQZaLDqtLqAWNUxe6wWLjIa/j1N3dL3IA44X
         r52Z8A99UEx2EoLwxzHBWPD+GVGnVqdtuqw6c7oFBunsqNjnLWJ0RJzuV8lNy3nJv5
         73kG9wivHgOVNkHRBPxLCRmGClsHgVgzfk5EHWVY=
Subject: [PATCH] MAINTAINERS: Add x86 early-quirks.c file pattern to PCI
 subsystem
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 17:13:59 -0500
Message-ID: <154041923937.26247.17083948926896599419.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

arch/x86/kernel/early-quirks.c contains special PCI quirks that need to
run even before the usual DECLARE_PCI_FIXUP_EARLY() quirks.  These have
typically been merged by the x86 maintainers, which is fine, but PCI folks
should at least see what's happening, so add a file pattern to the PCI
subsystem entry.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..63cb7f3dbbb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11249,6 +11249,7 @@ F:	include/uapi/linux/pci*
 F:	lib/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
+F:	arch/x86/kernel/early-quirks.c
 
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

