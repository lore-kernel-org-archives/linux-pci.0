Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:40408 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344Ab2EYKXB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2012 06:23:01 -0400
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id BD0A43EE0C0
	for <linux-pci@vger.kernel.org>; Fri, 25 May 2012 19:22:59 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9CFC845DE52
	for <linux-pci@vger.kernel.org>; Fri, 25 May 2012 19:22:59 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8235345DD78
	for <linux-pci@vger.kernel.org>; Fri, 25 May 2012 19:22:59 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 74F821DB803F
	for <linux-pci@vger.kernel.org>; Fri, 25 May 2012 19:22:59 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1E47E1DB8038
	for <linux-pci@vger.kernel.org>; Fri, 25 May 2012 19:22:59 +0900 (JST)
Date: Fri, 25 May 2012 19:22:51 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>, Jiang Liu <liuj97@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/9] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
Message-Id: <20120525192251.c63e8863.izumi.taku@jp.fujitsu.com>
In-Reply-To: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jiang,

 After applied your patch, the iomem tree structure a bit changed
 on my machine. The entry of "f0000000-f3ffffff : pnp 00:02" has gone.
 This is because the order of insert_resource has changed, in my mind.
 After applied your patch, "PCI MMCONFIG 0000" is inserted before
 "pnp 00:02", so inserting "pnp 00:02" failed.

* /proc/iomem (before)
...
efee0000-efeecfff : ACPI Tables
efeed000-efefffff : ACPI Non-volatile Storage
eff00000-f3ffffff : reserved
  f0000000-f3ffffff : pnp 00:02   <---
    f0000000-f13fffff : PCI MMCONFIG 0000 [bus 00-13]
f4000000-f41fffff : PCI Bus 0000:01
  f4000000-f41fffff : PCI Bus 0000:02
    f4000000-f40fffff : 0000:02:05.0
    f4100000-f413ffff : 0000:02:09.0
    f4140000-f417ffff : 0000:02:09.1
....

* /proc/iomem (after)
...
efee0000-efeecfff : ACPI Tables
efeed000-efefffff : ACPI Non-volatile Storage
eff00000-f3ffffff : reserved
  f0000000-f13fffff : PCI MMCONFIG 0000 [bus 00-13]
f4000000-f41fffff : PCI Bus 0000:01
  f4000000-f41fffff : PCI Bus 0000:02
    f4000000-f40fffff : 0000:02:05.0
    f4100000-f413ffff : 0000:02:09.0
    f4140000-f417ffff : 0000:02:09.1
...

Best regards,
Taku Izumi


