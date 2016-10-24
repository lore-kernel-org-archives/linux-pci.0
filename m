Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
Subject: Re: [PATCH 00/12] Additional iProc PCIe host support/fixes
To: Scott Branden <scott.branden@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <1477347432-17656-1-git-send-email-ray.jui@broadcom.com>
 <14e60111-270b-39e0-6836-54b1a5422338@broadcom.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, Alex Barba <alex.barba@broadcom.com>,
 Oza Oza <oza.oza@broadcom.com>, Ray Jui <rjui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <40b6ec7d-3aa7-e5d4-06e8-d9b0f33d8956@broadcom.com>
Date: Mon, 24 Oct 2016 15:31:53 -0700
MIME-Version: 1.0
In-Reply-To: <14e60111-270b-39e0-6836-54b1a5422338@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 10/24/2016 3:30 PM, Scott Branden wrote:
> Looks fine other than spelling mistakes in some commit messages.
>
> Acked-by: Scott Branden <scott.branden@broadcom.com>
>

Thanks, Scott. I will address those in the next revision of patchset. 
But would like to get some comments from Bjorn before sending out the 
next patchset.


> On 16-10-24 03:17 PM, Ray Jui wrote:
>> This patch series contains various changes and fixes to the iProc PCIe
>> host driver. It also adds support for the next generation of PAXB and
>> PAXC based host controllers
>>
>> This patch series was developed based on v4.9-rc1 and tested on both NS2
>> SVK and Cygnus wireless audio platform
>>
>> repo: https://github.com/Broadcom/arm64-linux.git
>> branch: iproc-pcie-v1
>>
>> Ray Jui (12):
>>   PCI: iproc: Improve core register population
>>   PCI: iproc: Do not reset PAXC when initializing the driver
>>   PCI: iproc: Add BCMA type
>>   PCI: iproc: Fix exception with multi-function devices
>>   PCI: iproc: Update iProc PCIe DT binding
>>   PCI: iproc: Add PAXC v2 support
>>   PCI: iproc: Update iProc PCIe DT binding
>>   PCI: iproc: Making outbound mapping code more generic
>>   PCI: iproc: Update iProc PCIe DT binding
>>   PCI: iproc: Add inbound DMA mapping support
>>   PCI: iproc: Update iProc PCIe DT binding
>>   PCI: iproc: Add support for the next-gen PAXB controller
>>
>>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  43 +-
>>  drivers/pci/host/pcie-iproc-bcma.c                 |   1 +
>>  drivers/pci/host/pcie-iproc-msi.c                  |   1 +
>>  drivers/pci/host/pcie-iproc-platform.c             |  19 +-
>>  drivers/pci/host/pcie-iproc.c                      | 942
>> ++++++++++++++++++---
>>  drivers/pci/host/pcie-iproc.h                      |  45 +-
>>  6 files changed, 916 insertions(+), 135 deletions(-)
>>
