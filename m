Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54775 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932252AbcASWJh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2016 17:09:37 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, mika.westerberg@intel.com,
	Qi Zheng <qi.zheng@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] PCI/PM: Revert "PCI/PM: Drop unused runtime PM support code for PCIe ports"
Date: Tue, 19 Jan 2016 23:10:20 +0100
Message-ID: <41526334.QosPv6IFu0@vostro.rjw.lan>
In-Reply-To: <20160119215234.GH14080@localhost>
References: <1452868065-96999-1-git-send-email-qipeng.zha@intel.com> <20160119215234.GH14080@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 19, 2016 03:52:34 PM Bjorn Helgaas wrote:
> [+cc Rafael, author of fe9a743a2601]
> 
> On Fri, Jan 15, 2016 at 10:27:44PM +0800, Qipeng Zha wrote:
> > This reverts commit fe9a743a2601 ("PCI/PM: Drop unused runtime
> > PM support code for PCIe ports"). To support PCIe ports
> > runtime PM for Intel Broxton platform.
> 
> This changelog is not as useful as it could be.  It's true that this
> reverts fe9a743a2601, but what's important is that this adds support
> code for runtime PM of PCIe ports, so that should be mentioned first.
> 
> The fe9a743a2601 changelog says "If we are to support runtime PM of
> PCIe ports, it will have to be done in a different way most likely
> anyway."  I don't know what Rafael had in mind there, but we certainly
> need to ask him before adding it back the same way it was.

Thanks!

The previous approach had a few problems that showed up in testing and
that's why the code was first disabled and then removed from the kernel.

We can't re-enable it or those problems will show up again.

I have not looked at adding PCIe port runtime PM support in a cleaner
way yet, but it is on my radar.

Thanks,
Rafael

