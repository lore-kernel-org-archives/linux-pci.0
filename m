Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <1410845317.12488.2.camel@concordia>
Subject: Re: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org, linux-pci@vger.kernel.org,
	Bharat.Bhushan@freescale.com, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Chris Metcalf <cmetcalf@tilera.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Xinwei Hu <huxinwei@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	iommu@lists.linux-foundation.org, Wuyun <wuyun.wu@huawei.com>,
	linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>
Date: Tue, 16 Sep 2014 15:28:37 +1000
In-Reply-To: <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
	 <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-09-05 at 18:10 +0800, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

This looks fine and seems to boot OK.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers


