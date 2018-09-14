Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44826 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeIOBLC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2018 21:11:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so4857186pgp.11
        for <linux-pci@vger.kernel.org>; Fri, 14 Sep 2018 12:55:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com
Cc: devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/2] hv_netvsc: associate VF and PV device by serial number
Date: Fri, 14 Sep 2018 12:54:55 -0700
Message-Id: <20180914195457.20433-1-sthemmin@microsoft.com>
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

v2 - slot name can be shorter.
     remove locking when creating pci_slots; see comment for explaination

Stephen Hemminger (2):
  PCI: hv: support reporting serial number as slot information
  hv_netvsc: pair VF based on serial number

 drivers/net/hyperv/netvsc.c         |  3 ++
 drivers/net/hyperv/netvsc_drv.c     | 58 ++++++++++++++++-------------
 drivers/pci/controller/pci-hyperv.c | 37 ++++++++++++++++++
 3 files changed, 73 insertions(+), 25 deletions(-)

-- 
2.18.0
