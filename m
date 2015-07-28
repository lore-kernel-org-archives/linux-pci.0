Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] PCI: iproc: enable arm64 support for iProc PCIe
To: Olof Johansson <olof@lixom.net>
References: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
 <1438036941-27210-2-git-send-email-rjui@broadcom.com>
 <CAOesGMh2Dz2HWpAg0Yh71QYfnAyMRae929p=mqGmopGdrVWgxQ@mail.gmail.com>
CC: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Broadcom Kernel Feedback List
	<bcm-kernel-feedback-list@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"arm@kernel.org" <arm@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <55B7A461.5040807@broadcom.com>
Date: Tue, 28 Jul 2015 08:48:49 -0700
MIME-Version: 1.0
In-Reply-To: <CAOesGMh2Dz2HWpAg0Yh71QYfnAyMRae929p=mqGmopGdrVWgxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 7/28/2015 6:24 AM, Olof Johansson wrote:
> Hi Ray,
> 
> I get the following when building an allmodconfig on arm64:
> 
> drivers/pci/host/pcie-iproc-bcma.c: In function 'iproc_pcie_bcma_map_irq':
> drivers/pci/host/pcie-iproc-bcma.c:37:31: error: dereferencing pointer
> to incomplete type
>   struct iproc_pcie *pcie = sys->private_data;
>                                ^
> 
> Should be easy for you to reproduce, please send incremental fix.
> 
> 
> -Olof

This looks like a dependency issue of the iProc PCIe BCMA driver, which
should really be disabled for arm64 as it's only available on legacy
arm32 based Broadcom SoCs.

I'll submit an incremental fix in Kconfig.

Thanks,

Ray
