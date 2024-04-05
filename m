Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75E172BAB;
	Fri,  5 Apr 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344571; cv=none; b=sRpkGjcKiAUBqI6aAWxK/2inUWaWypO3FNN3tsC7xTwwpSIZuSPD0bD4mpdnR/ROIA9zelCtDhfdxNBZ8qahk3bkzqCAcaOQGj7W7IlQ3+hD31dCpbs85wVIErrjx79n4QohGNAQRyIBrq6a2D/KUkm0vmyX1WFM4HLOzM5N81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344571; c=relaxed/simple;
	bh=9nV6IwZvh+7VJGSjmzla8vNvvjjgdzbj8OPcldmJZk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HySAcar1QvLi9g3TJFVX9ktbM2QgOstgPchb2RfaQ8zY1p6sKu2mR0rwm9D1ixjj+MQ0xVBn5DOnrIFHE6JGZfWV+yMXdUdbbMWYrhbd3R0fsuthC+W6bb+FxtIpQw3kAgjBoHa6dQ+Zs4KOYHaTMOugS5zVsUkMi/4TqYCCIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 50AA22800BB90;
	Fri,  5 Apr 2024 21:16:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 278851192D2; Fri,  5 Apr 2024 21:16:06 +0200 (CEST)
Date: Fri, 5 Apr 2024 21:16:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Roman Lozko <lozko.roma@gmail.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: Deadlock in pciehp on dock disconnect
Message-ID: <ZhBN9p1yOyciXkzw@wunner.de>
References: <CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com>
 <Zg_MOG1OufptoRph@wunner.de>
 <cd9edf12-5241-4366-b376-d5ee8f919903@gmail.com>
 <ZhA5WAYyMQJsAey8@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhA5WAYyMQJsAey8@wunner.de>

On Fri, Apr 05, 2024 at 07:48:08PM +0200, Lukas Wunner wrote:
> Roman, does the below patch fix the issue?

Actually the patch in my previous e-mail was crap as the unregistering
of the LEDs happened after unbind of the pdev, i.e. after
igc_release_hw_control() and pci_disable_device().

The driver otherwise doesn't seem to be using devm_*() and with
devm_*() it's always all or nothing.  A mix of devm_*() and manual
teardown is prone to ordering issues.

Here's another attempt:

-- >8 --

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 90316dc58630..f9ffe9df9a96 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -298,6 +298,7 @@ struct igc_adapter {
 
 	/* LEDs */
 	struct mutex led_mutex;
+	struct igc_led_classdev *leds;
 };
 
 void igc_up(struct igc_adapter *adapter);
@@ -723,6 +724,7 @@ void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
 void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
 
 int igc_led_setup(struct igc_adapter *adapter);
+void igc_led_teardown(struct igc_adapter *adapter);
 
 #define igc_rx_pg_size(_ring) (PAGE_SIZE << igc_rx_pg_order(_ring))
 
diff --git a/drivers/net/ethernet/intel/igc/igc_leds.c b/drivers/net/ethernet/intel/igc/igc_leds.c
index bf240c5daf86..4c2806c0878a 100644
--- a/drivers/net/ethernet/intel/igc/igc_leds.c
+++ b/drivers/net/ethernet/intel/igc/igc_leds.c
@@ -236,8 +236,8 @@ static void igc_led_get_name(struct igc_adapter *adapter, int index, char *buf,
 		 pci_dev_id(adapter->pdev), index);
 }
 
-static void igc_setup_ldev(struct igc_led_classdev *ldev,
-			   struct net_device *netdev, int index)
+static int igc_setup_ldev(struct igc_led_classdev *ldev,
+			  struct net_device *netdev, int index)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct led_classdev *led_cdev = &ldev->led;
@@ -257,15 +257,15 @@ static void igc_setup_ldev(struct igc_led_classdev *ldev,
 	led_cdev->hw_control_get = igc_led_hw_control_get;
 	led_cdev->hw_control_get_device = igc_led_hw_control_get_device;
 
-	devm_led_classdev_register(&netdev->dev, led_cdev);
+	return led_classdev_register(&netdev->dev, led_cdev);
 }
 
 int igc_led_setup(struct igc_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct device *dev = &netdev->dev;
+	struct device *dev = &adapter->pdev->dev;
 	struct igc_led_classdev *leds;
-	int i;
+	int i, ret;
 
 	mutex_init(&adapter->led_mutex);
 
@@ -273,8 +273,27 @@ int igc_led_setup(struct igc_adapter *adapter)
 	if (!leds)
 		return -ENOMEM;
 
-	for (i = 0; i < IGC_NUM_LEDS; i++)
-		igc_setup_ldev(leds + i, netdev, i);
+	for (i = 0; i < IGC_NUM_LEDS; i++) {
+		ret = igc_setup_ldev(leds + i, netdev, i);
+		if (ret)
+			goto err;
+	}
+
+	adapter->leds = leds;
 
 	return 0;
+
+err:
+	for (i--; i >= 0; i--)
+		led_classdev_unregister(&((leds + i)->led));
+	return ret;
+}
+
+void igc_led_teardown(struct igc_adapter *adapter)
+{
+	struct igc_led_classdev *leds = adapter->leds;
+	int i;
+
+	for (i = 0; i < IGC_NUM_LEDS; i++)
+		led_classdev_unregister(&((leds + i)->led));
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2e1cfbd82f4f..cd164442ab35 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7025,6 +7025,9 @@ static void igc_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->watchdog_task);
 	hrtimer_cancel(&adapter->hrtimer);
 
+	if (IS_ENABLED(CONFIG_IGC_LEDS))
+		igc_led_teardown(adapter);
+
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
 	 */
