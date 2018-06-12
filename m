Return-Path: <SRS0=sfZ0=I6=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=sfZ0=I6=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 12 Jun 2018 23:14:59 +0530
From: poza@codeaurora.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2 3/5] PCI: iproc: Disable MSI parsing in certain PAXC
 blocks
In-Reply-To: <c44bf00c-b412-2cd1-75ee-7541bc775173@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-4-git-send-email-ray.jui@broadcom.com>
 <8f6d7771baec3f56e0ccf5efd0efe2a2@codeaurora.org>
 <c44bf00c-b412-2cd1-75ee-7541bc775173@broadcom.com>
Message-ID: <5dab98f1205c33320422ea1732bc6fba@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-06-12 22:28, Ray Jui wrote:
> On 6/12/2018 1:29 AM, poza@codeaurora.org wrote:
>> On 2018-06-12 05:51, Ray Jui wrote:
>>> The internal MSI parsing logic in certain revisions of PAXC root
>>> complexes does not work properly and can casue corruptions on the
>>> writes. They need to be disabled
>>> 
>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>  drivers/pci/host/pcie-iproc.c | 34 
>>> ++++++++++++++++++++++++++++++++--
>>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/pci/host/pcie-iproc.c 
>>> b/drivers/pci/host/pcie-iproc.c
>>> index 680f6b1..0804aa2 100644
>>> --- a/drivers/pci/host/pcie-iproc.c
>>> +++ b/drivers/pci/host/pcie-iproc.c
>>> @@ -1197,10 +1197,22 @@ static int 
>>> iproc_pcie_paxb_v2_msi_steer(struct
>>> iproc_pcie *pcie, u64 msi_addr)
>>>      return ret;
>>>  }
>>> 
>>> -static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, 
>>> u64 msi_addr)
>>> +static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, 
>>> u64 msi_addr,
>>> +                     bool enable)
>>>  {
>>>      u32 val;
>>> 
>>> +    if (!enable) {
>>> +        /*
>>> +         * Disable PAXC MSI steering. All write transfers will be
>>> +         * treated as non-MSI transfers
>>> +         */
>>> +        val = iproc_pcie_read_reg(pcie, IPROC_PCIE_MSI_EN_CFG);
>>> +        val &= ~MSI_ENABLE_CFG;
>>> +        iproc_pcie_write_reg(pcie, IPROC_PCIE_MSI_EN_CFG, val);
>>> +        return;
>> can be dropped.
> 
> 
> No it cannot be dropped. Please review the code carefully.

Ahhh, my bad, it looked like a new function to me, may e I need sleep.
sorry about that.

Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
