Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:36040 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759168Ab2FUJeW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 05:34:22 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id BFAB73EE0AE
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:34:20 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id A5C9645DE58
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:34:20 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9142B45DE56
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:34:20 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 857461DB8042
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:34:20 +0900 (JST)
Received: from m001.s.css.fujitsu.com (m001.s.css.fujitsu.com [10.23.4.39])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 434FC1DB804C
	for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 18:34:20 +0900 (JST)
Date: Thu, 21 Jun 2012 18:34:30 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 0/4] acpi, pci: hostbridge hotplug support
Message-Id: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


 This patchset adds basic code for host bridge hotplug.
 
 I assume ACPI container device (ACPI0004) which carries
 hostbridges will be hot-added or hot-removed. In that case
 some codes are now missing for hostbridge hotplug.
 This patchset mainly adds the following:
   - remove hostbridge and devices under it 
   - resoruce-assign code for devices under hot-added hostbridge
 
 The behavior when you don't try hostbridge hotplug should not change.
 
  *[PATCH 1/4] acpi, pci: introduce list for acpi_pci_root drivers
  *[PATCH 2/4] acpi, pci: introduce acpi_root_sem for list manipulation
  *[PATCH 3/4] acpi, pci: add hostbridge removal function
  *[PATCH 4/4] acpi, pci: add resoruce-assign code for devices under 
      hot-added hostbridge
-
Best regards,
Taku Izumi

