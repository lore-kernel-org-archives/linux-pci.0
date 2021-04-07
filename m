Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E83DC43460
	for <linux-pci@archiver.kernel.org>; Wed,  7 Apr 2021 22:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D4B6139B
	for <linux-pci@archiver.kernel.org>; Wed,  7 Apr 2021 22:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhDGW1B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:27:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:14309 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhDGW0u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 18:26:50 -0400
IronPort-SDR: H3g4hB7cjmsi6Xp8CQ4fmBAMsxni0HQKm36O/Ovt3fBpOdvvy+XvrDkeXEmhIy6vRV55//jDav
 VFHncyTljhVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193524910"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="193524910"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:38 -0700
IronPort-SDR: +m62Qdw1PiOey2M8i55CJI0Ww/9FUBzguqYhScpU7yN0nhqV5sIH0zsKGmjybAGiNcwZPuFfBH
 BxlQTtDeQ8zg==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="458548524"
Received: from hmfaraby-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.128.243])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Enumerate HDM Decoder registers
Date:   Wed,  7 Apr 2021 15:26:18 -0700
Message-Id: <20210407222625.320177-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The arbiter of a Host-managed Device Memory (HDM) region is an "HDM Decoder".
An HDM decoder is defined in the Compute eXpress Link (CXL) specification as
hardware that handles the routing of memory ranges controlled by CXL devices in
a linear, or interleaved fashion.

HDM decoders are not specific to CXL devices and therefore live in a different
part of the MMIO space for CXL *components*. The CXL component registers are
found and mapped in a similar way to the device registers and so a lot of this
series is refactoring to try to easily add the new register block type.

Management of HDM decoders is not handled in this series. This work is the
foundation for the eventual integration with libnvdimm. That integration will
enable CXL persistent and volatile capacities to be managed by Linux and gain
use of all the related existing infrastructure.

These patches go on top of the reworks and improvements recently submitted by
Dan [1].

[1]: https://lore.kernel.org/linux-cxl/161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com/T/#t

Ben Widawsky (7):
  cxl/mem: Use dev instead of pdev->dev
  cxl/mem: Split creation from mapping in probe
  cxl/mem: Move register locator logic into reg setup
  cxl/mem: Get rid of @cxlm.base
  cxl/mem: Move device register setup
  cxl/mem: Create a helper to setup device regs
  cxl: Add HDM decoder capbilities

 drivers/cxl/core.c |  73 +++++++++++++++
 drivers/cxl/cxl.h  |  48 ++++++++++
 drivers/cxl/mem.c  | 225 +++++++++++++++++++++++++++------------------
 drivers/cxl/mem.h  |   2 -
 drivers/cxl/pci.h  |   1 +
 5 files changed, 260 insertions(+), 89 deletions(-)


base-commit: 24ca2d6ff18cc59c14c0aff65025b0cc11a72722
-- 
2.31.1

