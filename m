Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for
 other devices too
Date: Mon, 30 Apr 2018 03:27:16 +0000
Message-ID: <DB6PR0401MB2424DEAB9AE3C3A78ED348C5E6820@DB6PR0401MB2424.eurprd04.prod.outlook.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1524824826-29473-3-git-send-email-nipun.gupta@nxp.com>
 <20180427171537.lvzygghnuolk6cnh@rob-hp-laptop>
In-Reply-To: <20180427171537.lvzygghnuolk6cnh@rob-hp-laptop>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, April 27, 2018 10:46 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: robin.murphy@arm.com; will.deacon@arm.com; mark.rutland@arm.com;
> catalin.marinas@arm.com; hch@lst.de; gregkh@linuxfoundation.org;
> joro@8bytes.org; m.szyprowski@samsung.com; shawnguo@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linux-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Laurentiu Tudor <laurentiu.tudor@nxp.com>; Leo Li
> <leoyang.li@nxp.com>
> Subject: Re: [PATCH 2/6 v3] iommu: of: make of_pci_map_rid() available for
> other devices too
> 
> On Fri, Apr 27, 2018 at 03:57:02PM +0530, Nipun Gupta wrote:
> > iommu-map property is also used by devices with fsl-mc. This
> > patch moves the of_pci_map_rid to generic location, so that it
> > can be used by other busses too.
> >
> > 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> > functional change done in the API.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> >  drivers/iommu/of_iommu.c   |   6 +--
> >  drivers/of/address.c       | 102
> +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/of/irq.c           |   7 ++--
> >  drivers/pci/of.c           | 101 --------------------------------------------
> >  include/linux/of_address.h |  11 +++++
> >  include/linux/of_pci.h     |  10 -----
> >  6 files changed, 120 insertions(+), 117 deletions(-)
> 
> of/address.c isn't really the best fit either, though I don't have a
> better suggestion.
> 
> I'm guessing this breaks on Sparc which doesn't build of/address.c.
> I guess move it to base.c and of.h if that is the case.

Sure, that makes sense. Thank you for the suggestion !!
I'll spin off new version with this change.

Regards,
Nipun

> 
> Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
