Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
To: David Miller <davem@davemloft.net>, khandual@linux.vnet.ibm.com
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-2-hch@lst.de>
 <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
 <20180416.095833.969403163564136309.davem@davemloft.net>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 11:20:58 +0530
MIME-Version: 1.0
In-Reply-To: <20180416.095833.969403163564136309.davem@davemloft.net>
Message-Id: <f5741528-427d-3537-5498-2080766df0fe@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
 konrad.wilk@oracle.com, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
 sparclinux@vger.kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 04/16/2018 07:28 PM, David Miller wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Date: Mon, 16 Apr 2018 14:26:07 +0530
> 
>> On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
>>> This code is only used by sparc, and all new iommu drivers should use the
>>> drivers/iommu/ framework.  Also remove the unused exports.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Right, these functions are used only from SPARC architecture. Simple
>> git grep confirms it as well. Hence it makes sense to move them into
>> arch code instead.
> 
> Well, we put these into a common location and used type friendly for
> powerpc because we hoped powerpc would convert over to using this
> common piece of code as well.
> 
> But nobody did the powerpc work.
> 
> If you look at the powerpc iommu support, it's the same code basically
> for entry allocation.

I understand. But there are some differences in iommu_table structure,
how both regular and large IOMMU pools are being initialized etc. So
if the movement of code into SPARC help cleaning up these generic config
options in general, I guess we should do that. But I will leave it upto
others who have more experience in this area.

+mpe


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
