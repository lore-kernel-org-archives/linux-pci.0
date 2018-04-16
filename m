Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 04/12] iommu-helper: move the IOMMU_HELPER config symbol
 to lib/
To: Christoph Hellwig <hch@lst.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 iommu@lists.linux-foundation.org
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-5-hch@lst.de>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 15:13:04 +0530
MIME-Version: 1.0
In-Reply-To: <20180415145947.1248-5-hch@lst.de>
Message-Id: <69224eb2-7056-4894-36d8-c6e9518df647@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> This way we have one central definition of it, and user can select it as
> needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
