Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44668 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab3GPLmH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 16 Jul 2013 07:42:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI / hotplug / ACPI: Get rid of check_sub_bridges()
Date: Tue, 16 Jul 2013 13:51:58 +0200
Message-ID: <1395450.yBeZCSijNz@vostro.rjw.lan>
In-Reply-To: <20130716053641.GU4898@intel.com>
References: <1373735399-28055-1-git-send-email-mika.westerberg@linux.intel.com> <59738946.aKFnLHMEA1@vostro.rjw.lan> <20130716053641.GU4898@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 16, 2013 08:36:41 AM Mika Westerberg wrote:
> On Tue, Jul 16, 2013 at 02:31:15AM +0200, Rafael J. Wysocki wrote:
> > On Sunday, July 14, 2013 10:08:28 AM Mika Westerberg wrote:
> > > On Sat, Jul 13, 2013 at 11:47:26PM +0200, Rafael J. Wysocki wrote:
> > > > On Saturday, July 13, 2013 08:09:59 PM Mika Westerberg wrote:
> > > > > Now that acpiphp_check_bridge() always enumerates devices behind the
> > > > > bridge, there is no need to do that for each sub-bridge anymore like it is
> > > > > done in the current ACPI-based PCI hotplug code. Given this we don't need
> > > > > check_sub_bridges() anymore and can drop the function completely.
> > > > > 
> > > > > This also simplifies the ACPIPHP code a bit.
> > > > > 
> > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > ---
> > > > > This applies on top of v3.10 with Rafael's ACPIPHP + Thunderbolt series
> > > > > applied:
> > > > >
> > > > 
> > > > OK, I added it to my bleeding-edge branch along with this series:
> > > > 
> > > > > 	http://www.spinics.net/lists/linux-acpi/msg44480.html
> > > > 
> > > > rebased on top of some previous ACPI cleanup commits.  I needed to make some
> > > > changes in the process (and fixed up some breakage reported by the auto build
> > > > testing), hopefully I didn't break anything.  If you're in an adventurous mood,
> > > > testing would be welcome. ;-)  [That already includes the majority of 3.11
> > > > material from Linus, though, so unexpected breakage elsewhere may happen.]
> > > 
> > > Tried the bleeding-edge branch on both of our test machines and Thunderbolt
> > > still works fine.
> > 
> > Can you please apply the appended patch on top of the current
> > linux-pm.git/bleeding-edge and check if things still work then on the test
> > systems?
> 
> Tested on both systems with the patch applied and Thunderbolt still works
> fine.

Thanks for the confirmation!

I'm going to fold this code into the "ACPI / hotplug / PCI: Check for new devices
on enabled slots" patch and resend the whole series without the "RFC" mark.
I'll add your "Tested-by" to it if you don't mind.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
