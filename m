Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57882 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab2DBHj4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Apr 2012 03:39:56 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 821B63EE0BB
	for <linux-pci@vger.kernel.org>; Mon,  2 Apr 2012 16:39:55 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 689C545DE4E
	for <linux-pci@vger.kernel.org>; Mon,  2 Apr 2012 16:39:55 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 430F545DD78
	for <linux-pci@vger.kernel.org>; Mon,  2 Apr 2012 16:39:55 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 355FB1DB803E
	for <linux-pci@vger.kernel.org>; Mon,  2 Apr 2012 16:39:55 +0900 (JST)
Received: from m005.s.css.fujitsu.com (m005.s.css.fujitsu.com [10.23.4.35])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E8ACE1DB802C
	for <linux-pci@vger.kernel.org>; Mon,  2 Apr 2012 16:39:54 +0900 (JST)
Message-ID: <4F79584B.2010301@jp.fujitsu.com>
Date: Mon, 02 Apr 2012 16:42:03 +0900
From: =?ISO-2022-JP?B?GyRCPj5LXEduTzobKEI=?=
	<matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: jbarnes@virtuousgeek.org
CC: linux-pci@vger.kernel.org
Subject: [RFC] pciehp: Add archdata setting
Content-Type: multipart/mixed;
 boundary="------------060302070404040202010503"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060302070404040202010503
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi


I'm trying to use pciehp on powerpc platform.
I set e1000e card to PCI Express bridge that has PCI Express HotPlug
Capability.

There is problem when poweron PCI Express HotPlug slot with pciehp.
e1000e driver needs dma_ops in struct dev_archdata, but archdata isn't
set (dma_ops is NULL) when probe from pciehp.
Then e1000e driver returns error as below.

-sh-3.2# echo 1 > /sys/bus/pci/slots/1/power
<snip>
[   65.493662] pci 0000:03:00.0: BAR 2: set to [io
0xff7ee000-0xff7ee01f] (PCI address [0x1000-0x101f])
[   65.502890] pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
[   65.508555] pcieport 0000:02:01.0:   bridge window [io
0xff7ee000-0xff7eefff]
[   65.515785] pcieport 0000:02:01.0:   bridge window [mem
0xa0100000-0xa01fffff]
[   65.523015] pcieport 0000:02:01.0:   bridge window [mem
0xa0200000-0xa02fffff 64bit pref]
[   65.531238] pci 0000:03:00.0: no hotplug settings from platform
[   65.538361] e1000e 0000:03:00.0: Disabling ASPM  L1
[   65.543616] e1000e 0000:03:00.0: enabling device (0000 -> 0002)
[   65.549876] e1000e 0000:03:00.0: No usable DMA configuration, aborting
[   65.557194] e1000e: probe of 0000:03:00.0 failed with error -5
-sh-3.2# lspci
<snip>
0000:03:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit
Ethernet Controller (Copper) (rev 06)
<snip>
-sh-3.2# ifconfig -a
<snip>  // There is no network interface for 82572EI

If archdata.dma_ops is NULL on x86 platform, e1000e will get dma_ops
without archdata.
So e1000e driver doesn't return error.

I think that archdata should be set before driver probe (e.g pciehp).
I tried to fix it (pciehp-add-archdata.patch), but I'm not good at PCI
driver..., so please give better way.


Regards.

Hiroo MATSUMOTO (FUJITSU COMPUTER TECHNOLOGIES LIMITED)
matsumoto.hiroo@jp.fujitsu.com



--------------060302070404040202010503
Content-Type: text/plain;
 name="pciehp-add-archdata.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pciehp-add-archdata.patch"

U2lnbmVkLW9mZi1ieTogSGlyb28gTUFUU1VNT1RPIDxtYXRzdW1vdG8uaGlyb29AanAuZnVq
aXRzdS5jb20+CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9wY2ku
YyBiL2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX3BjaS5jCmluZGV4IGE0MDMxZGYuLmEw
MjFmYmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX3BjaS5jCisr
KyBiL2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX3BjaS5jCkBAIC04OSw2ICs4OSw3IEBA
IGludCBwY2llaHBfY29uZmlndXJlX2RldmljZShzdHJ1Y3Qgc2xvdCAqcF9zbG90KQogCQkJ
cGNpZWhwX2FkZF9icmlkZ2UoZGV2KTsKIAkJfQogCQlwY2lfZGV2X3B1dChkZXYpOworCQlk
ZXYtPmRldi5hcmNoZGF0YSA9IGJyaWRnZS0+ZGV2LmFyY2hkYXRhOwogCX0KIAogCXBjaV9h
c3NpZ25fdW5hc3NpZ25lZF9icmlkZ2VfcmVzb3VyY2VzKGJyaWRnZSk7Cg==
--------------060302070404040202010503--

