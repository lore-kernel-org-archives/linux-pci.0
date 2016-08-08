Return-Path: <msalter@redhat.com>
Return-Path: <msalter@redhat.com>
Message-ID: <1470685445.3551.37.camel@redhat.com>
Subject: Re: [RFC PATCH V5 0/5] ECAM quirks handling for ARM64 platforms
From: Mark Salter <msalter@redhat.com>
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org, arnd@arndb.de,
        will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
        Lorenzo.Pieralisi@arm.com
Cc: hanjun.guo@linaro.org, okaya@codeaurora.org, jchandra@broadcom.com,
        cov@codeaurora.org, dhdang@apm.com, ard.biesheuvel@linaro.org,
        robert.richter@caviumnetworks.com, mw@semihalf.com,
        Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
        jeremy.linton@arm.com, liudongdong3@huawei.com,
        gabriele.paoloni@huawei.com, jhugo@codeaurora.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 08 Aug 2016 15:44:05 -0400
In-Reply-To: <1470661541-26270-1-git-send-email-tn@semihalf.com>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2016-08-08 at 15:05 +0200, Tomasz Nowicki wrote:
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
>   - use memcmp instead of strncmp
>   - no substring match
> - fix typos and dmesg message
> 
> Tomasz Nowicki (5):
>   PCI: Embed pci_ecam_ops in pci_config_window structure
>   PCI/ACPI: Move ACPI ECAM mapping to generic MCFG driver
>   PCI: Check platform specific ECAM quirks
>   ARM64/PCI: Start using quirks handling for ACPI based PCI host
>     controller
>   PCI: thunder-pem: Support quirky configuration space access for ACPI
>     based PCI host controller
> 
>  arch/arm64/kernel/pci.c            | 42 +----------------
>  drivers/acpi/pci_mcfg.c            | 40 ++++++++++++++++
>  drivers/pci/ecam.c                 |  6 +--
>  drivers/pci/host/Makefile          |  1 +
>  drivers/pci/host/mcfg-quirks.c     | 93 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/mcfg-quirks.h     | 24 ++++++++++
>  drivers/pci/host/pci-thunder-pem.c | 96 ++++++++++++++++++++++++++++++++------
>  include/linux/pci-acpi.h           |  5 ++
>  include/linux/pci-ecam.h           |  2 +-
>  9 files changed, 252 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/pci/host/mcfg-quirks.c
>  create mode 100644 drivers/pci/host/mcfg-quirks.h
> 

Tested-by: Mark Salter <msalter@redhat.com>
