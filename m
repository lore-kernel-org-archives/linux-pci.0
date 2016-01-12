Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51503 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbcALWYc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2016 17:24:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	bhelgaas@google.com, michals@xilinx.com, lorenzo.pieralisi@arm.com,
	paul.burton@imgtec.com, yinghai@kernel.org, wangyijing@huawei.com,
	robh@kernel.org, russell.joyce@york.ac.uk, sorenb@xilinx.com,
	jiang.liu@linux.intel.com, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH V2 2/5] PCI: xilinx: Removing struct hw_irq structure.
Date: Tue, 12 Jan 2016 23:23:32 +0100
Message-ID: <5660994.Bgxrr57r2H@wuerfel>
In-Reply-To: <1452620173-4905-3-git-send-email-bharatku@xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com> <1452620173-4905-3-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 January 2016 23:06:10 Bharat Kumar Gogada wrote:
> Removing struct hw_irq and adding generic PCI core API's.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Removing architecure dependecy structure struct hw_irq which is ARM 32-bit
> specific structure, and adding generic PCI core API's to register to
> PCI subsytem.
> Removing funtions which are not being used with generic API's.
> 

typo: s/hw_irq/hw_pci/

	Arnd
