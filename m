Return-Path: <SRS0=HNZp=JZ=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=HNZp=JZ=broadcom.com=ray.jui@kernel.org>
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <20180709172251.GB16292@red-moon>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <740b4299-806d-8098-08f6-e467c7fae584@broadcom.com>
Date: Mon, 9 Jul 2018 10:29:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180709172251.GB16292@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 7/9/2018 10:22 AM, Lorenzo Pieralisi wrote:
> On Mon, Jun 11, 2018 at 05:21:02PM -0700, Ray Jui wrote:
>> This patch series improves the Broadcom PAXC support by 1) adding more
>> quirks for specific versions of PAXC controllers; 2) adding logic to
>> reject internally unconfigured physical functions from the embedded
>> network processor acting as endpoint; 3) reducing verbose print level
>> in the outbound/inbound mapping code
>>
>> This patch series is based off v4.17 and is available on GIHUB:
>> repo: https://github.com/Broadcom/arm64-linux.git
>> branch: sr-paxc-v2
>>
>> Changes since v1:
>>   - consolidate 2 PAXC related patch series into 1
>>   - change the way how the capability list corruption is handled, per
>> recommendation from Bjorn. Now handle and fix up the corruption at
>> the config register read
>>   - rebase to v4.17
>>
>> Ray Jui (5):
>>    PCI: iproc: Activate PAXC bridge quirk for more devices
>>    PCI: iproc: Fix up corrupted PAXC root complex config registers
>>    PCI: iproc: Disable MSI parsing in certain PAXC blocks
>>    PCI: iproc: Reject unconfigured physical functions from PAXC
>>    PCI: iproc: Reduce inbound/outbound mapping print level
>>
>>   drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
>>   drivers/pci/host/pcie-iproc.h |   8 +++
>>   drivers/pci/quirks.c          |   3 +
>>   3 files changed, 144 insertions(+), 26 deletions(-)
> 
> Hi Ray,
> 
> apart from patch 1, that requires Bjorn's ACK, I would take the
> series (I will rewrite the logs), I would appreciate if the amount
> of HW quirks would decrease since it is becoming quite unwieldy to
> handle them, it is your code but please get the point across.
> 
> Lorenzo
> 

Okay, thanks Lorenzo. I will ping Bjorn for patch 1.

And yes, the amount of HW quirks is overwhelming. We do have a process 
internally to track each quirk and a plan to address them in the next 
revision of the silicon based on priority, but that's largely managed by 
our ASIC team. Bottom line is the next revision of the ASIC should 
require much less of these quirks though.

Thanks,

Ray
