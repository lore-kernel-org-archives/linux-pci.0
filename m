Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54745 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab2DSGtM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Apr 2012 02:49:12 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 0D86B3EE0BD
	for <linux-pci@vger.kernel.org>; Thu, 19 Apr 2012 15:49:11 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id A14DD45DE56
	for <linux-pci@vger.kernel.org>; Thu, 19 Apr 2012 15:49:10 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5C4F245DE55
	for <linux-pci@vger.kernel.org>; Thu, 19 Apr 2012 15:49:10 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 48CF2E08001
	for <linux-pci@vger.kernel.org>; Thu, 19 Apr 2012 15:49:10 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0280EE18007
	for <linux-pci@vger.kernel.org>; Thu, 19 Apr 2012 15:49:10 +0900 (JST)
Date: Thu, 19 Apr 2012 15:49:21 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 6/6] PCI, ACPI, x86: update MMCFG information when
 hot-plugging PCI host bridges
Message-Id: <20120419154921.64583b35.izumi.taku@jp.fujitsu.com>
In-Reply-To: <4F8E7227.1050707@huawei.com>
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
	<1334103063-2283-7-git-send-email-jiang.liu@huawei.com>
	<20120418154725.92833e4d.izumi.taku@jp.fujitsu.com>
	<4F8E7227.1050707@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Jiang,
   Thanks, and I have another question.

    What does "acpi_pci_root.mmconf_added" indicate ?
    In case of non-hotpluggable hostbridges, that is, when MMCONF 
    is described using MCFG table, acpi_pci_root.mmconf_added is always 0.
    Is "acpi_pci_root.mmconf_added" only for hotpluggable hostbridges ?

-- 
Best regarads,
Taku Izumi <izumi.taku@jp.fujitsu.com>

