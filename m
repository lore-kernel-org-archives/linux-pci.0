Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 11 Apr 2017 14:34:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL] PCI: Support for configurable PCI endpoint
Message-ID: <20170411193447.GA14778@bhelgaas-glaptop.roam.corp.google.com>
References: <20170405085243.18123-1-kishon@ti.com>
 <20170410154328.GB13170@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <20170410154328.GB13170@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, hch@infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 10, 2017 at 10:43:28AM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 05, 2017 at 02:22:20PM +0530, Kishon Vijay Abraham I wrote:
> > Hi Bjorn,
> > 
> > Please find the pull request for PCI endpoint support below. I've
> > also included all the history here.
> 
> Thanks, I applied these (with v7 of the first patch) to pci/host-designware
> for v4.12.

Ok, sorry, I screwed this up.  I think my branch actually had v5, not
v6.  But I *think* I fixed it.  Here's the diff from my branch to your
git tree.  Apparently you haven't pushed the v7 patch there, so I
*think* the diff below is the diff between v6 and v7 of that first
patch.

$ git diff pci/host-designware a5c85ba45c96
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index caa7be10e473..9ae9e59b2a74 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,7 +83,6 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 			goto err;
 		}
 
-		class_dev_iter_exit(&iter);
 		get_device(&epc->dev);
 		return epc;
 	}
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 6877d6a5bcc9..92db7dcd911c 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -40,10 +40,8 @@ static struct device_type pci_epf_type;
  */
 void pci_epf_linkup(struct pci_epf *epf)
 {
-	if (!epf->driver) {
+	if (!epf->driver)
 		dev_WARN(&epf->dev, "epf device not bound to driver\n");
-		return;
-	}
 
 	epf->driver->ops->linkup(epf);
 }
@@ -59,10 +57,8 @@ EXPORT_SYMBOL_GPL(pci_epf_linkup);
  */
 void pci_epf_unbind(struct pci_epf *epf)
 {
-	if (!epf->driver) {
+	if (!epf->driver)
 		dev_WARN(&epf->dev, "epf device not bound to driver\n");
-		return;
-	}
 
 	epf->driver->ops->unbind(epf);
 	module_put(epf->driver->owner);
@@ -78,10 +74,8 @@ EXPORT_SYMBOL_GPL(pci_epf_unbind);
  */
 int pci_epf_bind(struct pci_epf *epf)
 {
-	if (!epf->driver) {
+	if (!epf->driver)
 		dev_WARN(&epf->dev, "epf device not bound to driver\n");
-		return -EINVAL;
-	}
 
 	if (!try_module_get(epf->driver->owner))
 		return -EAGAIN;
@@ -233,7 +227,7 @@ struct pci_epf *pci_epf_create(const char *name)
 	epf->name = kstrdup(func_name, GFP_KERNEL);
 	if (!epf->name) {
 		ret = -ENOMEM;
-		goto free_func_name;
+		goto free_epf;
 	}
 
 	dev = &epf->dev;
@@ -255,8 +249,6 @@ struct pci_epf *pci_epf_create(const char *name)
 put_dev:
 	put_device(dev);
 	kfree(epf->name);
-
-free_func_name:
 	kfree(func_name);
 
 free_epf:

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
