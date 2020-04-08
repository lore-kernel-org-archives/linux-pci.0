Return-Path: <SRS0=UcqY=5Y=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13363C2D0EC
	for <linux-pci@archiver.kernel.org>; Wed,  8 Apr 2020 00:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CE920747
	for <linux-pci@archiver.kernel.org>; Wed,  8 Apr 2020 00:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDHAKJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:10:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:8224 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgDHAKJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Apr 2020 20:10:09 -0400
IronPort-SDR: 10+Twl9UQI/NFsmeB8VzB3jovsFY+dNk7qVewCWOQ40Lhkc41iHECmDxYj3Ka5MwA9pwHg53Gi
 SsgspDSC8kMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 17:10:06 -0700
IronPort-SDR: PDd6UF6VcfITqHVANsKQiPON/aHBIkeHrHoNaL6YP12kHPW+gl6g038sw+v85Iwi7BjKc25YDB
 uC+yYZev03LA==
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="251425579"
Received: from vkippes-mobl.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.134.96.189])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 17:10:02 -0700
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     mj@ucw.cz, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [RFC Patch 0/1] pciutils: Add basic decode support for CXL
Date:   Tue,  7 Apr 2020 17:09:58 -0700
Message-Id: <20200408000959.230780-1-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Compute eXpress Link[1] is a new CPU interconnected created with
workload accelerators in mind. The interconnect relies on PCIe Electrial
and Physical interconnect for communication.

Moreover, CXL bus hierarchy appear, to the OS, as an ACPI-described PCIe
Root Bridge with Integrated Endpoint.

I'm interested in feedback on how best to handle the case of DVSEC for CXL.
Up until this point it has been a catch-all:

case PCI_EXT_CAP_ID_DVSEC:
- printf("Designated Vendor-Specific <?>\n");
+ cap_cxl(d, where);
  break;

Should I retain the general printf() in the case of the absence of CXL?
Or other suggestions?

Best regards,

Sean


[1] https://www.computeexpresslink.org

Sean V Kelley (1):
  lspci: Add basic decode support for Compute eXpress Link

 lib/header.h        | 25 +++++++++++++++++++++++++
 ls-ecaps.c          | 29 ++++++++++++++++++++++++++++-
 tests/cap-cxl-dvsec |  8 ++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tests/cap-cxl-dvsec

--
2.26.0

