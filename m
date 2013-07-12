Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:18429 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933013Ab3GLNNY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Jul 2013 09:13:24 -0400
Date: Fri, 12 Jul 2013 16:18:50 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: Re: [RFC][PATCH 0/30] ACPI / hotplug / PCI: Major rework +
 Thunderbolt workarounds
Message-ID: <20130712131850.GL4898@intel.com>
References: <26431283.HJCKsss0rt@vostro.rjw.lan>
 <3718119.FLASu5DBx8@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3718119.FLASu5DBx8@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 12, 2013 at 01:34:20AM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> I've made some progress with my ACPIPHP rework since I posted the series last
> time and here goes an update.
> 
> First off, the previous series was somewhat racy, which should be fixed now.
> Apart from this there's quite some new material on top of the patches I posted
> last time (or rather on top of their new versions) and I integrated the
> Thunderbolt series from Mika with that.  As a result,
> 
> https://patchwork.kernel.org/patch/2817341/
> 
> is required to be applied.

With the above mentioned patch applied + fix for patch [23/30], I tested
this series on Acer Aspire S5 and Intel DZ77RE-75K desktop and Thunderbolt
works just fine :-)

You can add

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

to the series.

Nice cleanup!
