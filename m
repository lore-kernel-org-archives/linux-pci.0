Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:38315 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab3LLT37 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 14:29:59 -0500
Message-ID: <52AA0EB2.2070701@arkona-technologies.de>
Date: Thu, 12 Dec 2013 20:29:54 +0100
From: Matthias Mann <m.mann@arkona-technologies.de>
MIME-Version: 1.0
To: Harro Haan <hrhaan@gmail.com>, Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>
CC: Marek Vasut <marex@denx.de>,
	Pratyush Anand <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Richard Zhu <hong-xing.zhu@freescale.com>,
	linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pci: designware: fix missing msi irqs
References: <20131212182903.409515738@gmail.com>
In-Reply-To: <20131212182903.409515738@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 12.12.2013 19:29, schrieb Harro Haan:
> The interrupts were cleared after the irq handler was called.
> This means that new interrupts that occur after the handler handled
> the previous irq but before the interrupt is cleared will be missed.

I discovered the same issue today. I'll test that patch tomorrow.
