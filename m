Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:54920 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbbIOUfx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Sep 2015 16:35:53 -0400
MIME-Version: 1.0
Message-ID: <trinity-72039782-5a6d-4245-add2-93502d0d5827-1442349348195@3capp-webde-bs58>
From: "Roland Weber" <r-o-l@web.de>
To: linux-usb@vger.kernel.org
Cc: "Mathias Nyman" <mathias.nyman@intel.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2015 22:35:48 +0200
In-Reply-To: <Pine.LNX.4.44L0.1509151010160.1420-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1509151010160.1420-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

> However, note that CONFIG_PM_RUNTIME doesn't exist any more in 4.2; it 
> is now covered by CONFIG_PM.

That explains why the setting was disabled in the first place.
I had taken a config from 4.2 and ran "make oldconfig" on it
with the 3.17 kernel.

Actually, the configurations with CONFIG_PM_RUNTIME disabled give
me warnings about some cross-dependencies that are not satisfied.
With "make menuconfig", I haven't been able to switch off the
setting, because CONFIG_PM_SLEEP and something else forces it on,
and I have no idea where in the menus I would find those. And if I
edit .config directly, I don't know what other cross-dependencies
I'll violate that way.

I only had a few minutes to spare today to select a config and
kick off the compilation. Now I have a 3.17 kernel with some more
debug output, but which freezes on 'bind' instead of 'unbind'. *sigh*
I'm afraid I've been doing too much just-before-bedtime debugging
lately and need to take a step back.
I'll set aside a few hours on Thursday to prepare a proper config
with a behavior that is comparable to the ones I've observed earlier.
Then I will send decent debug output over the week-end. It's not
like this problem will run away if I don't track it fast enough :-)

cheers and thanks,
  Roland
