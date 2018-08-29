Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41396 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbeH2UWl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Aug 2018 16:22:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so2519499plr.8
        for <linux-pci@vger.kernel.org>; Wed, 29 Aug 2018 09:25:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com
Cc: devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH net-next 0/2] hv_netvsc: associate VF and PV device by serial number
Date: Wed, 29 Aug 2018 09:24:50 -0700
Message-Id: <20180829162452.25805-1-sthemmin@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Hyper-V implementation of PCI controller has concept of 32 bit serial number
(not to be confused with PCI-E serial number).  This value is sent in the protocol
from the host to indicate SR-IOV VF device is attached to a synthetic NIC.

Using the serial number (instead of MAC address) to associate the two devices
avoids lots of potential problems when there are duplicate MAC addresses from
tunnels or layered devices.

The patch set is broken into two parts, one is for the PCI controller
and the other is for the netvsc device. Normally, these go through different
trees but sending them together here for better review. The PCI changes
were submitted previously, but the main review comment was "why do you
need this?". This is why.

Stephen Hemminger (2):
  PCI: hv: support reporting serial number as slot information
  hv_netvsc: pair VF based on serial number

 drivers/net/hyperv/netvsc.c         |  3 ++
 drivers/net/hyperv/netvsc_drv.c     | 58 ++++++++++++++++-------------
 drivers/pci/controller/pci-hyperv.c | 30 +++++++++++++++
 3 files changed, 66 insertions(+), 25 deletions(-)

-- 
2.18.0
