Return-Path: <SRS0=A2mq=JU=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=A2mq=JU=broadcom.com=ray.jui@kernel.org>
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <45945371-3cd7-102d-bb47-69a60435542b@broadcom.com>
 <20180621164821.GA14519@e107981-ln.cambridge.arm.com>
 <e573bad0-05b1-c00f-8815-6ebe26218f05@broadcom.com>
Message-ID: <dfc2a3d4-dbdb-5ebc-c000-b824d4d2075d@broadcom.com>
Date: Tue, 3 Jul 2018 22:02:38 -0700
MIME-Version: 1.0
In-Reply-To: <e573bad0-05b1-c00f-8815-6ebe26218f05@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

A friendly reminder: Have you had a chance to help to review the patch 
series below?

Thanks,

Ray

On 6/21/2018 11:22 AM, Ray Jui wrote:
> Hi Lorenzo,
> 
> On 6/21/2018 9:48 AM, Lorenzo Pieralisi wrote:
>> On Wed, Jun 20, 2018 at 10:26:28AM -0700, Ray Jui wrote:
>>> Hi Lorenzo/Bjorn,
>>>
>>> Could you please help to review this patch series when you have time?
>>>
>>> I believe I have addressed major comment in v1 from Bjorn and 
>>> answered all
>>> questions from Lorenzo.
>>
>> I will have a look next week, sorry for the delay.
> 
> Thanks a lot. Much appreciated!
> 
> Ray
> 
>>
>> Thanks,
>> Lorenzo
>>
>>> Thanks,
>>>
>>> Ray
>>>
>>> On 6/11/2018 5:21 PM, Ray Jui wrote:
>>>> This patch series improves the Broadcom PAXC support by 1) adding more
>>>> quirks for specific versions of PAXC controllers; 2) adding logic to
>>>> reject internally unconfigured physical functions from the embedded
>>>> network processor acting as endpoint; 3) reducing verbose print level
>>>> in the outbound/inbound mapping code
>>>>
>>>> This patch series is based off v4.17 and is available on GIHUB:
>>>> repo: https://github.com/Broadcom/arm64-linux.git
>>>> branch: sr-paxc-v2
>>>>
>>>> Changes since v1:
>>>>   - consolidate 2 PAXC related patch series into 1
>>>>   - change the way how the capability list corruption is handled, per
>>>> recommendation from Bjorn. Now handle and fix up the corruption at
>>>> the config register read
>>>>   - rebase to v4.17
>>>>
>>>> Ray Jui (5):
>>>>    PCI: iproc: Activate PAXC bridge quirk for more devices
>>>>    PCI: iproc: Fix up corrupted PAXC root complex config registers
>>>>    PCI: iproc: Disable MSI parsing in certain PAXC blocks
>>>>    PCI: iproc: Reject unconfigured physical functions from PAXC
>>>>    PCI: iproc: Reduce inbound/outbound mapping print level
>>>>
>>>>   drivers/pci/host/pcie-iproc.c | 159 
>>>> +++++++++++++++++++++++++++++++++++-------
>>>>   drivers/pci/host/pcie-iproc.h |   8 +++
>>>>   drivers/pci/quirks.c          |   3 +
>>>>   3 files changed, 144 insertions(+), 26 deletions(-)
>>>>
