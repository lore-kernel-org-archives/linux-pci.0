Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50512 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbaKRKji (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 05:39:38 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Tony Luck <tony.luck@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	LAK <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] asm-generic: Add msi.h
Date: Tue, 18 Nov 2014 11:39:20 +0100
Message-ID: <1703620.E5bhVDQPHc@wuerfel>
In-Reply-To: <alpine.DEB.2.11.1411181133080.3909@nanos>
References: <alpine.DEB.2.11.1411181133080.3909@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 November 2014 11:34:37 Thomas Gleixner wrote:
> To support MSI irq domains we want a generic data structure for
> allocation, but we need the option to provide an architecture specific
> version of it. So instead of playing #ifdef games in linux/msi.h we
> add a generic header file and let architectures decide whether to
> include it or to provide their own implementation and provide the
> required typedef.

Acked-by: Arnd Bergmann <arnd@arndb.de>

for merging the asm-generic file

> I know that typedefs are not really nice, but in this case there are no
> forward declarations required and it's the simplest solution.

I must be missing the obvious: what problem does the typedef solve
that you would have with just a struct?

	Arnd
