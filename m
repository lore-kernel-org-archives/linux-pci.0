Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 21 Apr 2017 11:23:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [GIT PULL] PCI fixes for v4.11
Message-ID: <20170421162312.GA17726@bhelgaas-glaptop.roam.corp.google.com>
References: <20170421162058.GA17645@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170421162058.GA17645@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, linux-kernel, Mark, Dongdong]

On Fri, Apr 21, 2017 at 11:20:58AM -0500, Bjorn Helgaas wrote:
> Hi Linus,
> 
> Sorry this is so late.  It's been in -next for over a week, but I forgot to
> send it on until now.
> 
> 
> PCI fix:
> 
>   - fix HiSilicon DT binding
> 
> The following changes since commit 794a8604fe6e4a311373cde57a86ad4aab9d32b8:
> 
>   PCI: dwc: Fix dw_pcie_ops NULL pointer dereference (2017-04-04 08:24:25 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.11-fixes-5
> 
> for you to fetch changes up to b9c1153f7a9cb2d53b845615a0edd510f7fe8341:
> 
>   PCI: hisi: Fix DT binding (hisi-pcie-almost-ecam) (2017-04-12 10:46:47 -0500)
> 
> ----------------------------------------------------------------
> pci-v4.11-fixes-5
> 
> ----------------------------------------------------------------
> Dongdong Liu (1):
>       PCI: hisi: Fix DT binding (hisi-pcie-almost-ecam)
> 
>  Documentation/devicetree/bindings/pci/hisilicon-pcie.txt | 10 ++++++++--
>  drivers/pci/dwc/pcie-hisi.c                              |  6 +++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
