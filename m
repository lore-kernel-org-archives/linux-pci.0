Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52486 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757775AbbJVSq0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 Oct 2015 14:46:26 -0400
Date: Thu, 22 Oct 2015 13:46:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, jingoohan1@gmail.com,
	pratyush.anand@gmail.com, Arnd Bergmann <arnd@arndb.de>,
	linux@arm.linux.org.uk, thomas.petazzoni@free-electrons.com,
	gabriele.paoloni@huawei.com, lorenzo.pieralisi@arm.com,
	james.morse@arm.com, Liviu.Dudau@arm.com, jason@lakedaemon.net,
	robh@kernel.org, gabriel.fernandez@linaro.org,
	Minghuan.Lian@freescale.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangjukuo@huawei.com,
	qiuzhenfa@hisilicon.com, liudongdong3@huawei.com,
	qiujiang@huawei.com, xuwei5@hisilicon.com, liguozhu@hisilicon.com
Subject: Re: [PATCH v11 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
Message-ID: <20151022184622.GD21237@localhost>
References: <1444991021-109306-1-git-send-email-wangzhou1@hisilicon.com>
 <1444991021-109306-5-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444991021-109306-5-git-send-email-wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Zhou,

This looks pretty good to me; just a mask question and add a printk.

On Fri, Oct 16, 2015 at 06:23:39PM +0800, Zhou Wang wrote:
> This patch adds PCIe host support for HiSilicon SoC Hip05.
> ...

> +#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
> +#define PCIE_LTSSM_LINKUP_STATE                         0x11
> +#define PCIE_LTSSM_STATE_MASK                           0x3F

Fabio unified some of this; see
  https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-designware&id=4788fe6ebf4594c9a95b620cbff05147c8504823
  https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-designware&id=b09464f77dd252a782da1f4e9925c1dbce4540ac

So the question is, why do you use a 6-bit (0x3f) LTSSM_STATE_MASK?
We think we can use a 5-bit mask (0x1f) for all the other
DesignWare-based systems.

> +/* Hip05 PCIe host only supports 32-bit config access */

Thanks for the comment asserting that Hip05 only supports 32-bit
config access.  I assume you confirmed that with the hardware
designers.  As far as I can tell, this *is* a hardware defect, and at
the minimum, I want a printk at driver probe-time so a dmesg log will
have a clue that read/modify/write on config space might do the wrong
thing.

> +static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
> +			      u32 *val)
> ...

Bjorn
