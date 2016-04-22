Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19631 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbcDVJKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Apr 2016 05:10:34 -0400
Date: Fri, 22 Apr 2016 12:10:26 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] PCI: Add runtime PM support for PCIe ports
Message-ID: <20160422091026.GG1725@lahna.fi.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <CAJZ5v0ic6YpYtM4cymLJ4oV2-J4CK4MxFi9-6bWNADD-QY3B6A@mail.gmail.com>
 <20160421131224.GY1725@lahna.fi.intel.com>
 <2823801.fOoJOI22FZ@vostro.rjw.lan>
 <CAMxnaaXN7YwEDNGDR1aRbOqhj_2JFyQAiCSjqvTa500x_xRmLA@mail.gmail.com>
 <CAJZ5v0hwmyPz8J2YFc-fS51BpBkh6+TrtnZ1WJRhbDzsdrbqGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hwmyPz8J2YFc-fS51BpBkh6+TrtnZ1WJRhbDzsdrbqGA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 22, 2016 at 02:26:22AM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 22, 2016 at 1:25 AM, Andreas Noever
> <andreas.noever@gmail.com> wrote:
> > On Thu, Apr 21, 2016 at 9:19 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> On Thursday, April 21, 2016 04:12:24 PM Mika Westerberg wrote:
> >>> On Wed, Apr 20, 2016 at 10:23:33PM +0200, Rafael J. Wysocki wrote:
> >>> > Breaking any systems that work today is not an option.  if that
> >>> > happens, the commit that has done that is a clear candidate for
> >>> > reverting.
> >>>
> >>> Understood, thanks.
> >>>
> >>> BTW, do you have any preference regarding the cut-off date?
> >>
> >> Some time around when machines with Windows 10 started to ship should be
> >> relatively safe.
> >>
> >> I guess we can just pick a reasonable date in the initial patch and then
> >> try to move it back to the past subsequently and see if that breaks things
> >> for anyone.
> >
> > Maybe add a boot option to overwrite the heuristic (in both
> > directions) to allow people to test this on older machines and
> > pinpoint breakage on newer machines?
> 
> Yes, a kernel command line override would be fine by me.

OK, so to summarize:

 - Use cut-off date 2015 which is the year Windows 10 was released

 - Add command line parameter that allows this to be overridden.
   Something like:

	pcie_port_pm=   [PCIE] PCIe port power management handling:
		off     Disable power management off all PCIe ports
		force   Forcibly enable power management of all PCIe ports
