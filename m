Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38538 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbcFFJnx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 05:43:53 -0400
Date: Mon, 6 Jun 2016 12:43:47 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Peter Wu <peter@lekensteyn.nl>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 0/5] PCI: Add support for suspending (including
 runtime) of PCIe ports
Message-ID: <20160606094347.GS1743@lahna.fi.intel.com>
References: <1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160604232718.GA17088@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160604232718.GA17088@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 05, 2016 at 01:27:18AM +0200, Lukas Wunner wrote:
> On Thu, Jun 02, 2016 at 11:17:10AM +0300, Mika Westerberg wrote:
> > Bjorn, if you are fine with these patches, it would be nice to get these to
> > linux-next for better testing coverage.
> > 
> > Changes to v5:
> > 
> >   - Add patch "PCI: Power on bridges before scanning new devices" to make
> >     sure rescanning using sysfs still works.
> > 
> >   - Change patch "ACPI / hotplug / PCI: Runtime resume bridge before
> >     rescan" to runtime resume in acpiphp_check_bridge() instead of
> >     hotplug_event().
> > 
> >   - Change runtime PM autosuspend delay from 10ms to 100ms.
> > 
> >   - Call pm_runtime_mark_last_busy() to make sure we do not runtime suspend
> >     the port immediately.
> 
> I've applied v6 of this series to my local tree and tested it with
> my Thunderbolt runtime pm patches. Everything seems to still work
> fine, so my Tested-by is upheld.

Great, thanks!

> I've also compared this version with the previous one in my tree and
> reviewed the changes. I only found a punctuation and spacing change
> that Bjorn had made and that isn't included in the commit message of
> patch [4/5]:
> 
> < hotplug event such as BUS_CHECK, we need to make sure it is resumed before
> < devices below the bridge are re-scanned.  Otherwise the devices behind the
> ---
> > hotplug event, such as BUS_CHECK we need to make sure it is resumed before
> > devices below the bridge are re-scanned. Otherwise the devices behind the

Hmm, the patch is calling pm_runtime_get_sync()/pm_runtime_put() in
acpiphp_check_bridge() now instead of in hotplug_event() like it was in
the previous version.

> And this line in the commit message of patch [5/5] suddenly has > 72
> chars now:
> 
> > Add back runtime PM support for PCIe ports that was removed in
> > commit fe9a743a2601 ("PCI/PM: Drop unused runtime PM support code for PCIe

Yes, I changed it because checkpatch.pl wants to have commit <COMMIT> in
the same line apparently.
