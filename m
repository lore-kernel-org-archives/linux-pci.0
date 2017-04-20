Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 20 Apr 2017 11:33:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 03/21] ARM64: implement pci_remap_cfgspace() interface
Message-ID: <20170420103340.GA755@e104818-lin.cambridge.arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <20170419164913.19674-4-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170419164913.19674-4-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Arnd Bergmann <arnd@arndb.de>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 19, 2017 at 05:48:52PM +0100, Lorenzo Pieralisi wrote:
> The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
> and Posting") defines rules for PCI configuration space transactions
> ordering and posting, that state that configuration writes
> are non-posted transactions.
> 
> This rule is reinforced by the ARM v8 architecture reference manual
> (issue A.k, Early Write Acknowledgment) that explicitly recommends
> that No Early Write Acknowledgment attribute should be used to map
> PCI configuration (write) transactions.
> 
> Current ioremap interface on ARM64 implements mapping functions
> where the Early Write Acknowledgment hint is enabled, so they
> cannot be used to map PCI configuration space in a PCI specs
> compliant way.
> 
> Implement an ARM64 specific pci_remap_cfgspace() interface
> that allows to map PCI config region with nGnRnE attributes, providing
> a remap function that complies with PCI specifications and the ARMv8
> architecture reference manual recommendations.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
