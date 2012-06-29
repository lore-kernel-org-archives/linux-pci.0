Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:46544 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab2F2Gsr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jun 2012 02:48:47 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Fri, 29 Jun 2012 02:48:46 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5T6ltXa2097500
	for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2012 02:47:55 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5T6ls50006777
	for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2012 02:47:55 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, yinghai@kernel.org, benh@kernel.crashing.org,
	linuxram@us.ibm.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH V5 0/7] minimal alignment for p2p bars
Date: Fri, 29 Jun 2012 14:47:43 +0800
Message-Id: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v1 -> v2:
	* Shorten the varaible names so that they looks more short.
	* Changelog adjustment so that they looks more meaningful.

v2 -> v3:
	* Rebase to 3.5.RC4

v3 -> v4:
	* Merge Yinghai's patches.

v3 -> v4:
	* Split patch for easy review.
	* Add function to retrieve the minimal alignment of p2p bridge. 

Lu Yinghai(3):
  pci: change variable name for find_pci_host_bridge
  pci: argument pci_bus for find_pci_host_bridge
  pci: fiddle with conversion of pci and CPU address

Gavin Shan(4)
  pci: make find_pci_host_bridge global
  pci: minimal alignment for bars of P2P bridges
  pci: function to retrieve alignment of p2p bars
  pci: resource assignment based on p2p alignment

 drivers/pci/host-bridge.c |   59 ++++++++++++++++++++++++++++++++++++---------
 drivers/pci/probe.c       |    5 ++++
 drivers/pci/setup-bus.c   |   22 +++++++++++------
 include/linux/pci.h       |   15 +++++++++++-
 4 files changed, 81 insertions(+), 20 deletions(-)

Thanks,
Gavin

