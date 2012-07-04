Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:58649 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016Ab2GDDPw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2012 23:15:52 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 976BE3EE0B6
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:15:51 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7D63A45DEA6
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:15:51 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6561745DE9E
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:15:51 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5726B1DB803B
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:15:51 +0900 (JST)
Received: from m005.s.css.fujitsu.com (m005.s.css.fujitsu.com [10.23.4.35])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 14B741DB8038
	for <linux-pci@vger.kernel.org>; Wed,  4 Jul 2012 12:15:51 +0900 (JST)
Date: Wed, 4 Jul 2012 12:15:45 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 1/2] pci: add missing document for hpiosize and hpmemsize
 option
Message-Id: <20120704121545.6e1b2992.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120702134901.83708415.izumi.taku@jp.fujitsu.com>
References: <20120702134901.83708415.izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


This patch adds missinc document for "hpiosize" and "hpmemsize"
option.

Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
---
 Documentation/kernel-parameters.txt |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt	2012-06-26 14:37:24.000000000 +0900
+++ linux/Documentation/kernel-parameters.txt	2012-07-04 10:00:58.822901307 +0900
@@ -2168,6 +2168,12 @@ bytes respectively. Such letter suffixes
 		cbmemsize=nn[KMG]	The fixed amount of bus space which is
 				reserved for the CardBus bridge's memory
 				window. The default value is 64 megabytes.
+		hpiosize	The fixed amount of bus space which is
+				reserved for hotplug bridge's IO window.
+				The default value is 256 bytes.
+		hpmemsize	The fixed amount of bus space which is
+				reserved for hotplug bridge's memory window.
+				The default value is 2 megabytes.
 		resource_alignment=
 				Format:
 				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]

