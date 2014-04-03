Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58973 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbaDCQJ2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 12:09:28 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so2093989iec.30
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 09:09:28 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Apr 2014 10:09:08 -0600
Message-ID: <CAErSpo7OVbiZ=W1N0Zfb=p3KDsDCkq7Xq1CqzQTeANfvWWZ9yw@mail.gmail.com>
Subject: Coverity CID 146454: pcie_bus_configure_settings() use of
 uninitialized variable
To: Jon Mason <jdmason@kudzu.us>, Yijing Wang <wangyijing@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Coverity complains that "smpss" is used uninitialized in
drivers/pci/probe.c in pcie_bus_configure_settings() when calling
pcie_bus_configure_set():

1642        pcie_bus_configure_set(bus->self, &smpss);
1643        pci_walk_bus(bus, pcie_bus_configure_set, &smpss);

"smpss" may be uninitialized, and pcie_bus_configure_set()
dereferences the pointer it receives.

This is CID 146454.

Bjorn
