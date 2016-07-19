Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 19 Jul 2016 16:17:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH 0/3] ECAM quirks handling for ARM64 platforms
Message-ID: <20160719211753.GA17840@localhost>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1464856864-18049-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 okaya@codeaurora.org, wangyijing@huawei.com, andrea.gallo@linaro.org,
 Lorenzo.Pieralisi@arm.com, linaro-acpi@lists.linaro.org,
 ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, liudongdong3@huawei.com,
 catalin.marinas@arm.com, Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com,
 msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, dhdang@apm.com,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, hanjun.guo@linaro.org,
 Suravee.Suthikulpanit@amd.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 02, 2016 at 10:41:00AM +0200, Tomasz Nowicki wrote:
> This series bases on pending ACPI PCI support for ARM64:
> https://lkml.org/lkml/2016/5/30/468
> 
> Quirk handling relies on an idea of matching MCFG OEM ID and OEM revision
> (the ones from standard header of MCFG table). Linker section is used
> so that quirks can be registered using special macro (see patches) and
> kept self contained.
> 
> As an example, last patch presents above mechanism usage for ThunderX PEM driver.
> 
> Tomasz Nowicki (3):
>   pci, acpi: Match PCI config space accessors against platfrom specific
>     ECAM quirks.
>   arm64, pci: Start using quirks handling for ACPI based PCI host
>     controller.
>   pci, pci-thunder-pem: Add ACPI support for ThunderX PEM.
> 
>  arch/arm64/kernel/pci.c            |   7 +-
>  drivers/acpi/pci_mcfg.c            |  32 +++++++++
>  drivers/pci/host/pci-thunder-pem.c | 132 +++++++++++++++++++++++++++++++++----
>  include/asm-generic/vmlinux.lds.h  |   7 ++
>  include/linux/pci-acpi.h           |  19 ++++++
>  5 files changed, 181 insertions(+), 16 deletions(-)

Is this series superceded by Dongdong's series of 6/13 ("[RFC,V2,1/2]
ACPI/PCI: Match PCI config space accessors against platfrom specific ECAM
quirks")?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
