Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 20 Apr 2017 16:31:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robin.murphy@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
        okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH V11 00/11] IOMMU probe deferral support
Message-ID: <20170420143157.GG7266@8bytes.org>
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 10, 2017 at 04:50:55PM +0530, Sricharan R wrote:
>  arch/arm64/mm/dma-mapping.c       | 142 +++++---------------------------------
>  drivers/acpi/arm64/iort.c         |  48 ++++++++++++-
>  drivers/acpi/glue.c               |   5 --
>  drivers/acpi/scan.c               |  11 ++-
>  drivers/base/dd.c                 |   9 +++
>  drivers/base/dma-mapping.c        |  41 +++++++++++
>  drivers/iommu/arm-smmu-v3.c       |  46 +-----------
>  drivers/iommu/arm-smmu.c          | 110 +++++++++++++----------------
>  drivers/iommu/of_iommu.c          | 126 ++++++++++++++++++++++++---------
>  drivers/of/device.c               |  23 +++++-
>  drivers/of/platform.c             |  10 +--
>  drivers/pci/probe.c               |  28 --------
>  include/acpi/acpi_bus.h           |   2 +-
>  include/asm-generic/vmlinux.lds.h |   1 -
>  include/linux/acpi.h              |   7 +-
>  include/linux/acpi_iort.h         |   3 -
>  include/linux/dma-mapping.h       |  12 ++++
>  include/linux/of_device.h         |  10 ++-
>  18 files changed, 312 insertions(+), 322 deletions(-)

Applied, thanks.
