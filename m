Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41221 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbcDHVvE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2016 17:51:04 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id u38Lp27i017486
	for <linux-pci@vger.kernel.org>; Fri, 8 Apr 2016 16:51:02 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id u38Lp1tO022228
	for <linux-pci@vger.kernel.org>; Fri, 8 Apr 2016 16:51:01 -0500
Received: from [158.218.103.0] (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id u38Lp1ce017887	for
 <linux-pci@vger.kernel.org>; Fri, 8 Apr 2016 16:51:01 -0500
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Subject: Hot reset in downstream direction (RC to EP)
Message-ID: <570827D5.5060201@ti.com>
Date: Fri, 8 Apr 2016 17:51:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I see that hot reset is something the RC port initiate to have EP reset
through link management.

==========================================================================
PCIe reset sequences – The PCI Express protocol specifies a hot reset
mechanism, where downstream components reset through link notification.
Root ports should validate that this mechanism can be applied and the 
hot reset indication is properly detected by a remote device.
Endpoint applications should determine the level of chip reset desired
in case of hot reset detection on the link to validate proper functionality. 
===========================================================================

Does this happen during the enumeration? As this goes in in band, the EP's
link should be up. Can someone tell me what are the triggering points for
this from RC to EP? Does Linux RC support this? It is supposed to a bit
in RC's bridge configuration space that triggers this reset.

-- 
Murali Karicheri
Linux Kernel, Keystone
