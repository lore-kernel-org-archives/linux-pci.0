Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 30 Mar 2017 17:19:31 +0100
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 05/22] ARM64: implement ioremap_nopost() interface
Message-ID: <20170330161931.GA5623@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-6-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170327094954.7162-6-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 John Garry <john.garry@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 27, 2017 at 10:49:33AM +0100, Lorenzo Pieralisi wrote:
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
> Implement an ARM64 specific ioremap_nopost() interface
> that allows to map PCI config region with nGnRnE attributes, providing
> a remap function that complies with PCI specifications and the ARMv8
> architecture reference manual recommendations.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/io.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Will Deacon <will.deacon@arm.com>

Let me know if you need this taken via the arm64 tree.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
