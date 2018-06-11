Return-Path: <SRS0=bwDY=I5=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=bwDY=I5=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 11 Jun 2018 13:47:26 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] PCI/portdrv: Squash into one file
In-Reply-To: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848853199.14051.12670957565366345798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <1ade8ebfbd2e02177d2f6afa3d805bb0@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-09 01:42, Bjorn Helgaas wrote:
> The portdrv code is scattered across several files, which makes it a 
> bit of
> a hassle to browse.  Consolidate it all in a single file.
> 

Although I do not have any objection is merging the code,

It looks to me that the 2 files served purpose of keeping
portdrv device functionality in  one file > portdrv_pci.c
while, port driver helper and exported service functions for services 
are in > portdrv_core.c

If that was the original intention, it just looks okay to me.
But I am not sure the way the code is now, we can call is scattered,
and also I do not think by merging it, we can call it more organised.

although certainly it looks easier to browse as you are suggesting.
little less confusing.

> This is all pure code moves; no functional changes intended.  Well, 
> there
> is a function rename, but it shouldn't change any behavior.
> 
> ---
> 
> Bjorn Helgaas (9):
>       PCI/portdrv: Rename resume_iter() to prevent name collision
>       PCI/portdrv: Squash pieces of portdrv_core.c into portdrv_pci.c
>       PCI/portdrv: Squash PM-related code into portdrv_pci.c
>       PCI/portdrv: Squash device removal code into portdrv_pci.c
>       PCI/portdrv: Squash lookup interfaces into portdrv_pci.c
>       PCI/portdrv: Squash service driver registration into 
> portdrv_pci.c
>       PCI/portdrv: Move private definitions to portdrv_pci.c
>       PCI/portdrv: Clean up whitespace
>       PCI/portdrv: Rename portdrv_pci.c to portdrv.c
> 
> 
>  drivers/pci/pcie/Makefile       |    6
>  drivers/pci/pcie/portdrv.c      |  822 
> +++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h      |   15 -
>  drivers/pci/pcie/portdrv_core.c |  578 ---------------------------
>  drivers/pci/pcie/portdrv_pci.c  |  261 ------------
>  5 files changed, 824 insertions(+), 858 deletions(-)
>  create mode 100644 drivers/pci/pcie/portdrv.c
>  delete mode 100644 drivers/pci/pcie/portdrv_core.c
>  delete mode 100644 drivers/pci/pcie/portdrv_pci.c
