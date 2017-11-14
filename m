Return-Path: <SRS0=a4vc=CM=nvidia.com=vidyas@kernel.org>
Return-Path: <SRS0=a4vc=CM=nvidia.com=vidyas@kernel.org>
Subject: Re: [PATCH v1 0/4] PCI/ASPM: Fix some L1 substate configuration
To: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC: Rajat Jain <rajatja@google.com>, <linux-kernel@vger.kernel.org>
References: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <01b3d7b6-9d0e-e442-87d4-32aa6728fbd8@nvidia.com>
Date: Tue, 14 Nov 2017 18:53:19 +0530
MIME-Version: 1.0
In-Reply-To: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>


On Tuesday 14 November 2017 04:41 AM, Bjorn Helgaas wrote:
> The first two patches fix typos that cause incorrect L1 substate
> configuration.  The last two are cosmetic for maintainability.
>
> These are minor enough that I'd like to squeeze them into v4.15 unless
> anybody objects.
>
> ---
>
> Bjorn Helgaas (4):
>        PCI/ASPM: Account for downstream device's Port Common_Mode_Restore_Time
>        PCI/ASPM: Use correct capability pointer to program LTR_L1.2_THRESHOLD
>        PCI/ASPM: Reformat ASPM register definitions
>        PCI/ASPM: Add L1 Substates definitions
>
>
>   drivers/pci/pcie/aspm.c       |   38 ++++++++++++++++++++++----------------
>   include/uapi/linux/pci_regs.h |   34 ++++++++++++++++++++--------------
>   2 files changed, 42 insertions(+), 30 deletions(-)
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
