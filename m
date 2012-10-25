Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.stuge.se ([212.116.89.98]:52181 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751575Ab2JYWhJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Oct 2012 18:37:09 -0400
Message-ID: <20121025223706.17034.qmail@stuge.se>
Date: Fri, 26 Oct 2012 00:37:06 +0200
From: Peter Stuge <peter@stuge.se>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: shashank chaturvedi <chaturvedi9950@gmail.com>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: xhci Portsc register issue
References: <CALuomMuUD4xSaCUT6MZn3ZV2gjXnuBUhkz78PgXZ6XgV4e-NvA@mail.gmail.com> <20121025153552.GA5205@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121025153552.GA5205@xanatos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sarah Sharp wrote:
> I'm not sure, since I've never attempted to memory map PCI registers
> from userspace.  I was under the impression that you just can't do that.

Need root, and the kernel still gets a say, but yes, you can just do that.

http://stuge.se/physrd.c


//Peter
