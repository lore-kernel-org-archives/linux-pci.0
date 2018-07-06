Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 6 Jul 2018 13:13:28 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Subject: Re: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Message-ID: <20180706111327.7gkerhkk6udfeirr@8bytes.org>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Nipun,

On Thu, Jun 21, 2018 at 03:59:27AM +0000, Nipun Gupta wrote:
> Will this patch-set be taken for the next kernel release (and via which tree)?

I can take this through IOMMU tree if nobody objects. Please work out
the last remaining comment on patch 7 with Robin and then re-send with
all Acks and Reviewed-by: tags included.

Oh, and please use 'iommu/of:' prefix instead of 'iommu: of:' and follow
that sheme for the other patches/prefixes as well.

Thanks,

	Joerg


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
