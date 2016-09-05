Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 5 Sep 2016 15:57:51 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v4 05/15] drivers: platform: add fwnode base platform
 devices retrieval
Message-ID: <20160905145751.GA7480@red-moon>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1471274620-20754-6-git-send-email-lorenzo.pieralisi@arm.com>
 <7659b956-c49d-bd0d-7a1d-8dfc3da6f409@linaro.org>
MIME-Version: 1.0
In-Reply-To: <7659b956-c49d-bd0d-7a1d-8dfc3da6f409@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-pci@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Nate Watterson <nwatters@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>,
 Dennis Chen <dennis.chen@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 05, 2016 at 09:19:43PM +0800, Hanjun Guo wrote:
> On 2016/8/15 23:23, Lorenzo Pieralisi wrote:
> >The platform device kernel API does not provide functions to
> >retrieve a platform device through the corresponding struct
> >device fwnode pointer.
> >
> >Implement the fwnode platform_device look-up in drivers core
> >code by using the bus_find_device() API and a corresponding
> >matching function. The OF equivalent (eg of_find_device_by_node())
> >will reuse the newly introduced function when OF code will
> >take care of setting up the device->fwnode value that is
> >currently left dangling for platform devices instantiated out
> >of device tree nodes.
> >
> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >---
> > drivers/base/platform.c         | 23 +++++++++++++++++++++++
> > include/linux/platform_device.h |  3 +++
> > 2 files changed, 26 insertions(+)
> >
> >diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> >index 6482d47..3ef150d 100644
> >--- a/drivers/base/platform.c
> >+++ b/drivers/base/platform.c
> >@@ -760,6 +760,29 @@ err_out:
> > }
> > EXPORT_SYMBOL_GPL(__platform_create_bundle);
> >
> >+static int fwnode_dev_match(struct device *dev, void *data)
> >+{
> >+	return dev->fwnode == data;
> >+}
> >+
> >+/**
> >+ * platform_find_device_by_fwnode() - Find the platform_device associated
> >+ *				      with a fwnode
> >+ * @fwnode: Pointer to firmware node
> >+ *
> >+ * Returns platform_device pointer, or NULL if not found
> >+ */
> >+struct platform_device *
> >+platform_find_device_by_fwnode(struct fwnode_handle *fwnode)
> >+{
> >+	struct device *dev;
> >+
> >+	dev = bus_find_device(&platform_bus_type, NULL, fwnode,
> >+			      fwnode_dev_match);
> >+	return dev ? to_platform_device(dev) : NULL;
> >+}
> >+EXPORT_SYMBOL(platform_find_device_by_fwnode);
> 
> As SMMU is registered as platform devices, I think we need such
> API to retrieve the platform device with fwnode handle, actually
> Kefeng introduced a similar patch [1], but your patch is more
> generic, so this patch make sense to me,
> 
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks ! Strictly speaking, with Robin's new series:

https://lists.linuxfoundation.org/pipermail/iommu/2016-August/018230.html


(and corresponding v5 of this one that I have rebased on top of it) we
do not need this patch any longer and it is not really that generic
keeping in mind that it can't be used for DT matching (because in DT
dev->fwnode is dangling); I will see if I keep this patch according
to dependencies.

Side note: I have a problem with [1], since that code is there to
implement DT phandles in ACPI IIUC and we must really prevent that :)

Thanks !
Lorenzo

> Thanks
> Hanjun
> 
> [1]: https://patchwork.kernel.org/patch/7743661/
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
