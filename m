Return-Path: <dhdang@apm.com>
Return-Path: <dhdang@apm.com>
MIME-Version: 1.0
In-Reply-To: <1470661002-26213-1-git-send-email-tn@semihalf.com>
References: <1470661002-26213-1-git-send-email-tn@semihalf.com>
From: Duc Dang <dhdang@apm.com>
Date: Tue, 30 Aug 2016 14:20:17 -0700
Message-ID: <CADaLND=pbbtVZt6bg6Lg-21v3_SU+qDJGGDH0Qf+9maf8oTA5w@mail.gmail.com>
Subject: Re: [RFC PATCH V5 0/5] ECAM quirks handling for ARM64 platforms
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Rafael Wysocki <rafael@kernel.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>, Jayachandran C <jchandra@broadcom.com>,
	Christopher Covington <cov@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Robert Richter <robert.richter@caviumnetworks.com>, Marcin Wojtas <mw@semihalf.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, David Daney <ddaney@caviumnetworks.com>,
	Yijing Wang <wangyijing@huawei.com>, Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>, linaro-acpi@lists.linaro.org,
	Jon Masters <jcm@redhat.com>, Andrea Gallo <andrea.gallo@linaro.org>, jeremy.linton@arm.com,
	Dongdong Liu <liudongdong3@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jeffrey Hugo <jhugo@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 8, 2016 at 5:56 AM, Tomasz Nowicki <tn@semihalf.com> wrote:
>
> Quirk handling relies on an idea of matching MCFG OEM ID, TABLE ID and
> revision (the ones from standard header of MCFG table).
>
> Static array is used to keep quirk entries. Each entry consists of
> mentioned MCFG IDs along with custom pci_ops structure and initialization call.
>
> As an example, the last patch presents quirk handling mechanism usage for
> ThunderX PEM driver.

Hi Tomasz,

Are you planning to change this series into a real one (not RFC) any time soon?
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
>
> --
> 1.9.1
>
Regards,
Duc Dang.
