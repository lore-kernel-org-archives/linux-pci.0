Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE204C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 00:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0C3208B3
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 00:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0C3208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeJPIm7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:42:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:26009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeJPIm7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 04:42:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 17:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,386,1534834800"; 
   d="scan'208";a="95512629"
Received: from unknown (HELO localhost.localdomain.localdomain) ([10.232.117.194])
  by fmsmga002.fm.intel.com with ESMTP; 15 Oct 2018 17:55:13 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/2] VMD fixes for 4.20
Date:   Mon, 15 Oct 2018 18:48:06 -0600
Message-Id: <1539650888-3792-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo, Keith, Bjorn

These are VMD fixes for 4.20
First one looks to fix an orphaned struct resource issue when removing the VMD
module


Second patch enables firmware-first error handling on a VMD domain.

Because the endpoint is somewhat divorced from the VMD domain, the driver
doesn't use a standard ACPI method of signaling firmware-first on the domain.
The idea behind firmware-first in VMD is that the endpoint will advertise its
support using the interface bit in the endpoint. The driver enables SMI system
error messages in the root port control register. The firmware is allowed to
handle the interrupt as it sees fit, but returns control to the VMD driver by
synthesizing an MSI message. The kernel native AER driver may be used for
further processing, so is left enabled. If the firmware doesn't need the native
driver, of course it can handle and clear all errors and the subsequent MSI
will be eventually dropped as it goes through the VMD ISR.

At this time, I'm unaware of how the errors will be represented in the error
status headers. In the past they could be seen as a combination of the VMD
endpoint device's bus number and the erroring device's bus number, but could be
different depending on the type of error and if the erroring endpoint was lost
(completion timeout). Currently the native driver handles these errors by
scanning every device on the bus for error status and there's no plan to change
that mechanism for future VMD devices.

Follow-up to:
https://patchwork.ozlabs.org/patch/966128/
https://patchwork.ozlabs.org/patch/964254/

Jon Derrick (2):
  PCI/VMD: Detach resources after stopping root bus
  PCI/VMD: Set up firmware-first if capable

 drivers/pci/controller/vmd.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

-- 
1.8.3.1

