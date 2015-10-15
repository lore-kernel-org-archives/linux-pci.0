Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37651 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752674AbbJORj3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 13:39:29 -0400
Message-ID: <561FE4CE.4090505@arm.com>
Date: Thu, 15 Oct 2015 18:39:26 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: "majun (F)" <majun258@huawei.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 4/7] genirq/msi: Make the .prepare callback reusable
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <1444923568-17413-5-git-send-email-marc.zyngier@arm.com> <EE11001F9E5DDD47B7634E2F8A612F2E1624783E@lhreml503-mbs>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1624783E@lhreml503-mbs>
Content-Type: text/plain; charset=gbk
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15/10/15 18:24, Gabriele Paoloni wrote:
> Hi Marc
> 
> It looks like this patch fails to apply to 4.3-rc5....

Which is by design. Try tip/irq/core.

	M.
-- 
Jazz is not dead. It just smells funny...
