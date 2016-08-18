Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 18 Aug 2016 11:55:04 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dennis Chen <dennis.chen@arm.com>
Subject: Re: [PATCH v4 09/15] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
Message-ID: <20160818105452.GA8982@red-moon>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1471274620-20754-10-git-send-email-lorenzo.pieralisi@arm.com>
 <20160818105005.GA20404@arm.com>
MIME-Version: 1.0
In-Reply-To: <20160818105005.GA20404@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <marc.zyngier@arm.com>,
 Tomasz Nowicki <tn@semihalf.com>, Joerg Roedel <joro@8bytes.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Hanjun Guo <hanjun.guo@linaro.org>,
 Jon Masters <jcm@redhat.com>, nd@arm.com, Robin Murphy <robin.murphy@arm.com>,
 Nate Watterson <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 18, 2016 at 06:50:07PM +0800, Dennis Chen wrote:

[...]

> > +static void __init iort_smmu_init(void)
> > +{
> > +	struct acpi_iort_node *iort_node, *iort_end;
> > +	struct acpi_table_iort *iort;
> > +	struct fwnode_handle *fwnode;
> > +	int i, ret;
> > +
> > +	/*
> > +	 * table and iort will both point to the start of IORT table, but
> > +	 * have different struct types
> > +	 */
> > +	iort = (struct acpi_table_iort *)iort_table;
> >
> If the firmware of a platform happens to miss the IORT table, then
> iort_table here will be a NULL pointer, in this case 'NULL pointer
> dereference' kernel panic will occur, if this is not an expected
> behavior then we can add a sanity check here to avoid this.  IORT
> missing is a fatal error? I don't think so.

Yes, I've already fixed it, thanks for pointing that out.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
