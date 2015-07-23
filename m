Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36797 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbbGWNSh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 09:18:37 -0400
Received: by iehx8 with SMTP id x8so112120402ieh.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 06:18:37 -0700 (PDT)
Date: Thu, 23 Jul 2015 08:18:32 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v5 00/19] Per-device MSI domain & platform MSI
Message-ID: <20150723131832.GW21967@google.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 10:26:19AM +0100, Marc Zyngier wrote:
> MSI-like interrupts are starting to creep out of the PCI world, and
> can now be seen into a number of "platform"-type busses. The
> introduction of the MSI domains feature in v3.19 recognised that fact,
> and started providing a way to implement this.
> ...

The PCI parts all look great to me.  I assume Thomas will merge the whole
thing through his tree.  Thanks!

Bjorn
