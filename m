Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39787 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756216Ab2LMTxw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Dec 2012 14:53:52 -0500
Date: Thu, 13 Dec 2012 11:53:48 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Andrew Lutomirski <luto@mit.edu>,
	Ulrich Eckhardt <usb@uli-eckhardt.de>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <ming.lei@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
Message-ID: <20121213195348.GA23257@xanatos>
References: <20121126191002.GE6504@xanatos>
 <1962497.aG1sFtYjJG@vostro.rjw.lan>
 <20121207002808.GG5324@xanatos>
 <7766249.mqYLvmhmrJ@vostro.rjw.lan>
 <1355279525.7216.154.camel@yhuang-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1355279525.7216.154.camel@yhuang-dev>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 12, 2012 at 10:32:05AM +0800, Huang Ying wrote:
> Please try the patch attached.  With it, USB host controller can be
> waken up with USB card reader plugging in on my test machine.

This patch works for me.  When I enable runtime PM for both the root port
and the host controller, and I see the xHCI host go into PCI runtime
suspend, but there's no longer a message about the power state changing
to D3cold.  USB device connects while the PCI host is suspended work
now, as well as remote wakeup.

Tested-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>

Please mark this for stable.

Thanks,
Sarah Sharp
