Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v8 12/16] drivers: iommu: arm-smmu: split probe functions
 into DT/generic portions
To: Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
 <20161116152936.22955-13-lorenzo.pieralisi@arm.com>
 <20161118160006.GW13470@arm.com>
Cc: iommu@lists.linux-foundation.org,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <28abb42b-4a93-fbb0-d8bb-e6b82b2b992f@arm.com>
Date: Fri, 18 Nov 2016 16:43:30 +0000
MIME-Version: 1.0
In-Reply-To: <20161118160006.GW13470@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18/11/16 16:00, Will Deacon wrote:
> On Wed, Nov 16, 2016 at 03:29:32PM +0000, Lorenzo Pieralisi wrote:
>> Current ARM SMMU probe functions intermingle HW and DT probing
>> in the initialization functions to detect and programme the ARM SMMU
>> driver features. In order to allow probing the ARM SMMU with other
>> firmwares than DT, this patch splits the ARM SMMU init functions into
>> DT and HW specific portions so that other FW interfaces (ie ACPI) can
>> reuse the HW probing functions and skip the DT portion accordingly.
>>
>> This patch implements no functional change, only code reshuffling.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
>> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Tomasz Nowicki <tn@semihalf.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Hanjun Guo <hanjun.guo@linaro.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  drivers/iommu/arm-smmu.c | 62 +++++++++++++++++++++++++++++-------------------
>>  1 file changed, 37 insertions(+), 25 deletions(-)
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> 
> Although I'd also like Robin to have a look at this.

Sorry, I've been slow this week. Having finally got round to taking a
proper look, I swear this seems even tidier than the last version I
looked at closely. It doesn't break DT boot on my Juno, either.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> 
> Will
> 

