Return-Path: <SRS0=uItE=IE=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=uItE=IE=broadcom.com=ray.jui@kernel.org>
Subject: Re: [PATCH INTERNAL 0/3] Add Broadcom PAXC related quirks
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
References: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <025a6e7e-a6dc-c1ee-77cd-a78439bd17d9@broadcom.com>
Date: Thu, 17 May 2018 10:23:46 -0700
MIME-Version: 1.0
In-Reply-To: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn/Lorenzo,

My bad for having this "INTERNAL" tag in the subject. Please let me know 
if you need me to send out another set with that removed.

Thanks,

Ray

On 5/17/2018 10:21 AM, Ray Jui wrote:
> This patch series adds quirks to work around a few issues related to
> certain revisions of Broadcom PAXC based PCIe root complexes
> 
> This patch series is based off v4.17-rc5 and is available on GIHUB:
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: sr-paxc-quirk-v1
> 
> Ray Jui (3):
>    PCI: iproc: Activate PAXC bridge quirk for more devices
>    PCI: iproc: Fix up corrupted PAXC root complex config registers
>    PCI: iproc: Disable MSI parsing in certain PAXC blocks
> 
>   drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++-
>   drivers/pci/quirks.c          | 98 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 130 insertions(+), 2 deletions(-)
> 
