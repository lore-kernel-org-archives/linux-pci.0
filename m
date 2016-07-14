Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Jul 2016 06:12:49 -0700
From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: <bhelgaas@google.com>, <michal.simek@xilinx.com>,
	<bharat.kumar.gogada@xilinx.com>, <rgummal@xilinx.com>,
	<arnd@arndb.de>, <jiang.liu@linux.intel.com>,
	<grygorii.strashko@ti.com>, <russell.joyce@york.ac.uk>,
	<lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] PCI: xilinx: Fix return value in case of error
Message-ID: <20160714131249.GJ3847@xsjsorenbubuntu>
References: <1468491046-1427-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <1468491046-1427-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-07-14 at 12:10:46 +0200, Christophe JAILLET wrote:
> In function 'xilinx_pcie_init_irq_domain', the pattern used to check and
> return error is:
> 
>    if (!var) {
>       dev_err(...);
>       return PTR_ERR(var);
>    }
> 
> So the returned value in case of error is always 0, which means 'success'.
> Change it to return -ENODEV instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>

	Sören
