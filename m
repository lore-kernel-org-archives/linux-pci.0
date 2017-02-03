Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Sricharan" <sricharan@codeaurora.org>
To: "'Nate Watterson'" <nwatters@codeaurora.org>,
 "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>
References: <f2370671-ece8-fbee-de19-350dd625088f@codeaurora.org>
 <93e79759-d614-9b36-d5ab-63e8eb725009@arm.com>
 <14751205-f034-7f0d-442a-854c3909425c@codeaurora.org>
 <5ba9f366d6e25397cdef8ad95b49e199@codeaurora.org>
 <175a3798-b824-ef1a-e112-9f6f472973ae@codeaurora.org>
 <20170130143851.GJ16461@arm.com>
 <b2e50c17de156341deab9fb8e91a8dec@codeaurora.org>
 <1e048aff-0d77-b9f2-ebf8-2ba315b90ca7@codeaurora.org>
 <20170130165124.GA11712@red-moon>
 <f401e27e-d619-0eec-2401-50d8e2fc2f0f@codeaurora.org>
 <20170201185230.GA1922@red-moon>
 <3f4aa4c1e660c7e62256de9ca64fc822@codeaurora.org>
In-Reply-To: <3f4aa4c1e660c7e62256de9ca64fc822@codeaurora.org>
Subject: RE: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
 deferred probing or error
Date: Fri, 3 Feb 2017 09:07:07 +0530
Message-ID: <013f01d27dce$cf8f5da0$6eae18e0$@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, 'Will Deacon' <will.deacon@arm.com>,
 'Sinan Kaya' <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, 'Tomasz Nowicki' <tn@semihalf.com>,
 'Robin Murphy' <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

>On 2017-02-01 13:52, Lorenzo Pieralisi wrote:
>>
>> I debugged the issue and Nate's fix is correct, the fact that you
>> can't it hit it with mainline is just a matter of timing because it has
>> to do with the CTX pointer value (we OR it with the existing value), so
>> it may work or not depending on how the cdptr memory allocation
>> pattern turns out to be (which explains why Nate and I can hit it with
>> simple PCI device remove/add execution too).
>>
>> So it is neither an ACPI nor an IOMMU probe deferral issue per-se,
>> fix is already queued, so it is all good.
>>
>> What about USB stalls ?
>Our fault. The USB controller was getting 48-bit IOVAs, but the
>bus it sits on only supports 44-bits so the controller's DMA
>transactions ended up targeting addresses that were never mapped.
>
>It started working once I applied the iort/dma-mapping patches I
>sent out earlier this week that use the iort memory_address_limit
>field to check if a dma_mask is sane.
>
>Sorry for the false alarm.

Ok, thanks for closing on it. I will just post V8 with all acks picked up and
Robin's fix , right away.

Regards,
 Sricharan


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
