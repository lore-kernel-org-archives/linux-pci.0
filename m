Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:55131 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756256Ab2KZVsr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Nov 2012 16:48:47 -0500
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Ulrich Eckhardt <usb@uli-eckhardt.de>,
	Andrew Lutomirski <luto@mit.edu>,
	"linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <ming.lei@canonical.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
References: <20121126191002.GE6504@xanatos>
Date: Mon, 26 Nov 2012 22:48:03 +0100
In-Reply-To: <20121126191002.GE6504@xanatos> (Sarah Sharp's message of "Mon,
	26 Nov 2012 11:10:02 -0800")
Message-ID: <87boekave4.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:

> It looks like both Ulrich and Andrew have the same issue.  I also have a
> Lenovo x220, and I confirmed that when I turn on PCI runtime suspend,
> the NEC host controller does not report port status changes when a new
> USB device is plugged in.
>
> I'm running 3.6.7, and I'm pretty sure that runtime suspend worked for
> the NEC host on some older kernel.  I don't think the NEC host went into
> D3cold on that kernel, though.  Is there a way to disable D3cold and
> just use D3hot instead?

Yes, you have /sys/bus/pci/devices/.../d3cold_allowed
See Documentation/ABI/testing/sysfs-bus-pci

If this really is a problem with the D3cold support that went into 3.6
then I guess you should include Huang Ying in the discussions as well
(CCed).


Bjørn
