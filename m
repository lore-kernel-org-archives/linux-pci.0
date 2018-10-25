Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30E8C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6AB20854
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 16:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6AB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xes-inc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeJZAe5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:34:57 -0400
Received: from xes-mad.com ([162.248.234.2]:1219 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeJZAe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 20:34:57 -0400
Received: from asierra1.xes-mad.com (asierra1.xes-mad.com [10.52.16.65])
        by mail.xes-mad.com (Postfix) with ESMTP id 53170264A7;
        Thu, 25 Oct 2018 11:01:32 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 0/2] Improve _OSC control request granularity
Date:   Thu, 25 Oct 2018 11:01:30 -0500
Message-Id: <1540483292-24049-1-git-send-email-asierra@xes-inc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539642186-12821-1-git-send-email-asierra@xes-inc.com>
References: <1539642186-12821-1-git-send-email-asierra@xes-inc.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These patches allow PCIe AER to function in a kernel without
CONFIG_PCIEASPM enabled. There is no explicit Kbuild dependency between
the two and there are, in my opinion, legitimate reasons for no implicit
dependency to exist either.

Previously with ASPM:

acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi PNP0A03:00: _OSC: OS now controls [PME AER PCIeCapability LTR]

Previously without ASPM:

acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig Segments MSI]
acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]

Now with ASPM:

acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi PNP0A03:00: _OSC: OS requested [PME AER PCIeCapability LTR]
acpi PNP0A03:00: _OSC: platform granted [PME AER PCIeCapability LTR]

Now without ASPM:

acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig Segments MSI]
acpi PNP0A03:00: _OSC: OS requested [AER PCIeCapability]
acpi PNP0A03:00: _OSC: platform granted [AER PCIeCapability]

This is v2 of the patchset, which includes these changes from v1:
  * Rebased from the mainline kernel (4.19-rc7) to Bjorn Helgaas's
    pci/aspm branch [1]
  * Factored moving the pcie_ports_disabled check to the top of
    negotiate_os_control into its own patch
  * Simplified new __osc_check_support function and renamed it to
    __osc_have_support
  * No longer messes with _OSC general availability test and related
    error message (i.e. _OSC failed ... disabling ASPM)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

Aaron Sierra (2):
  PCI/ACPI: Move _OSC test for native services to top
  PCI/ACPI: Improve _OSC control request granularity

 drivers/acpi/pci_root.c | 129 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 91 insertions(+), 38 deletions(-)

-- 
2.7.4

