Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:44911 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaLVFsx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 00:48:53 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 22 Dec 2014 15:48:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 977CC2BB005E
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:48:49 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sBM5mnMq39714970
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:48:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sBM5mmOp012717
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:48:49 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 0/2] PCI/IOV: fix on offset/stride based on NumVFs change
Date: Mon, 22 Dec 2014 13:48:44 +0800
Message-Id: <1419227326-12083-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per SRIOV SPEC sec 3.3.9, 3.3.10, offset/stride may change when NumVFs is
written. While current kernel doesn't update offset/stride with the change of
NumVFs.

This property will also affect the iov bus range in enumeration.

This patch set consists of two patches:
1. Update the offset/stride with NumVFs change
2. Calculate VF bus range on each possilbe NumVFs

Code based on 3.19-rc1 and tested on x86 and powernv platform.
Bus range doesn't chage on current hardware.

Wei Yang (2):
  PCI: Refresh offset/stride after NumVFs is written
  PCI: Calculate the VF bus range on each possible NumVFs

 drivers/pci/iov.c |   54 +++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/pci/pci.h |    1 +
 2 files changed, 47 insertions(+), 8 deletions(-)

-- 
1.7.9.5

