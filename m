Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Jan 2016 17:59:58 +0000
From: Will Deacon <will.deacon@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3 1/2] PCI: generic: Refactor code to enable reuse by
 other drivers.
Message-ID: <20160112175958.GA22186@arm.com>
References: <1452297553-19911-1-git-send-email-ddaney.cavm@gmail.com>
 <1452297553-19911-2-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452297553-19911-2-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 08, 2016 at 03:59:12PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> No change in functionality.
> 
> Move structure definitions into a separate header file.  Move common
> code to new file with Kconfig machinery to build it.  Split probe
> function in to two parts:
> 
>    - a small driver specific probe function (gen_pci_probe)
> 
>    - a common probe that can be used by other drivers
>      (pci_host_common_probe)
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  MAINTAINERS                         |   1 +
>  drivers/pci/host/Kconfig            |   4 +
>  drivers/pci/host/Makefile           |   1 +
>  drivers/pci/host/pci-host-common.c  | 194 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pci-host-common.h  |  56 +++++++++++
>  drivers/pci/host/pci-host-generic.c | 190 +----------------------------------
>  6 files changed, 260 insertions(+), 186 deletions(-)
>  create mode 100644 drivers/pci/host/pci-host-common.c
>  create mode 100644 drivers/pci/host/pci-host-common.h

Looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
