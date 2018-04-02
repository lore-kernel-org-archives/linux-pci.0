Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756630AbeDBT6X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Apr 2018 15:58:23 -0400
Date: Mon, 2 Apr 2018 14:58:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link
 speed and whether it's limited
Message-ID: <20180402195820.GL9322@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244391852.135666.14903825998610307052.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <02874ECE860811409154E81DA85FBB5882D49870@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <02874ECE860811409154E81DA85FBB5882D49870@ORSMSX115.amr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 02, 2018 at 04:25:17PM +0000, Keller, Jacob E wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Friday, March 30, 2018 2:05 PM
> > To: Tal Gilboa <talgi@mellanox.com>
> > Cc: Tariq Toukan <tariqt@mellanox.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Ariel Elior <ariel.elior@cavium.com>; Ganesh
> > Goudar <ganeshgr@chelsio.com>; Kirsher, Jeffrey T
> > <jeffrey.t.kirsher@intel.com>; everest-linux-l2@cavium.com; intel-wired-
> > lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-pci@vger.kernel.org
> > Subject: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link speed and
> > whether it's limited
> > 
> > From: Tal Gilboa <talgi@mellanox.com>
> > 
> > Add pcie_print_link_status().  This logs the current settings of the link
> > (speed, width, and total available bandwidth).
> > 
> > If the device is capable of more bandwidth but is limited by a slower
> > upstream link, we include information about the link that limits the
> > device's performance.
> > 
> > The user may be able to move the device to a different slot for better
> > performance.
> > 
> > This provides a unified method for all PCI devices to report status and
> > issues, instead of each device reporting in a different way, using
> > different code.
> > 
> > Signed-off-by: Tal Gilboa <talgi@mellanox.com>
> > [bhelgaas: changelog, reword log messages, print device capabilities when
> > not limited]
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pci.c   |   29 +++++++++++++++++++++++++++++
> >  include/linux/pci.h |    1 +
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e00d56b12747..cec7aed09f6b 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5283,6 +5283,35 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev,
> > enum pci_bus_speed *speed,
> >  	return *width * PCIE_SPEED2MBS_ENC(*speed);
> >  }
> > 
> > +/**
> > + * pcie_print_link_status - Report the PCI device's link speed and width
> > + * @dev: PCI device to query
> > + *
> > + * Report the available bandwidth at the device.  If this is less than the
> > + * device is capable of, report the device's maximum possible bandwidth and
> > + * the upstream link that limits its performance to less than that.
> > + */
> > +void pcie_print_link_status(struct pci_dev *dev)
> > +{
> > +	enum pcie_link_width width, width_cap;
> > +	enum pci_bus_speed speed, speed_cap;
> > +	struct pci_dev *limiting_dev = NULL;
> > +	u32 bw_avail, bw_cap;
> > +
> > +	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
> > +	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed,
> > &width);
> > +
> > +	if (bw_avail >= bw_cap)
> > +		pci_info(dev, "%d Mb/s available bandwidth (%s x%d link)\n",
> > +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
> > +	else
> > +		pci_info(dev, "%d Mb/s available bandwidth, limited by %s x%d
> > link at %s (capable of %d Mb/s with %s x%d link)\n",
> > +			 bw_avail, PCIE_SPEED2STR(speed), width,
> > +			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
> > +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
> > +}
> 
> Personally, I would make thic last one a pci_warn() to indicate it at a
> higher log level, but I'm  ok with the wording, and if consensus is that
> this should be at info, I'm ok with that.

Tal's original patch did have a pci_warn() here, and we went back and
forth a bit.  They get bug reports when a device doesn't perform as
expected, which argues for pci_warn().  But they also got feedback
saying warnings are a bit too much, which argues for pci_info() [1]

I don't have a really strong opinion either way.  I have a slight
preference for info because the user may not be able to do anything
about it (there may not be a faster slot available), and I think
distros are usually configured so a warning interrupts the smooth
graphical boot.

It looks like mlx4, fm10k, and ixgbe currently use warnings, while
bnx2x, bnxt_en, and cxgb4 use info.  It's a tie so far :)

[1] https://lkml.kernel.org/r/e47f3628-b56c-4d0a-f18b-5ffaf261ccc0@mellanox.com

Here's a proposal for printing the bandwidth as "x.xxx Gb/s":

commit ad370f38c1b5e9b8bb941eaed84ebb676c4bdaa4
Author: Tal Gilboa <talgi@mellanox.com>
Date:   Fri Mar 30 08:56:47 2018 -0500

    PCI: Add pcie_print_link_status() to log link speed and whether it's limited
    
    Add pcie_print_link_status().  This logs the current settings of the link
    (speed, width, and total available bandwidth).
    
    If the device is capable of more bandwidth but is limited by a slower
    upstream link, we include information about the link that limits the
    device's performance.
    
    The user may be able to move the device to a different slot for better
    performance.
    
    This provides a unified method for all PCI devices to report status and
    issues, instead of each device reporting in a different way, using
    different code.
    
    Signed-off-by: Tal Gilboa <talgi@mellanox.com>
    [bhelgaas: changelog, reword log messages, print device capabilities when
    not limited, print bandwidth in Gb/s]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c6e3c0524699..ab2346041fa4 100644
--- a/drivers/pci/pci.c
++ b/drivers/pci/pci.c
@@ -5287,6 +5287,38 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 	return *width * PCIE_SPEED2MBS_ENC(*speed);
 }
 
+/**
+ * pcie_print_link_status - Report the PCI device's link speed and width
+ * @dev: PCI device to query
+ *
+ * Report the available bandwidth at the device.  If this is less than the
+ * device is capable of, report the device's maximum possible bandwidth and
+ * the upstream link that limits its performance to less than that.
+ */
+void pcie_print_link_status(struct pci_dev *dev)
+{
+	enum pcie_link_width width, width_cap;
+	enum pci_bus_speed speed, speed_cap;
+	struct pci_dev *limiting_dev = NULL;
+	u32 bw_avail, bw_cap;
+
+	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
+	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
+
+	if (bw_avail >= bw_cap)
+		pci_info(dev, "%u.%03u Gb/s available bandwidth (%s x%d link)\n",
+			 bw_cap / 1000, bw_cap % 1000,
+			 PCIE_SPEED2STR(speed_cap), width_cap);
+	else
+		pci_info(dev, "%u.%03u Gb/s available bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
+			 bw_avail / 1000, bw_avail % 1000,
+			 PCIE_SPEED2STR(speed), width,
+			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
+			 bw_cap / 1000, bw_cap % 1000,
+			 PCIE_SPEED2STR(speed_cap), width_cap);
+}
+EXPORT_SYMBOL(pcie_print_link_status);
+
 /**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f2bf2b7a66c7..38f7957121ef 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1086,6 +1086,7 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
+void pcie_print_link_status(struct pci_dev *dev);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
