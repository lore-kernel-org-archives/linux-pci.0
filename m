Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62626 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752004AbcDUTQi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2016 15:16:38 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 4/4] PCI: Add runtime PM support for PCIe ports
Date: Thu, 21 Apr 2016 21:19:30 +0200
Message-ID: <2823801.fOoJOI22FZ@vostro.rjw.lan>
In-Reply-To: <20160421131224.GY1725@lahna.fi.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com> <CAJZ5v0ic6YpYtM4cymLJ4oV2-J4CK4MxFi9-6bWNADD-QY3B6A@mail.gmail.com> <20160421131224.GY1725@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, April 21, 2016 04:12:24 PM Mika Westerberg wrote:
> On Wed, Apr 20, 2016 at 10:23:33PM +0200, Rafael J. Wysocki wrote:
> > Breaking any systems that work today is not an option.  if that
> > happens, the commit that has done that is a clear candidate for
> > reverting.
> 
> Understood, thanks.
> 
> BTW, do you have any preference regarding the cut-off date?

Some time around when machines with Windows 10 started to ship should be
relatively safe.

I guess we can just pick a reasonable date in the initial patch and then
try to move it back to the past subsequently and see if that breaks things
for anyone.

Thanks,
Rafael

