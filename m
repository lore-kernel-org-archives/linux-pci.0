Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 25 Oct 2017 17:10:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: rework error checking in the reset path
Message-ID: <20171025221046.GA25858@bhelgaas-glaptop.roam.corp.google.com>
References: <1508794608-15310-1-git-send-email-okaya@codeaurora.org>
 <20171025134511.GL21840@bhelgaas-glaptop.roam.corp.google.com>
 <20171025232805.163ccaad@t450s.home>
MIME-Version: 1.0
In-Reply-To: <20171025232805.163ccaad@t450s.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 25, 2017 at 11:28:05PM +0200, Alex Williamson wrote:
> On Wed, 25 Oct 2017 08:45:11 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > [+cc Alex]
> > 
> > On Mon, Oct 23, 2017 at 05:36:48PM -0400, Sinan Kaya wrote:
> > > The return codes from various reset types are not consistent. The code is
> > > assuming that all reset types will return -ENOTTY when things go wrong.
> > > Instead of relying on negative error status, let's bail out if the
> > > operation is successful instead.  
> > 
> > I like this (no surprise since I suggested something similar at
> > http://lkml.kernel.org/r/20171011210057.GU25517@bhelgaas-glaptop.roam.corp.google.com),
> > but I'd like Alex's opinion before merging it.
> > 
> > Previously, we only tried the next reset method if one method failed
> > with -ENOTTY.  With this patch, we'll try the next reset method if one
> > method fails for any reason, not just -ENOTTY.
> 
> Hmm, I thought the return codes were pretty consistent.  -ENOTTY means
> that the reset callback doesn't handle the device, move on.  Many
> ioctls use the same return code to indicate an unknown ioctl.  This
> allows us to differentiate success vs error vs unhandled.  In the code
> below we lose the ability to, for instance, have a device specific
> reset that returns -EINVAL to prevent the PCI core for triggering
> further reset mechanisms which might be broken on the device.  So, I
> don't see that this patch specifically fixes anything, but it does
> remove what seems like useful functionality...  I'd veto it.  Thanks,

I didn't understand the  intention of -EINVAL vs -ENOTTY, so
that might be a reasonable argument.  The knowledge about mechanisms
being broken on a specific device seems like it would belong in
pci_dev_specific_reset() and not really applicable to other methods,
though.

But I'm not sure the current usage makes a lot of sense.  The only
places I found that return an error other than -ENOTTY are
reset_ivb_igd() and pci_pm_reset().  In reset_ivb_igd(), we return
-ENOMEM if an ioremap() fails.  That's not a case of "other reset
mechanisms are broken and we shouldn't try them."

pci_pm_reset() returns -EINVAL if the device is not in D0.  Maybe it
makes sense to not try any other reset methods in that case, but I
really don't know.

If we leave it as-is, maybe a comment like the following would be
useful.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f0d68066c726..2c98f309bc8a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4170,6 +4170,13 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 
 	might_sleep();
 
+	/*
+	 * Reset method return values:
+	 *   0:		    Device was successfully reset
+	 *   -ENOTTY:	    Method doesn't support resetting this device;
+	 *		    try the next method
+	 *   anything else: Reset failed; don't try any other mechanisms
+	 */
 	rc = pci_dev_specific_reset(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
