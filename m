Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:30750
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1761883AbdJQMsS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 08:48:18 -0400
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com
Cc: Wilson.Snyder@cavium.com, robert.richter@cavium.com,
        david.daney@cavium.com, mjaggi@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: [PATCH v7 0/2] PCI: quirks: Cavium ThunderX ACS quirk update
Date: Tue, 17 Oct 2017 05:47:37 -0700
Message-Id: <1508244459-2615-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
In-Reply-To: <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
References: <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

version 7:
- update patch description accordingly to review comments;
- split for two patches: for ACS mask change and device id match change;
- remove macro #define of ACS flags, put it back to quirk function;
- remove '__inline_' from device id matching function;
- wrap code comments to fit into 80 columns;
- comment fix: change 0xa00 to 0xf800 for matching function description;

version 6:
- comment typo fix: change 0xa00 to 0xa000;

version 5:
- update code comments accordingly to review comments;

version 4:
- update ACS mask (remove TB and TD bits), update commit message (remove
  ACS register printout);

version 3:
- update subject: remove CN8XXX from subject line, replace it with ThunderX;

version 2:
- update match function in order to filter only ThunderX devices by device
  ids to properly filter CN8XXX devices, update subject & description with
  ACS register info (v2 was rejected by maillist due to triple X in subject);
  
Vadim Lomovtsev (2):
  PCI: quirks: Set Cavium ACS capability quirk flags to assert
    RR/CR/SV/UF.
  PCI: quirks: Apply Cavium ThunderX ACS quirk only to Root Ports

 drivers/pci/quirks.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.13.6
