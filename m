Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FECC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F3721738
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 01:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHdzOqg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfBTBUm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:20:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44358 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfBTBUm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 20:20:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id g1so37386830otj.11
        for <linux-pci@vger.kernel.org>; Tue, 19 Feb 2019 17:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwVfzA5qEKmENAU1dYIjLicS9rhaom/1BwT86yBFqKE=;
        b=rHdzOqg3/tPGmmOJQRkLZD/dI2BgB9iFYFUjjl8atGUm84nqj/HbFAuPN8Vkes5nfE
         etcfAyzvP4c6pKcg29xPJyMTKzxxm15VN2CU2umhHr1aTxsXI9WMSap2BEtugsZON6uI
         +AePX3JP/3YDcXtaxtxBCuf6Ey7MM8S9GrU9dDmFmhUkIF5D4WWJeU7D0LQYjf6z1YRt
         kwFcd2djaJbT/wxkqSdt/56DFuFxGEIE63Q35WVmRYs/F+BSlibLJqYzkakfzziDUCDC
         mOrFputR/Hp9Sdwwug8j4Kvt/PYNpRz9znLuTXZ58KjicYHVGvB+ipd+/xbgfhmexHtl
         vs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EwVfzA5qEKmENAU1dYIjLicS9rhaom/1BwT86yBFqKE=;
        b=armXktCuiCGqA9WvkLTiC4uJU9dpgNSKMsqZOguj3Cufoyci0AzxhASnOi6dzkZnUT
         LP+9la4ixrbGSOMDWDInO7Jo5nagJ/SRZ7XQM6z7q8sLbGD0h+I9+4CfvwafmoRuA22i
         djdYkhRRlgn35+ZAXhF8zMmR4V910gRtUCSEuk6wlgdB3aNT249oK2bxbVcHx7tSwUwz
         fcGxkCzptz9xH7D1gtBlhXwZTwa3CvQRtQc/vTVad0FJto8VZwHuhFK5JT44REG0qrLW
         euFKcAFZZiKa88/BRtnR+IST45JvHTyE0AioRzqITt88k+WZ91ZaPAnCwhkfGa/DDsK/
         NT9A==
X-Gm-Message-State: AHQUAubci5HVC7UgXKXyR04Gi5KYVH2VdR7lkTUcXBd87n2XkVODqZl0
        +tHVRDbN0UVucneimEL+CQE=
X-Google-Smtp-Source: AHgI3IZm0dwTXTO2YOVRcgdAM9DcxNNfLTX1UI+17CYvCGBFqJ10l5UzPqvcNNDW4X1biivfu0Agfg==
X-Received: by 2002:a9d:7841:: with SMTP id c1mr4050703otm.354.1550625640833;
        Tue, 19 Feb 2019 17:20:40 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id d67sm8000424oig.36.2019.02.19.17.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:20:39 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, linux-pci@vger.kernel.org,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH RFC v2 0/4] PCI: pciehp: Do not turn off slot if presence comes up after link
Date:   Tue, 19 Feb 2019 19:20:26 -0600
Message-Id: <20190220012031.10741-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the presence detect state (PDS) becomes active after the link
comes up (DLLLA), the hotplug code removes the device and then
re-loads the driver. For most devices, this is a mere inconvenience,
and for PCIe storage devices that are part of a RAID set which started
rebuilding, it can get fun.

Ideally, we wouldn't remove perfectly good devices. According to
the old PCIe spec PDS would always have to come up at or before DLLLA.
Since not everyone followed this (looking at you Dell and HPE!!!!),
this now got standardized in PCIe 4.0. (*).

This series has two solutions for this problem, and is intended to
serve as a bikeshedding point for which is better:
 1. Try to wait for PDS _before_ loading the driver
 2. Load as usual, and recognize the delayed PDS event as such

I think (2) is more generic and elegant, but a lot of people seem to
like something similar to (1).

(*) ECN was approved in Nov 2018, and is normative spec text. A lot of
the leaked PCIe 4.0 specs do not have this change.



Alexandru Gagniuc (4):
  PCI: hotplug: Add support for disabling in-band presence
  PCI: pciehp: Do not turn off slot if presence comes up after link
  PCI: hotplug: Wait for PDS when in-band presence is disabled
  PCI: hotplug: Add quirk For Dell nvme pcie switches

 drivers/pci/hotplug/pciehp.h      |  1 +
 drivers/pci/hotplug/pciehp_ctrl.c | 24 ++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 54 ++++++++++++++++++++++++++++++-
 include/linux/pci.h               |  1 +
 include/uapi/linux/pci_regs.h     |  2 ++
 5 files changed, 81 insertions(+), 1 deletion(-)

-- 
2.19.2

