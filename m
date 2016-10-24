Return-Path: <ray.jui@broadcom.com>
Return-Path: <ray.jui@broadcom.com>
Subject: Re: [PATCH 00/12] Additional iProc PCIe host support/fixes
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1477347432-17656-1-git-send-email-ray.jui@broadcom.com>
 <20161024225238.GA27451@localhost>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Alex Barba <alex.barba@broadcom.com>, Oza Oza <oza.oza@broadcom.com>,
 Ray Jui <rjui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <34217f37-4962-2893-cf6a-01620d0a95a5@broadcom.com>
Date: Mon, 24 Oct 2016 15:54:02 -0700
MIME-Version: 1.0
In-Reply-To: <20161024225238.GA27451@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 10/24/2016 3:52 PM, Bjorn Helgaas wrote:
> Hi Ray,
>
> On Mon, Oct 24, 2016 at 03:17:00PM -0700, Ray Jui wrote:
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
>
> I'll look at these more soon, but there are four patches above with
> identical titles ("PCI: iproc: Update iProc PCIe DT binding").  The
> "iProc PCIe" part is a little redundant; can you remove that and
> instead include a hint about what each patch is about, e.g.,
> "add optional dma-ranges", "remove outbound window properties", etc?
>

Yes, I'll certainly do that in the next revision of the patchset.

Thanks,

Ray
