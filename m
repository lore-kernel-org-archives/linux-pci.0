Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:60681 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbbIOARo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Sep 2015 20:17:44 -0400
MIME-Version: 1.0
Message-ID: <trinity-22d19320-d992-458f-a911-d05c6c60a012-1442276254269@3capp-webde-bs08>
From: "Roland Weber" <r-o-l@web.de>
To: linux-usb@vger.kernel.org
Cc: "Mathias Nyman" <mathias.nyman@intel.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2015 02:17:34 +0200
In-Reply-To: <Pine.LNX.4.44L0.1509131649200.19943-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1509131649200.19943-100000@netrider.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

> > ehci_halt: premature readl returned 10001
> 
> Note: 10001 instead of 10000, which is what you saw in the other 
> kernel.  That could be highly relevant.

Really? And I thought that was the least significant bit...

I had a lucky guess among the 2000+ lines of diff output with
which I started: CONFIG_PM_RUNTIME makes the difference.
If it's on, the kernel can freeze.

I'll have to add the debug output you asked for tomorrow,
didn't expect to succeed so soon.

Should I put the statements into the 3.17 kernel, or should I
try to compile a 4.2 without CONFIG_PM_RUNTIME instead? And
would you like the output of a freezing or non-freezing kernel
first? I'll only be able to try out one tomorrow, the rest
will follow a day or two later.

cheers and thanks,
  Roland
