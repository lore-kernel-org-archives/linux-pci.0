Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:38343 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeENQ4b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 12:56:31 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BDE261E044E
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 18:56:29 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 0/2] Replace lower into upper case characters
Date: Mon, 14 May 2018 17:56:22 +0100
Message-Id: <cover.1526311733.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replacement of all initial lowercase character in comments and debug
messages to uppercase to maintain coherence.

Gustavo Pimentel (2):
  misc: pci_endpoint_test: Replace lower into upper case characters
  PCI: endpoint: functions/pci-epf-test: Replace lower into upper case
    characters

 drivers/misc/pci_endpoint_test.c              | 18 +++++++++---------
 drivers/pci/endpoint/functions/pci-epf-test.c | 26 +++++++++++++-------------
 2 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.7.4
