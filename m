Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751926AbeAIXjW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jan 2018 18:39:22 -0500
Date: Tue, 9 Jan 2018 17:39:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tal Gilboa <talgi@mellanox.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH next 1/3] pci: Report PCI device link status
Message-ID: <20180109233913.GA130705@bhelgaas-glaptop.roam.corp.google.com>
References: <1514993062-7328-1-git-send-email-talgi@mellanox.com>
 <1514993062-7328-2-git-send-email-talgi@mellanox.com>
 <20180103235728.GA189897@bhelgaas-glaptop.roam.corp.google.com>
 <45743fd4-d486-9696-012d-258ff6d687f7@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45743fd4-d486-9696-012d-258ff6d687f7@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 09, 2018 at 10:02:07PM +0200, Tal Gilboa wrote:
> On 1/4/2018 1:57 AM, Bjorn Helgaas wrote:

> >>+int pcie_get_link_caps(struct pci_dev *dev, enum pci_bus_speed *speed,
> >>+		       enum pcie_link_width *width)
> >>+{
> >>+	u32 lnkcap1, lnkcap2;
> >>+	int err1, err2;
> >>+
> >>+	*speed = PCI_SPEED_UNKNOWN;
> >>+	*width = PCIE_LNK_WIDTH_UNKNOWN;
> >>+
> >>+	err1 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP,
> >>+					  &lnkcap1);
> >>+	err2 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2,
> >>+					  &lnkcap2);
> >>+
> >>+	if (err1 && err2)
> >>+		return err1;
> >>+
> >>+	if (!err2 && lnkcap2) { /* PCIe r3.0-compliant */
> >>+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
> >>+			*speed = PCIE_SPEED_8_0GT;
> >>+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
> >>+			*speed = PCIE_SPEED_5_0GT;
> >>+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
> >>+			*speed = PCIE_SPEED_2_5GT;
> >>+	}
> >>+	if (!err1 && lnkcap1) {
> >>+		*width = (lnkcap1 & PCI_EXP_LNKCAP_MLW) >>
> >>+				PCI_EXP_LNKCAP_MLW_SHIFT;
> >>+		if (*speed == PCI_SPEED_UNKNOWN) { /* pre-r3.0 */
> >>+			if (lnkcap1 & PCI_EXP_LNKCAP_SLS_8_0GB)
> >>+				*speed = PCIE_SPEED_8_0GT;
> >>+			else if (lnkcap1 & PCI_EXP_LNKCAP_SLS_5_0GB)
> >>+				*speed = PCIE_SPEED_5_0GT;
> >>+			else if (lnkcap1 & PCI_EXP_LNKCAP_SLS_2_5GB)
> >>+				*speed = PCIE_SPEED_2_5GT;
> >>+		}
> >>+	}
> >
> >There are several copies of this code:
> >
> >   drm_pcie_get_speed_cap_mask()
> >   cxgb4_get_pcie_dev_link_caps()
> >   mlx4_get_pcie_dev_link_caps()
> >   qla24xx_pci_info_str()
> >   pcie_speeds() (in drivers/infiniband/hw/hfi1/pcie.c)
> >   max_link_speed_show()
> >   max_link_width_show()
> >
> >so it's great to clean this up.  The version in max_link_speed_show()
> >is simpler (it doesn't need PCI_EXP_LNKCAP2) and looks sufficient to
> >me.  I *think* something like this should be enough:
> >
> >   u32 lnkcap;
> >
> >   pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> >
> >   if (!lnkcap) {
> >     *speed = PCI_SPEED_UNKNOWN;
> >     *width = PCIE_LNK_WIDTH_UNKNOWN;
> >     return;
> >   }
> >
> >   switch (lnkcap & PCI_EXP_LNKCAP_SLS) {
> >   case PCI_EXP_LNKCAP_SLS_2_5GB:
> >     *speed = PCIE_SPEED_2_5GT;
> >     break;
> >   case PCI_EXP_LNKCAP_SLS_5_0GB:
> >     *speed = PCIE_SPEED_5_0GT;
> >     break;
> >   case PCI_EXP_LNKCAP_SLS_8_0GB:
> >     *speed = PCIE_SPEED_8_0GT;
> >     break;
> >   default:
> >     *speed = PCI_SPEED_UNKNOWN;
> >   }
> >
> >   *width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
> >
> >Prior to PCIe r3.0, only PCI_EXP_LNKCAP_SLS_2_5GB and
> >PCI_EXP_LNKCAP_SLS_5_0GB were defined.
> >
> >PCIe r3.0 renamed the Link Capabilities "Supported Link Speeds" to
> >"Max Link Speed", and made the bits refer to the new Supported Link
> >Speeds Vector in Link Capabilities 2.  But the mapping is such that
> >PCI_EXP_LNKCAP_SLS_2_5GB refers to SLSV bit 0 (still 2.5GT/s),
> >PCI_EXP_LNKCAP_SLS_5_0GB refers to SLSV bit 1 (still 5.0GT/s), and
> >PCI_EXP_LNKCAP_SLS_8_0GB refers to SLSV bit 2 (now 8.0GT/s).
> >
> >So I don't think there's really anything new to be learned by reading
> >Link Capabilities 2.  Or am I missing something?
> 
> From the commit introducing these caps (cdcac9cd7 by Dave Airlie, CCed):
> "We need these for detecting the max link speed for drm drivers."
> Since this should support any PCIe device, I think we need to cover
> all options.

Yep, you're right.  I was assuming we only wanted the max speed, but
the DRM code seems to want the entire vector of supported speeds, so
we should preserve that.

And the implementation note in PCIe r3.1, sec 7.8.18 says why we
should look at Link Capabilities 2: Link Capabilities tells us only
the Max Link Speed, not the vector of all supported speeds.  For
devices prior to PCIe r3.0, it actually tells us both the max and the
vector because the only choices were "2.5 GT/s" or "5.0 GT/s and 2.5
GT/s".

Starting with PCIe r3.0, the Supported Link Speeds Vector in Link
Capabilities 2 tells us the vector and the Max Link Speed tells us the
highest supported speed by referencing the vector.  Theoretically this
would allow a device to support some but not all of the speeds lower
than its maximum.

Up to at least PCIe r4.0, there's no difference.  4.0 adds 16.0 GT/s,
but all devices still have to support all slower speeds (4.0-r0.9, sec
8.2.1).  But we should follow the suggestion in the implementation
note because that might not always be the case.  And we might as well
add the 16.0 GT/s bit since I think the official r4.0 spec is out now.

> >>+ * pcie_print_link_status - Reports the PCI device's link speed and width.
> >>+ * @dev: PCI device to query
> >>+ *
> >>+ * This function will check the PCI device current speed and width are equal
> >>+ * to the maximum PCI device capabilities. Will issue a warning in cases
> >>+ * there's a mismatch between current status and maximum capabilities.
> >
> >I need to think about this part.  As far as I can tell, the only
> >reason to look up the link speed and width is to warn that the device
> >might not be able to perform to its maximum capability.  Everything
> >should still *work*, but possibly not as fast as expected.
> >
> >I wonder if there's a way to do this automatically in the PCI core,
> >without any driver interaction at all.  It would have to be a little
> >less noisy than what you have here, e.g., we might be able to print
> >one line to indicate sub-optimal situations.
> >
> >The idea of pcie_get_minimum_link() seems a little suspect to me.
> >Isn't it possible that an upstream link could be narrower but faster
> >than the one directly connected to the endpoint?  In that case, the
> >device might be able to work at full performance, and we wouldn't want
> >to warn about the narrow upstream link.
> >
> >So I'm not sure what to do here.  Maybe we can track the max available
> >bandwidth (the combination of link width and speed) at each point in
> >the hierarchy, and only warn if the device is capable of more than is
> >available.
> >
> >But if you split this into two patches and consolidate the
> >pcie_get_link_caps() stuff, that would be a good start.
> 
> Good point, I guess this could happen, but probably not common. I'll
> change this to check total BW instead of speed and width separately
> 
> 
> >>--- a/include/uapi/linux/pci_regs.h
> >>+++ b/include/uapi/linux/pci_regs.h
> >>@@ -521,6 +521,7 @@
> >>  #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
> >>  #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
> >>  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
> >>+#define  PCI_EXP_LNKCAP_MLW_SHIFT 4	   /* Start of MLW mask in link capabilities */
> >
> >I wouldn't add this.  We have PCI_EXP_LNKCAP_MLW, which is enough for
> >grep/cscope to find the related code.  And hopefully you'll reduce the
> >number of places that use PCI_EXP_LNKCAP_MLW significantly.
> 
> I agree it is enough for that purpose, I just don't like hard-coded
> values. When I see "linkcap & PCI_EXP_LNKCAP_MLW) >> 4)" it takes me
> much longer to understand the meaning. Please reconsider.

There *are* a few shift values defined in
include/uapi/linux/pci_regs.h, but I think they're in the minority,
even for multi-bit fields, which is the main place you'd use them.
For me, it's a tradeoff because I think the shift definitions clutter
the header file.  Without them, the #defines are a pretty obvious
mapping of the register fields, but I think it's harder to see the
fields if the shift values are mixed in.

> >>  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
> >>  #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
> >>  #define  PCI_EXP_LNKCAP_L1EL	0x00038000 /* L1 Exit Latency */
> >>-- 
> >>1.8.3.1
> >>
