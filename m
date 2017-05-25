Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 25 May 2017 16:53:26 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ARM64: PCI: Fix struct acpi_pci_root_ops allocation
 failure path
Message-ID: <20170525155326.GB1610@e104818-lin.cambridge.arm.com>
References: <20170522154828.10872-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170522154828.10872-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Timmy Li <lixiaoping3@huawei.com>, Tomasz Nowicki <tn@semihalf.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 22, 2017 at 04:48:28PM +0100, Lorenzo Pieralisi wrote:
> From: Timmy Li <lixiaoping3@huawei.com>
> 
> Commit 093d24a20442 ("arm64: PCI: Manage controller-specific data on
> per-controller basis") added code to allocate ACPI PCI root_ops
> dynamically on a per host bridge basis but failed to update the
> corresponding memory allocation failure path in pci_acpi_scan_root()
> leading to a potential memory leakage.
> 
> Fix it by adding the required kfree call.
> 
> Fixes: 093d24a20442 ("arm64: PCI: Manage controller-specific data on per-controller basis")
> Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
> [lorenzo.pieralisi@arm.com: refactored code, rewrote commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>

I queued the patch for 4.12. Thanks.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
