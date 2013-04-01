Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21633 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756857Ab3DAWXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2013 18:23:35 -0400
From: "Luck, Tony" <tony.luck@intel.com>
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH 2/2] PCI/IA64: fix pci_dev->enable_cnt balance when
 doing pci hotplug
Date: Mon, 1 Apr 2013 22:23:32 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F1E096033@ORSMSX108.amr.corp.intel.com>
References: <1364805775-12396-1-git-send-email-wangyijing@huawei.com>
 <1364805775-12396-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1364805775-12396-2-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> In IA64 platform, we don't call pci_enable_bridges()
> when scan all pci buses during system boot up. But in
> X86 we do it in

Your patch looks plausible ... but I have a question. X86 doesn't
*directly* call pci_enable_bridges() from any arch/x86/* file.

Do we need this in an arch/ia64 file because our PCI support
is getting old and stale?  "git grep" says that arm, m68k, mips
and sh all make direct calls.

-Tony
