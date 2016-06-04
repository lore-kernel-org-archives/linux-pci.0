Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:51480 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbcFDXXk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2016 19:23:40 -0400
Date: Sun, 5 Jun 2016 01:27:18 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
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
Message-ID: <20160604232718.GA17088@wunner.de>
References: <1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 02, 2016 at 11:17:10AM +0300, Mika Westerberg wrote:
> Bjorn, if you are fine with these patches, it would be nice to get these to
> linux-next for better testing coverage.
> 
> Changes to v5:
> 
>   - Add patch "PCI: Power on bridges before scanning new devices" to make
>     sure rescanning using sysfs still works.
> 
>   - Change patch "ACPI / hotplug / PCI: Runtime resume bridge before
>     rescan" to runtime resume in acpiphp_check_bridge() instead of
>     hotplug_event().
> 
>   - Change runtime PM autosuspend delay from 10ms to 100ms.
> 
>   - Call pm_runtime_mark_last_busy() to make sure we do not runtime suspend
>     the port immediately.

I've applied v6 of this series to my local tree and tested it with
my Thunderbolt runtime pm patches. Everything seems to still work
fine, so my Tested-by is upheld.

I've also compared this version with the previous one in my tree and
reviewed the changes. I only found a punctuation and spacing change
that Bjorn had made and that isn't included in the commit message of
patch [4/5]:

< hotplug event such as BUS_CHECK, we need to make sure it is resumed before
< devices below the bridge are re-scanned.  Otherwise the devices behind the
---
> hotplug event, such as BUS_CHECK we need to make sure it is resumed before
> devices below the bridge are re-scanned. Otherwise the devices behind the

And this line in the commit message of patch [5/5] suddenly has > 72
chars now:

> Add back runtime PM support for PCIe ports that was removed in
> commit fe9a743a2601 ("PCI/PM: Drop unused runtime PM support code for PCIe

Thanks,

Lukas
