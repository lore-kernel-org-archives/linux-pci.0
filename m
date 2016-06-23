Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35779 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcFWBfb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2016 21:35:31 -0400
Received: by mail-pa0-f50.google.com with SMTP id hl6so21948112pac.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jun 2016 18:35:31 -0700 (PDT)
Date: Wed, 22 Jun 2016 18:35:27 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Wenrui Li <wenrui.li@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
Message-ID: <20160623013527.GA46876@google.com>
References: <1466041835-1695-1-git-send-email-shawn.lin@rock-chips.com>
 <20160623002919.GA21157@google.com>
 <dcdc3402-22d9-473a-d9ae-b9bd994c24a6@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <dcdc3402-22d9-473a-d9ae-b9bd994c24a6@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thu, Jun 23, 2016 at 09:09:46AM +0800, Shawn Lin wrote:
> 在 2016/6/23 8:29, Brian Norris 写道:
> >On Thu, Jun 16, 2016 at 09:50:35AM +0800, Shawn Lin wrote:

[...]

> >>+	/* 500ms timeout value should be enough for gen1/2 taining */
> >>+	timeout = jiffies + msecs_to_jiffies(500);
> >>+
> >>+	err = -ETIMEDOUT;
> >>+	while (time_before(jiffies, timeout)) {
> >>+		status = pcie_read(port, PCIE_CLIENT_BASIC_STATUS1);
> >>+		if (((status >> PCIE_CLIENT_LINK_STATUS_SHIFT) &
> >>+		      PCIE_CLIENT_LINK_STATUS_MASK) ==
> >>+		      PCIE_CLIENT_LINK_STATUS_UP) {
> >>+			dev_dbg(port->dev, "pcie link training gen1 pass!\n");
> >>+			err = 0;
> >>+			break;
> >>+		}
> >>+		msleep(20);
> >>+	}
> >
> >Technically, the above timeout loop is not quite correct. Possible error
> >case: we can fail with a timeout after 500 ms if the training completes
> >between the 480-500 ms time window. This can happen because you're
> >doing:
> >
> >(1) read register: if complete, then terminate successfully
> >(2) delay
> >(3) check for timeout: if time is up, return error
> >
> >You actually need:
> >
> >(1) read register: if complete, then terminate successfully
> >(2) delay
> >(3) check for timeout: if time is up, repeat (1), and then report error
> >
> >You can examine the logic for readx_poll_timeout() in
> >include/linux/iopoll.h to see an example of a proper timeout loop. You
> >could even try to use one of the helpers there, except that your
> >pcie_read() takes 2 args.
> 
> I see, thanks.
> 
> >
> >>+	if (err) {
> >>+		dev_err(port->dev, "pcie link training gen1 timeout!\n");
> >>+		return err;
> >>+	}
> >>+
> >>+	/*
> >>+	 * Enable retrain for gen2. This should be configured only after
> >>+	 * gen1 finished.
> >>+	 */
> >>+	status = pcie_read(port,
> >>+			   PCIR_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
> >>+	status |= PCIE_CORE_LCSR_RETAIN_LINK;
> >>+	pcie_write(port, status,
> >>+		   PCIR_RC_CONFIG_LCS + PCIE_RC_CONFIG_BASE);
> >
> >I'm not really an expert on this, but how are you actually "retraining
> >for gen2"? Is that just the behavior of the core, that it retries at the
> >higher rate on the 2nd training attempt? I'm just confused, since you
> >set PCIE_CLIENT_GEN_SEL_2 above, so you've already allowed either gen1
> >or gen2 negotiation AFAICT, and so seemingly you might already have
> >negotiated at gen2.
> 
> 
> Not really. I allow the core to enable gen2, but it needs a extra
> setting of retrain after finishing gen1. It's not so strange as it
> depends on the vendor's design. So I have to say it fits the
> designer's expectation.

OK.

> >>+	err = -ETIMEDOUT;
> >>+
> >>+	while (time_before(jiffies, timeout)) {
> >
> >You never reset 'timeout' when starting this loop. So you only have a
> >cumulative 500 ms to do both the gen1 and gen2 loops. Is that
> >intentional? (I feel like this comment was made on an earlier revision
> >of this driver, though I haven't read everything thoroughly.)
> 
> yes, I don't have any docs to let me know how long should I wait for
> gen1/2 to be finished. Maybe someday it will be augmented to a larger
> value if finding a device actually need a longer time. But the only
> thing I can say is that it's from my test for many pcie devices
> currently.
> 
> 
> Do you agree?

I'm not suggesting increasing the timeout, exactly; I'm suggesting that
you should set some minimum timeout for each training loop, instead of
reusing the same deadline. i.e., something like this before the second
loop:

	/* Reset the deadline for gen2 */
	timeout = jiffies + msecs_to_jiffies(500);

As it stands, if the first loop takes 490 ms, that leaves you only 10 ms
for the second loop. And I think it'd be confusing if we ever see the
first loop take a "long" time, and then we time out on the second --
we'd be blaming the gen2 training for gen1's slowness.

> >>+		status = pcie_read(port, PCIE_CORE_CTRL_MGMT_BASE);
> >>+		if (((status >> PCIE_CORE_PL_CONF_SPEED_SHIFT) &
> >>+		      PCIE_CORE_PL_CONF_SPEED_MASK) ==
> >>+		      PCIE_CORE_PL_CONF_SPEED_50G) {
> >>+			dev_dbg(port->dev, "pcie link training gen2 pass!\n");
> >>+			err = 0;
> >>+			break;
> >>+		}
> >>+		msleep(20);
> >>+	}
> >
> >Similar problem with your timeout loop, as mentioned above. Although I
> >confused about what you do in the error case here...
> >
> >>+	if (err)
> >>+		dev_dbg(port->dev, "pcie link training gen2 timeout, force to gen1!\n");
> >
> >... how are you forcing gen1? I don't see any code that indicates this.
> >Should you at least be checking that there aren't some kind of training
> >errors, and that we settled back on gen1/2.5G?
> 
> yes, when failing gen2,  my pcie controller will fallback to gen1
> automatically.

OK. Well maybe the text should say something like "falling back" instead
of "force"?

> if we pass the gen1 then fail to train gen2, a dbg msg here is enough
> here to let we know that we should check the HW signal. Of course we
> should make sure that this device supports gen2.

OK.

[...]

Brian
