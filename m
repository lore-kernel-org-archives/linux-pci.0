Return-Path: <SRS0=n3kO=DW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981BAC433DF
	for <linux-pci@archiver.kernel.org>; Thu, 15 Oct 2020 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A0420723
	for <linux-pci@archiver.kernel.org>; Thu, 15 Oct 2020 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602790251;
	bh=uGd3N51P55pQ1K1Hli7gxESlLKUl3JZeqQQT9+/+MtE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=i09RoihEYQRGPBfMeEWHK6EMAzZvc7v3dbXLe5RTpsj3GwpvB0ZchCdymX+i4f5lp
	 UmW5hUZoctP6/HfSqTjZ4BlFivad53rwNEU6vIvcbO/Yyh9Q/8ejeSb2N5/fcBUTRr
	 +sFYZn/w1D8/d66XOnB2srn+V5OUdE9CQmpSUIF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391614AbgJOTau (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391577AbgJOTas (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:30:48 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75129206DC;
        Thu, 15 Oct 2020 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790247;
        bh=uGd3N51P55pQ1K1Hli7gxESlLKUl3JZeqQQT9+/+MtE=;
        h=From:To:Cc:Subject:Date:From;
        b=PAWlkyGMiZUttIFS1FXCL29PFCMBq6fV+NT6U+MP6Yv3ng/LtZCkhYVjSv7FeEUo2
         Qxg9S/TPHCTIm00dzU+KbjEzV7X3UI5lEPAkISo8P+xHaqj2sqaFEhXgP9cb/mFRKZ
         12vwSa97qws1DiqEM0HXPtyvntPGJz3XkD9XnkGY=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 00/12] PCI/ASPM: Cleanup
Date:   Thu, 15 Oct 2020 14:30:27 -0500
Message-Id: <20201015193039.12585-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is a v3 posting of Saheed's ASPM cleanup.

The intent is that this is strictly cleanup, no functional changes at all.
We want to simplify the code by removing struct aspm_register_info and
pcie_get_aspm_reg().  These are only used to read and store register info,
but the info is only used in one place, so the function and struct only
make things more complicated.

Previous postings:

v2: https://lore.kernel.org/r/20200924142443.260861-2-refactormyself@gmail.com
v1: https://lore.kernel.org/r/20200923231517.221310-1-refactormyself@gmail.com

Bjorn Helgaas (5):
  PCI/ASPM: Move pci_clear_and_set_dword() earlier
  PCI/ASPM: Move LTR path check to where it's used
  PCI/ASPM: Use 'parent' and 'child' for readability
  PCI/ASPM: Remove struct aspm_register_info.l1ss_ctl2 (unused)
  PCI/ASPM: Pass L1SS Capabilities value, not struct aspm_register_info

Saheed O. Bolarinwa (7):
  PCI/ASPM: Remove struct aspm_register_info.support
  PCI/ASPM: Remove struct aspm_register_info.enabled
  PCI/ASPM: Remove struct aspm_register_info.latency_encoding
  PCI/ASPM: Remove struct aspm_register_info.l1ss_cap_ptr
  PCI/ASPM: Remove struct aspm_register_info.l1ss_ctl1
  PCI/ASPM: Remove struct aspm_register_info.l1ss_cap
  PCI/ASPM: Remove struct pcie_link_state.l1ss

 drivers/pci/pcie/aspm.c       | 265 +++++++++++++++-------------------
 drivers/pci/probe.c           |   3 +
 include/linux/pci.h           |   1 +
 include/uapi/linux/pci_regs.h |   2 +
 4 files changed, 120 insertions(+), 151 deletions(-)

-- 
2.25.1

