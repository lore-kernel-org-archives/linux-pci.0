Return-Path: <SRS0=waL8=X2=gmail.com=yhlu.kernel@kernel.org>
Return-Path: <SRS0=waL8=X2=gmail.com=yhlu.kernel@kernel.org>
Sender: Yinghai Lu <yhlu.kernel@gmail.com>
Date: Sat, 10 Dec 2016 17:19:09 -0800
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vaibhav Shankar <vaibhav.shankar@intel.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	venkateswarlu.v.vinjamuri@intel.com
Subject: Re: [PATCH] PCI: pciehp: Optimize PCIe root resume time
Message-ID: <20161211011908.GA10954@linux-siqj.site>
References: <1481323406-12865-1-git-send-email-vaibhav.shankar@intel.com>
 <20161210002744.GB8381@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161210002744.GB8381@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 09, 2016 at 06:27:44PM -0600, Bjorn Helgaas wrote:
> [+cc Yinghai, author of 2f5d8e4ff947]
> 
> On Fri, Dec 09, 2016 at 02:43:26PM -0800, Vaibhav Shankar wrote:
> > On Apollolake platforms, PCIe rootport takes a long time to resume
> > from S3. With 100ms delay before read pci conf, rootport takes
> > ~200ms during resume.
> > 
> > commit 2f5d8e4ff947 ("PCI: pciehp: replace unconditional sleep with
> > config space access check") is the one that added the 100ms delay
> > before reading pci conf.
> > 
> > This patch removes the 100ms delay.By removing the delay, the
> > PCIe root port takes ~16ms during resume. As per PCIe spec, we
> > only require 1000ms delay. This delay is provide by
> > pci_bus_check_dev() function.
> > 
> > Signed-off-by: Vaibhav Shankar <vaibhav.shankar@intel.com>
> > ---
> >  drivers/pci/hotplug/pciehp_hpc.c |    2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> > index 5c24e93..08357e7 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -311,8 +311,6 @@ int pciehp_check_link_status(struct controller *ctrl)
> >  	else
> >  		msleep(1000);
> >  
> > -	/* wait 100ms before read pci conf, and try in 1s */
> > -	msleep(100);
> >  	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
> >  					PCI_DEVFN(0, 0));

that msleep(100) is from that commit:

-       /*
-        * If the port supports Link speeds greater than 5.0 GT/s, we
-        * must wait for 100 ms after Link training completes before
-        * sending configuration request.
-        */
-       if (ctrl->pcie->port->subordinate->max_bus_speed > PCIE_SPEED_5_0GT)
-               msleep(100);

so we should put the checking back.

diff --git a/drivers/pci/hotplug/pciehp_hpc.c
b/drivers/pci/hotplug/pciehp_hpc.c
index 026830a..1b0fc0b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -311,8 +311,15 @@ int pciehp_check_link_status(struct controller *ctrl)
 	else
 		msleep(1000);
 
-	/* wait 100ms before read pci conf, and try in 1s */
-	msleep(100);
+	/*
+	 * If the port supports Link speeds greater than 5.0 GT/s, we
+	 * must wait for 100 ms after Link training completes before
+	 * sending configuration request.
+	 */
+	if (ctrl->pcie->port->subordinate->max_bus_speed > PCIE_SPEED_5_0GT)
+		msleep(100);
+
+	/* try in 1s */
 	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
 					PCI_DEVFN(0, 0));



Thanks

Yinghai
