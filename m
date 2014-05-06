Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:65531 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934110AbaEFH0Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 May 2014 03:26:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
	x86@kernel.org, Will Deacon <will.deacon@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PCI: Turn pcibios_penalize_isa_irq() into __weak function
Date: Tue, 06 May 2014 09:26:03 +0200
Message-ID: <4534160.Diq8cthzci@wuerfel>
In-Reply-To: <1399346992-6584-1-git-send-email-hanjun.guo@linaro.org>
References: <1399346992-6584-1-git-send-email-hanjun.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 06 May 2014 11:29:52 Hanjun Guo wrote:
> pcibios_penalize_isa_irq() is only useful for x86 now, and
> legacy ISA is not used by some architectures, so make
> pcibios_penalize_isa_irq() as __weak function to simplify
> the code, this will prevent new platform from introducing
> dummy stub function for pcibios_penalize_isa_irq() too.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
