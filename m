Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 23 Aug 2017 17:24:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V12 4/5] PCI: Handle CRS ("device not ready") returned by
 device after FLR
Message-ID: <20170823222436.GH8498@bhelgaas-glaptop.roam.corp.google.com>
References: <1503464171-6471-1-git-send-email-okaya@codeaurora.org>
 <1503464171-6471-4-git-send-email-okaya@codeaurora.org>
 <20170823213838.GG8498@bhelgaas-glaptop.roam.corp.google.com>
 <0ef4c01d-75bc-17dc-8926-2f9647cfeec8@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <0ef4c01d-75bc-17dc-8926-2f9647cfeec8@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 05:51:19PM -0400, Sinan Kaya wrote:
> On 8/23/2017 5:38 PM, Bjorn Helgaas wrote:
> > If we increase the timeout, is there still value in adding the
> > pci_bus_wait_crs() stuff?  I'm not sure there is.
> 
> I agree increasing the timeout is more than enough for FLR case. 

If that's the case, I think there's no value in adding additional
complexity to the path.  If we increase the timeout, we might pretty
it up a little along the lines of the patch below.

> However, I was considering the wait and pending functions as a utility
> that I can reuse towards fixing CRS in other conditions like secondary
> bus reset and potentially PM.
> 
> I'm planning to have a CRS session in the Linux Plumbers Conference 
> to talk about CRS use cases. 

Great idea.  I'm kind of confused on its value in general myself.  And
there's now a new mechanism (Function Readiness Status) that I don't
think we have any support for at all.

> I was going to follow up this series with secondary bus reset next once
> this goes in. 

I think I'm OK with everything except the pci_flr_wait() change.  The
rest of it makes sense (although I don't think there are any users
outside probe.c, so maybe should be static for now).

> I'm unable to test PM. I can't promise how I fix/test it.


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc3456dc1..b04c99e60b77 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3811,27 +3811,50 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
-/*
- * We should only need to wait 100ms after FLR, but some devices take longer.
- * Wait for up to 1000ms for config space to return something other than -1.
- * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
- * dword because VFs don't implement the 1st dword.
- */
 static void pci_flr_wait(struct pci_dev *dev)
 {
-	int i = 0;
+	int delay = 1, timeout = 60000;
 	u32 id;
 
-	do {
-		msleep(100);
+	/*
+	 * Per PCIe r3.1, sec 6.6.2, a device must complete an FLR within
+	 * 100ms, but may silently discard requests while the FLR is in
+	 * progress.  Wait 100ms before trying to access the device.
+	 */
+	msleep(100);
+
+	/*
+	 * After 100ms, the device should not silently discard config
+	 * requests, but it may still indicate that it needs more time by
+	 * responding to them with CRS completions.  The Root Port will
+	 * generally synthesize ~0 data to complete the read (except when
+	 * CRS SV is enabled and the read was for the Vendor ID; in that
+	 * case it synthesizes 0x0001 data).
+	 *
+	 * Wait for the device to return a non-CRS completion.  Read the
+	 * Command register instead of Vendor ID so we don't have to
+	 * contend with the CRS SV value.
+	 */
+	pci_read_config_dword(dev, PCI_COMMAND, &id);
+	while (id == ~0) {
+		if (delay > timeout) {
+			dev_warn(&dev->dev, "not ready %dms after FLR; giving up\n",
+				 delay - 1);
+			return;
+		}
+
+		if (delay > 1000)
+			dev_info(&dev->dev, "not ready %dms after FLR; waiting\n",
+				 delay - 1);
+
+		msleep(delay);
+		delay *= 2;
+
 		pci_read_config_dword(dev, PCI_COMMAND, &id);
-	} while (i++ < 10 && id == ~0);
+	}
 
-	if (id == ~0)
-		dev_warn(&dev->dev, "Failed to return from FLR\n");
-	else if (i > 1)
-		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
-			 (i - 1) * 100);
+	if (delay > 1000)
+		dev_info(&dev->dev, "ready %dms after FLR\n", delay - 1);
 }
 
 /**

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
