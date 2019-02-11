Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F2C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9122186A
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549925736;
	bh=lOZXT8YIPI6htqvmb4jtkxl1KNDEcGde/eZzjKZoS+Q=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=O7ovoj2kUnuitPSVYiAmNumH7Y8WutQaxIFbjr7Ms/XUXV29n2KE9N9VdbNnZ22HL
	 gekUiV3nVnzwnjQmrjkr9hpOWjl4Cv62owvDIcTxoWJ8qd2aAnakzX7gJpOO/stmXG
	 r9KWf2pdt4rY7Hwg2e5+6imMbvA7QgoXFpqkzu1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfBKWzf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:55:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbfBKWze (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 17:55:34 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1120E2083B;
        Mon, 11 Feb 2019 22:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549925734;
        bh=lOZXT8YIPI6htqvmb4jtkxl1KNDEcGde/eZzjKZoS+Q=;
        h=Subject:From:To:Cc:Date:From;
        b=v2+aAavG7IxY4oOH3gdKFMwddVd2pZhfv2pV1lzB75s6AIFteLAbq0Iys9BLaUg4e
         QEcwnb92wO859G5KaDnp2YHMdFNQN0fiXRvo/Cl/s/Cf32YpE6XCAc3w911Zo8XzAw
         f40YoxlAkvS4O8JSGyW5zG4+FUwjFqAqkCs6cCyo=
Subject: [PATCH v1 0/2] PCI/ASPM: Fix LTR issues
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     RussianNeuroMancer <russianneuromancer@ya.ru>,
        David Ward <david.ward@ll.mit.edu>,
        Frederick Lawler <fred@fredlawl.com>,
        Patrick Talbert <ptalbert@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Feb 2019 16:55:33 -0600
Message-ID: <154992561743.7864.14353823538864422094.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These are to fix a couple LTR-related issues found while investigating
https://bugzilla.kernel.org/show_bug.cgi?id=201469

I don't claim that these fix the whole problem of that bugzilla, but I
think it's pretty clear that these are problems we need to fix, so I want
to give these a little more exposure.

Feedback welcome!

---

Bjorn Helgaas (2):
      PCI/ASPM: Use LTR if already enabled by platform
      PCI/ASPM: Save LTR Capability for suspend/resume


 drivers/pci/pci.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/pci/probe.c |   36 ++++++++++++++++++++++-------------
 2 files changed, 74 insertions(+), 15 deletions(-)
