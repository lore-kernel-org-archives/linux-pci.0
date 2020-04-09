Return-Path: <SRS0=pSR+=5Z=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61AFC2BB85
	for <linux-pci@archiver.kernel.org>; Thu,  9 Apr 2020 23:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1C120857
	for <linux-pci@archiver.kernel.org>; Thu,  9 Apr 2020 23:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586476168;
	bh=X3abJTAvL1x3DKzgChxHThZ88Jih8wp8BIPYIK9bQnE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uWMvWoCkG5Z0+u0ZoKvHr4z23N94xmhkbTPAREf0cy9Q1SahOezaFttV90wn1QNKl
	 UE7mUItxKxmJHE7J0/ek48cfn1vSr4HeH4H9VX3mkRmna4FbrFTn+h3k24ic037cLf
	 a/z12S6/WwIx2O1WU0dkQSab+so3rFO6IYfihRaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgDIXt1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:49:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43570 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgDIXt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 19:49:27 -0400
Received: by mail-io1-f68.google.com with SMTP id u2so183436iop.10;
        Thu, 09 Apr 2020 16:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9eaq0H8oGg8K4IrgPtJPslJKNTLiRXhsyT2mSt9uHg=;
        b=LEHlijWAgaGdufMN+SLouCAfFPyGh0WZRwh/a7PLOfnQMBZRiy1ETT4TKA24SYxydN
         kGT64cVMIsrrvsQrSV6xlbFxH1SvhbwTWPBgXdiecQ4LQyH4BK1L/1QOfZXuD1oplX+w
         XiMqGpdaOtXwWZM60GL894falVj1ToAptxErAoyu2CNu6rs76b7c2l51mUPcOnUKAX35
         2l82d1UuEj71tAvG8VqYikmvE7VRyyopE25aH11XDTjul5JSfWiDntIPfG+1t62JzICi
         BAdDimvTQXuvGceSS/LRxOiZ00si90Tc6M2nPVisX1k+9oLOgnGG2fnTnr6i8QH4O43o
         VJ/w==
X-Gm-Message-State: AGi0Pua4ZqXc6KvG1INe0A/wl4mPFPJZLaEgCnLABrDG7K3qBEKYUOFM
        SEuKGjD26M0WIhRBUGCW2Q==
X-Google-Smtp-Source: APiQypIdiMtTCZPPD7LTx2QITtk9ZR5KlqXELktIFYlBTigIR35XweuEgwpB2TujFJ6toR/nxp9cGQ==
X-Received: by 2002:a6b:b512:: with SMTP id e18mr1774396iof.168.1586476167109;
        Thu, 09 Apr 2020 16:49:27 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id w7sm93416ior.51.2020.04.09.16.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 16:49:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mans Rullgard <mans@mansr.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Robert Richter <rrichter@marvell.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Toan Le <toan@os.amperecomputing.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCI: Modularize host-generic
Date:   Thu,  9 Apr 2020 17:49:20 -0600
Message-Id: <20200409234923.21598-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is part of a larger effort to modularize ARCH_VEXPRESS. In
particular, the Arm FVP platforms use the host-generic driver. This
conversion was straight-forward. I didn't convert the other ECAM drivers
using host-common to modules, but am happy to do so if there's a strong
desire to do so.

In the process, I noticed that 'const' was being dropped from the match
table .data pointer, so the first patch constifies struct pci_ecam_ops.
I started trying to constify pci_ops too, but that became a never ending
treewide rabbit hole. So I ended up with a cast when we assign pci_ops
from pci_ecam_ops.

Rob


Rob Herring (3):
  PCI: Constify struct pci_ecam_ops
  PCI: host-generic: Support building as modules
  PCI: host-generic: Eliminate pci_host_common_probe wrappers

 arch/arm64/kernel/pci.c                   |  4 ++--
 drivers/acpi/pci_mcfg.c                   |  8 +++----
 drivers/pci/controller/Kconfig            |  4 ++--
 drivers/pci/controller/dwc/pcie-al.c      |  2 +-
 drivers/pci/controller/dwc/pcie-hisi.c    | 19 +++++------------
 drivers/pci/controller/pci-host-common.c  | 18 ++++++++++++----
 drivers/pci/controller/pci-host-generic.c | 26 +++++++----------------
 drivers/pci/controller/pci-thunder-ecam.c | 14 ++++++------
 drivers/pci/controller/pci-thunder-pem.c  | 16 ++++++--------
 drivers/pci/controller/pci-xgene.c        |  4 ++--
 drivers/pci/controller/pcie-tango.c       |  9 +++++---
 drivers/pci/ecam.c                        | 10 ++++++---
 drivers/pci/setup-bus.c                   |  1 +
 include/linux/pci-acpi.h                  |  2 +-
 include/linux/pci-ecam.h                  | 25 +++++++++++-----------
 15 files changed, 78 insertions(+), 84 deletions(-)

--
2.20.1
