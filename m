Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:28480 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756569AbdJKIou (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2017 04:44:50 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
Subject: [PATCH 0/3] pci_endpoint_test: Fix module removal/insertion cycle
Date: Wed, 11 Oct 2017 14:14:35 +0530
Message-ID: <20171011084438.8296-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series fixes module removal/insertion cycle of pci_endpoint_test.

Without this series, when trying to modprobe pci_endpoint_test after
rmmod pci_endpoint_test results in the following errors.

pci-endpoint-test 0000:01:00.0: BAR 0: can't reserve [mem 0x20204600-0x202046ff]
pci-endpoint-test 0000:01:00.0: Cannot obtain PCI resources
pci-endpoint-test: probe of 0000:01:00.0 failed with error -16

Kishon Vijay Abraham I (3):
  misc: pci_endpoint_test: Fix failure path return values in probe
  misc: pci_endpoint_test: Fix pci_endpoint_test not releasing resources
    on remove
  misc: pci_endpoint_test: Fix BUG_ON error during pci_disable_msi

 drivers/misc/pci_endpoint_test.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.11.0
