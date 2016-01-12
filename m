Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54978 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbcALWaJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2016 17:30:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	bhelgaas@google.com, michals@xilinx.com, lorenzo.pieralisi@arm.com,
	paul.burton@imgtec.com, yinghai@kernel.org, wangyijing@huawei.com,
	robh@kernel.org, russell.joyce@york.ac.uk, sorenb@xilinx.com,
	jiang.liu@linux.intel.com, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, Bharat Kumar Gogada <bharatku@xilinx.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 0/5] PCIe Xilinx generic driver for Microblaze and
Date: Tue, 12 Jan 2016 23:29:21 +0100
Message-ID: <33382572.XZxh3toaBY@wuerfel>
In-Reply-To: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 January 2016 23:06:08 Bharat Kumar Gogada wrote:
> This patch series does modifications to pcie-xilinx.c, to support common
> driver on both Zynq and Microblaze architectures.
> Microblaze pci-common.c has been modified to support generic driver.
> 
> I'm aware Paul Burton <paul.burton@imgtec.com> has also sent patches
> related to pcie-xilinx.c, but I'm unable to comment on them. 
> I request Paul Burton to please add me in cc list so that I can comment on
> those patches.

Very nice work overall!

I've commented on a few smaller things that I think could be improved.

	Arnd
