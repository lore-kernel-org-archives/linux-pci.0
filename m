Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 9 Aug 2016 12:29:26 +0200
From: Robert Richter <robert.richter@cavium.com>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH V5 0/5] ECAM quirks handling for ARM64 platforms
Message-ID: <20160809102926.GT22012@rric.localdomain>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1470661541-26270-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, rafael@kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com,
 andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com, jhugo@codeaurora.org,
 linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com,
 linux-acpi@vger.kernel.org, helgaas@kernel.org, liudongdong3@huawei.com,
 linux-pci@vger.kernel.org, Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com,
 msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com,
 ard.biesheuvel@linaro.org, dhdang@apm.com, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, hanjun.guo@linaro.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 08.08.16 15:05:36, Tomasz Nowicki wrote:
> Quirk handling relies on an idea of matching MCFG OEM ID, TABLE ID and
> revision (the ones from standard header of MCFG table).
> 
> Static array is used to keep quirk entries. Each entry consists of
> mentioned MCFG IDs along with custom pci_ops structure and initialization call.
> 
> As an example, the last patch presents quirk handling mechanism usage for
> ThunderX PEM driver.
> 
> v4 -> v5
> - rebase against v4.8-rc1
> - rework to exact MCFG OEM ID, TABLE ID, rev match
>   - use memcmp instead of strncmp
>   - no substring match
> - fix typos and dmesg message
> 
> Tomasz Nowicki (5):
>   PCI: Embed pci_ecam_ops in pci_config_window structure
>   PCI/ACPI: Move ACPI ECAM mapping to generic MCFG driver
>   PCI: Check platform specific ECAM quirks
>   ARM64/PCI: Start using quirks handling for ACPI based PCI host
>     controller
>   PCI: thunder-pem: Support quirky configuration space access for ACPI
>     based PCI host controller
> 
>  arch/arm64/kernel/pci.c            | 42 +----------------
>  drivers/acpi/pci_mcfg.c            | 40 ++++++++++++++++
>  drivers/pci/ecam.c                 |  6 +--
>  drivers/pci/host/Makefile          |  1 +
>  drivers/pci/host/mcfg-quirks.c     | 93 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/mcfg-quirks.h     | 24 ++++++++++
>  drivers/pci/host/pci-thunder-pem.c | 96 ++++++++++++++++++++++++++++++++------
>  include/linux/pci-acpi.h           |  5 ++
>  include/linux/pci-ecam.h           |  2 +-
>  9 files changed, 252 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/pci/host/mcfg-quirks.c
>  create mode 100644 drivers/pci/host/mcfg-quirks.h

For the whole series

Reviewed-by: Robert Richter <rrichter@cavium.com>
Tested-by: Robert Richter <rrichter@cavium.com>

Test included:

 [PATCH V7 0/8] Introduce ACPI world to ITS irqchip

Thanks Tomasz,

-Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
