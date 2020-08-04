Return-Path: <SRS0=QtGK=BO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E07C433E0
	for <linux-pci@archiver.kernel.org>; Tue,  4 Aug 2020 11:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B728A22CB2
	for <linux-pci@archiver.kernel.org>; Tue,  4 Aug 2020 11:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596542309;
	bh=GRPEMa4i2EecuG/m4i8ZL5jtyKDj8F4w3pVCw5RqUqs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kqnotcCFbrObl3/N0iqzsUOhqfq7MPgxVuCyAjEYfPg16HS4nvEy/4LxeHbnJ15H/
	 KNU1tJipuoL35UXzBkNeSjeMQDhDur5CyEY5LvGPZbXmJMfsCzTts4LjavTrksJQBF
	 c02WyMso5J5UCe/FumozZ0KdKQzIZcI7I9UfzYco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgHDL6R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730409AbgHDL6A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 07:58:00 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810B92086A;
        Tue,  4 Aug 2020 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596542280;
        bh=GRPEMa4i2EecuG/m4i8ZL5jtyKDj8F4w3pVCw5RqUqs=;
        h=From:To:Cc:Subject:Date:From;
        b=Ip5cIZPJHY6XVNx+cJudKc/bBK3vGZ6euyVPQUqFw3cOlwU6HWEp1IFil8zdJdf92
         oVebIyNB76328rcKqqjpcE9HbutNIACAhg5LHf31qCv3pmyAJMMbXAwhrEyk+/TQoM
         q+LADOBJWZksj5QYn3AgHwqt7bOA7pVX8KU1mffc=
Received: by pali.im (Postfix)
        id 2EF977FD; Tue,  4 Aug 2020 13:57:58 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v2 0/5] PCIe aardvark controller improvements
Date:   Tue,  4 Aug 2020 13:57:42 +0200
Message-Id: <20200804115747.7078-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

we have some more improvements for PCIe aardvark controller (Armada 3720
SOC - EspressoBIN and Turris MOX).

The main improvement is that with these patches the driver can be compiled
as a module, and can be reloaded at runtime.

This series applies on top of Linus' master branch.

Marek & Pali


Changes in V2 for patch 4/5:
* Protect pci_stop_root_bus() and pci_remove_root_bus() function calls by
  pci_lock_rescan_remove() and pci_unlock_rescan_remove()


Pali Rohár (5):
  PCI: aardvark: Fix compilation on s390
  PCI: aardvark: Check for errors from pci_bridge_emul_init() call
  PCI: pci-bridge-emul: Export API functions
  PCI: aardvark: Implement driver 'remove' function and allow to build
    it as module
  PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()

 drivers/pci/controller/Kconfig        |   2 +-
 drivers/pci/controller/pci-aardvark.c | 104 ++++++++++++++++----------
 drivers/pci/pci-bridge-emul.c         |   4 +
 3 files changed, 71 insertions(+), 39 deletions(-)

-- 
2.20.1

