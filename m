Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F1134AC;
	Fri,  5 Apr 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339299; cv=none; b=uyMhdBa6/iPvI4orH4W40vxrlf3L9ip1ekPwS7aKRI0huhHQIykBjRiPNGSYnp2C/0ffFg5e1UDifY2kVuzzEiAIhG05NHBo9RHhb+3un4bjQkNJjAjEXmD/j/SvZ/glvP4Tq6hXrGoPqbA4L7PAphCxFVhm0yfNKg3dLDC2iww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339299; c=relaxed/simple;
	bh=WvRsBVBjYEza67dv61GNHhs7Cd+qc3xljT52Ok2UXD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZLPoOvoeunHujmHfXIKJYjbHYDdFHO86ymTeueChbIX/eg6gjqjbwKR04H6nyLe5XMptBWrT3km2SM+UHmK2Nex8v1OgecD01rx/pvlMhdFjVKQdDCQtgQ4jcgKq/csRckLoRYDndfiDNmEtQlrWPHwZ4P3BW82gI02HZnitG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1D43B2800BB90;
	Fri,  5 Apr 2024 19:48:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 082829926D8; Fri,  5 Apr 2024 19:48:08 +0200 (CEST)
Date: Fri, 5 Apr 2024 19:48:08 +0200
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
Message-ID: <ZhA5WAYyMQJsAey8@wunner.de>
References: <CAEhC_B=ksywxCG_+aQqXUrGEgKq+4mqnSV8EBHOKbC3-Obj9+Q@mail.gmail.com>
 <Zg_MOG1OufptoRph@wunner.de>
 <cd9edf12-5241-4366-b376-d5ee8f919903@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9edf12-5241-4366-b376-d5ee8f919903@gmail.com>

On Fri, Apr 05, 2024 at 03:31:34PM +0200, Heiner Kallweit wrote:
> On 05.04.2024 12:02, Lukas Wunner wrote:
> > On Fri, Apr 05, 2024 at 11:14:01AM +0200, Roman Lozko wrote:
> > > Hi, I'm using HP G4 Thunderbolt docking station, and recently (?)
> > > kernel started to "partially" deadlock after disconnecting the dock
> > > station. This results in inability to turn network interfaces on or
> > > off, system can't reboot, `sudo` does not work (guess because it uses
> > > DNS).
> > 
> > unregister_netdev() acquires rtnl_lock(), indirectly invokes
> > netdev_trig_deactivate() upon unregistering some LED, thereby
> > calling unregister_netdevice_notifier(), which tries to
> > acquire rtnl_lock() again.
> > 
> > From a quick look at the source files involved, this doesn't look
> > like something new, though I note LED support for igc was added
> > only recently with ea578703b03d ("igc: Add support for LEDs on
> > i225/i226"), which went into v6.9-rc1.
> 
> It's unfortunate that the device-managed LED is bound to the netdev device.
> Wouldn't binding it to the parent (&pdev->dev) solve the issue?

I'm guessing igc commit ea578703b03d copy-pasted from r8169 commit
be51ed104ba9 ("r8169: add LED support for RTL8125/RTL8126") because
that driver has exactly the same problem. :)

Roman, does the below patch fix the issue?

Note that just changing the devm_led_classdev_register() call isn't
sufficient:  I'm changing the devm_kcalloc() in igc_led_setup() as well
to avoid a use-after-free (memory would already get freed on netdev
unregister but led a little later on pdev unbind).

-- >8 --

diff --git a/drivers/net/ethernet/intel/igc/igc_leds.c b/drivers/net/ethernet/intel/igc/igc_leds.c
index bf240c5..0b78c30 100644
--- a/drivers/net/ethernet/intel/igc/igc_leds.c
+++ b/drivers/net/ethernet/intel/igc/igc_leds.c
@@ -257,13 +257,13 @@ static void igc_setup_ldev(struct igc_led_classdev *ldev,
 	led_cdev->hw_control_get = igc_led_hw_control_get;
 	led_cdev->hw_control_get_device = igc_led_hw_control_get_device;
 
-	devm_led_classdev_register(&netdev->dev, led_cdev);
+	devm_led_classdev_register(&adapter->pdev->dev, led_cdev);
 }
 
 int igc_led_setup(struct igc_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct device *dev = &netdev->dev;
+	struct device *dev = &adapter->pdev->dev;
 	struct igc_led_classdev *leds;
 	int i;
 
