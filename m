Return-Path: <SRS0=x16U=4C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A0DC35242
	for <linux-pci@archiver.kernel.org>; Fri, 14 Feb 2020 21:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4133222C2
	for <linux-pci@archiver.kernel.org>; Fri, 14 Feb 2020 21:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbgBNVdW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:33:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:64984 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgBNVdV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 16:33:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 13:33:21 -0800
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227742868"
Received: from mravago-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.252.135.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2020 13:33:20 -0800
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     tglx@linutronix.de, bhelgaas@google.com, corbet@lwn.net,
        mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kar.hin.ong@ni.com, sassmann@kpanic.de,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH 0/2] Add boot interrupt quirk mechanism for Xeon chipsets
Date:   Fri, 14 Feb 2020 13:33:11 -0800
Message-Id: <20200214213313.66622-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When IRQ lines on secondary or higher IO-APICs are masked (e.g.,
Real-Time threaded interrupts), many chipsets redirect IRQs on
this line to the legacy PCH and in turn the base IO-APIC in the
system. The unhandled interrupts on the base IO-APIC will be
identified by the Linux kernel as Spurious Interrupts and can
lead to disabled IRQ lines.

Disabling this legacy PCI interrupt routing is chipset-specific and
varies in mechanism between chipset vendors and across generations.
In some cases the mechanism is exposed to BIOS but not all BIOS
vendors choose to pick it up. With the increasing usage of RT as it
marches towards mainline, additional issues have been raised with
more recent Xeon chipsets.

This patchset disables the boot interrupt on these Xeon chipsets where
this is possible with an additional mechanism.  In addition, this
patchset includes documentation covering the background of this quirk.

Sean V Kelley (2):
  pci: Add boot interrupt quirk mechanism for Xeon chipsets
  Documentation:PCI: Add background on Boot Interrupts

 Documentation/PCI/boot-interrupts.rst | 153 ++++++++++++++++++++++++++
 Documentation/PCI/index.rst           |   1 +
 drivers/pci/quirks.c                  |  80 ++++++++++++--
 3 files changed, 227 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/PCI/boot-interrupts.rst

--
2.25.0

