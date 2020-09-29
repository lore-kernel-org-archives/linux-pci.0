Return-Path: <SRS0=Yaiz=DG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81C0C47423
	for <linux-pci@archiver.kernel.org>; Tue, 29 Sep 2020 19:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7942083B
	for <linux-pci@archiver.kernel.org>; Tue, 29 Sep 2020 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601408886;
	bh=OepUqFYSyfxPeyg5IbfQ0vvcsfRWrCczcufS38EXWQc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QayrE/LexcRYha5p3sf8xsXDVBaEXNn3ce5cFMwpr73xx15RYOFaY5nohI0SY8kYz
	 xMbeiPgjYM941QjFij1xngjWnHumfwThW+MU9H6AEuORXYEsmoQAHCJYAoDsf1lKKQ
	 ppFVcyTzhsrNhtwk3B3LIZYEVOd99287BZEDtkY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgI2TsF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbgI2TsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 15:48:05 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510BC20774;
        Tue, 29 Sep 2020 19:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601408884;
        bh=OepUqFYSyfxPeyg5IbfQ0vvcsfRWrCczcufS38EXWQc=;
        h=From:To:Cc:Subject:Date:From;
        b=jrtcliWRAe0dfTCiWmlvgCdjqx+lYUxzH40MZhxXGkbBseLvdJUuL/QVb6/ATstO/
         EyO8geD4X+0zQQ1CXaT4HbpmI9ROULsuN4PwIwyXOWRDlaBy9rBA/PNm5H0HkDbTC4
         xLWATfQ8FK8ULzxUZU+h9IAsFqD5aAigv3K0inxU=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI/PM: Fix D2 transition delay
Date:   Tue, 29 Sep 2020 14:47:46 -0500
Message-Id: <20200929194748.2566828-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove an unused #define.

Fix the D2 transition delay.  I changed this a year ago to conform to the
PCIe r5.0 spec, but I think the number I relied on is a typo in the spec.
I asked the PCI-SIG to fix the typo.  Hopefully I'll get a response before
the merge window.

Bjorn Helgaas (2):
  PCI/PM: Remove unused PCI_PM_BUS_WAIT
  PCI/PM: Revert "PCI/PM: Apply D2 delay as milliseconds, not
    microseconds"

 drivers/pci/pci.c | 2 +-
 drivers/pci/pci.h | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.25.1

