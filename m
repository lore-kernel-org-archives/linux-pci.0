Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:53647 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757873Ab3CNRqB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 13:46:01 -0400
Received: from /spool/local
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Thu, 14 Mar 2013 14:45:58 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 253AE1DC004E
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 13:45:56 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2EHjD5R23658704
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 14:45:13 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2EHjtl1013433
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2013 14:45:55 -0300
From: lucaskt@linux.vnet.ibm.com
To: dri-devel@lists.freedesktop.org
Cc: linux-pci@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, brking@linux.vnet.ibm.com,
	cascardo@linux.vnet.ibm.com
Subject: PCI Speed Cap Fixes for ppc64
Date: Thu, 14 Mar 2013 14:45:45 -0300
Message-Id: <1363283147-8852-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series at first moves get_speed_cap_mask from DRM to PCI, fixes all
radeon references (only driver that uses it) and then implements a architecture
specific implementation for ppc64 for it.

This is good because the drm_pcie_get_speed_cap_mask function is more
architecture goo than something drm-specific, and also because this way
architectures that have different means of obtaining these values can do it
their way.

