Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from violet.fr.zoreil.com ([92.243.8.30]:49835 "EHLO
	violet.fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030227Ab2CBPcV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Mar 2012 10:32:21 -0500
Date: Fri, 2 Mar 2012 15:44:27 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI / PM: Disable wakeup during shutdown for devices not enabled to wake up
Message-ID: <20120302144427.GD31240@electric-eye.fr.zoreil.com>
References: <201202070050.35931.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201202070050.35931.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rafael J. Wysocki <rjw@sisk.pl> :
[...]
> If a PCI device is enabled to generate wakeup signals (PME) when put
> into a low-power state by runtime PM, it will be still enabled to
> generate those signals after the system shutdown, unless its driver's
> .shutdown() callback takes care of the wakeup signals generation
> setting.  Moreover, there are devices that are not enabled to wake
> up the system and that are configured by runtime PM to generate
> wakeup signals so that (runtime) remote wakeup works with them.
> Those devices should be reconfigured during system shutdown so that
> they don't generate wakeup signals, but at least some drivers don't
> do that.  However, that very well may be done by the PCI core so
> that drivers don't have to worry about it.  For this reason, modify
> pci_device_shutdown() to disable the generation of wakeup events for
> devices not supposed to wake up the system.

On a tangent side, if register writes are ignored by the PCI device
after its .runtime_suspend() handler has been called, whose
responsibility is it to bring back the device in a state from where
the .shutdown() callback can operate ?

The r8169 driver exhibits this problem. Its .runtime_xyz() callbacks
are called on link activity. Thus, after a link loss - or no link at
all - .runtime_suspend() and an ineffective .shutdown(), the device is
brought back up as soon as the link recovers.

The device driver can monitor .runtime_{suspend / resume} activity
and take appropriate action in .shutdown(). Sameer Nanda has sent
such a patch (see below). I am not sure this is the adequate fix:
1. the driver ought essentially to perform the hardware part of a
   .runtime_resume() on its own behalf. Mildly engaging.
2. by the same line as above, could it make more sense to call
   pm_runtime_resume() in driver/base/core.c::device_shutdown ?

Thanks.

From: Sameer Nanda <snanda@chromium.org>
Date: Tue, 14 Feb 2012 10:31:15 -0800
Subject: [PATCH] r8169: transition to D0 state at shutdown

With runtime PM, if the ethernet cable is disconnected, the device is
transitioned to D3 state to conserve energy. If the system is shutdown
in this state, any register accesses in rtl_shutdown are dropped on
the floor.

This patch transitions the device back to D0 state in rtl_shutdown if
the device was runtime PM suspended. In addition, since runtiome PM
also mucks around with WOL options, the saved WOL options are also
restored in rtl_shutdown.

Signed-off-by: Sameer Nanda <snanda@chromium.org>
---
 drivers/net/ethernet/realtek/r8169.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 1adf177..33c2afb 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -691,6 +691,7 @@ struct rtl8169_private {
 	u16 intr_event;
 	u16 napi_event;
 	u16 intr_mask;
+	bool runtime_suspended;
 
 	struct mdio_ops {
 		void (*write)(void __iomem *, int, int);
@@ -4315,6 +4316,7 @@ static int rtl8169_open(struct net_device *dev)
 	rtl_hw_start(dev);
 
 	tp->saved_wolopts = 0;
+	tp->runtime_suspended = false;
 	pm_runtime_put_noidle(&pdev->dev);
 
 	rtl8169_check_link_status(dev, tp, ioaddr);
@@ -6113,6 +6115,7 @@ static int rtl8169_runtime_suspend(struct device *device)
 	spin_lock_irq(&tp->lock);
 	tp->saved_wolopts = __rtl8169_get_wol(tp);
 	__rtl8169_set_wol(tp, WAKE_ANY);
+	tp->runtime_suspended = true;
 	spin_unlock_irq(&tp->lock);
 
 	rtl8169_net_suspend(dev);
@@ -6132,6 +6135,7 @@ static int rtl8169_runtime_resume(struct device *device)
 	spin_lock_irq(&tp->lock);
 	__rtl8169_set_wol(tp, tp->saved_wolopts);
 	tp->saved_wolopts = 0;
+	tp->runtime_suspended = false;
 	spin_unlock_irq(&tp->lock);
 
 	rtl8169_init_phy(dev, tp);
@@ -6195,6 +6199,10 @@ static void rtl_shutdown(struct pci_dev *pdev)
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct rtl8169_private *tp = netdev_priv(dev);
 
+	/* Get the device back to D0 state if it was runtime suspended. */
+	if (tp->runtime_suspended)
+		pci_set_power_state(pdev, PCI_D0);
+
 	rtl8169_net_suspend(dev);
 
 	/* Restore original MAC address */
@@ -6202,6 +6210,10 @@ static void rtl_shutdown(struct pci_dev *pdev)
 
 	spin_lock_irq(&tp->lock);
 
+	/* Restore WOL flags if they were messed around with. */
+	if (tp->saved_wolopts)
+		__rtl8169_set_wol(tp, tp->saved_wolopts);
+
 	rtl8169_hw_reset(tp);
 
 	spin_unlock_irq(&tp->lock);
-- 
1.7.7.6

