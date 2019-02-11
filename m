Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDCDC169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 10:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B822080D
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 10:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfBKK1Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:27:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:30493 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKK1Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 05:27:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 02:27:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="113980062"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 11 Feb 2019 02:27:12 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 11 Feb 2019 12:27:12 +0200
Date:   Mon, 11 Feb 2019 12:27:12 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, Peter Wu <peter@lekensteyn.nl>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20190211102712.GX7875@lahna.fi.intel.com>
References: <20190131163856.50260-1-mika.westerberg@linux.intel.com>
 <20190208002731.GS7268@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208002731.GS7268@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Feb 07, 2019 at 06:27:31PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 31, 2019 at 07:38:56PM +0300, Mika Westerberg wrote:
> > Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
> > connected to an Alpine Ridge Thunderbolt controller. This port has slot
> > implemented bit set in the config space but other than that it is not
> > hotplug capable in the sense we are expecting in Linux (it has
> > dev->is_hotplug_bridge set to 0):
> > 
> > 00:1c.4 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #5
> >         Bus: primary=00, secondary=05, subordinate=46, sec-latency=0
> >         Memory behind bridge: 78000000-8fffffff [size=384M]
> >         Prefetchable memory behind bridge: 00003800f8000000-00003800ffffffff [size=128M]
> >         ...
> >         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
> >         ...
> >                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
> >                         Slot #8, PowerLimit 25.000W; Interlock- NoCompl+
> >                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
> >                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
> >                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
> >                         Changed: MRL- PresDet+ LinkState+
> > 
> > This system is using ACPI based hotplug to notify the OS that it needs
> > to rescan the PCI bus (ACPI hotplug).
> > 
> > If there is nothing connected in any of the Thunderbolt ports the root
> > port will not have any runtime PM active children and is thus
> > automatically runtime suspended pretty soon after boot by PCI PM core.
> > Now, when a device is connected the BIOS SMI handler responsible for
> > enumerating newly added devices is not able to find anything because the
> > port is in D3.
> > 
> > Prevent this from happening by blacklisting PCI power management of this
> > particular Gigabyte system.
> 
> Since this is one of those issues we seem to have to discover
> experimentally, I'd like to include a URL here to a kernel.org
> bugzilla that has a dmesg log, "lspci -vvvnn" output, an acpidump, and
> anything else that might be useful to extend or generalize this in the
> future.  Maybe dmidecode output, too?
> 
> If somebody creates the bugzilla, I can add the URL; no need to repost
> just for that.

Here it is:

https://bugzilla.kernel.org/show_bug.cgi?id=202031
