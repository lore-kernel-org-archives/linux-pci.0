Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39887 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878AbcEaNRD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 31 May 2016 09:17:03 -0400
Date: Tue, 31 May 2016 08:16:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH][RFC] PCI: Workaround to enable poweroff on Mac Pro 11
Message-ID: <20160531131658.GA23837@localhost>
References: <1464604404-11257-1-git-send-email-yu.c.chen@intel.com>
 <20160530213305.GA21322@localhost>
 <574D03F9.6050201@intel.com>
 <CAE9FiQV_Mc9VuyBvCB7hL_0pgj+-wW1_jupzhbTHij+VQeLF-A@mail.gmail.com>
 <574D3AAA.6090503@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <574D3AAA.6090503@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 31, 2016 at 03:18:02PM +0800, Chen Yu wrote:
> On 2016年05月31日 15:00, Yinghai Lu wrote:
> >On Mon, May 30, 2016 at 8:24 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> >
> >>and then in pcibios_assign_resources, 0000:00:1c.0 tries to allocate minimal
> >>resource window and then update related base/limit registers:
> >>
> >>[    0.865342] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus
> >>02] add_size 1000
> >>[    0.865343] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff
> >>64bit pref] to [bus 02] add_size 200000 add_align 100000
> >>[    0.865344] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff]
> >>to [bus 02] add_size 200000 add_align 100000
> >>
> >That is for hotplug bridge, then we could use following instead.
> >
> >diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >index ee72ebe..d3ec833 100644
> >--- a/drivers/pci/quirks.c
> >+++ b/drivers/pci/quirks.c
> >@@ -2775,6 +2775,13 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)
> >
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
> >
> >+static void quirk_hotplug_bridge_skip(struct pci_dev *dev)
> >+{
> >+       dev->is_hotplug_bridge = 0;
> >+}
> >+
> >+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10,
> >quirk_hotplug_bridge_skip);
> >+
> >  /*
> >   * This is a quirk for the Ricoh MMC controller found as a part of
> >   * some mulifunction chips.
> Good idea, but in this way we might not have io window allocated for
> it?I'm not sure
> if this would break wifi,etc, I'll suggest reporters to have a try.

Let's figure out the root cause before trying more random fixes.  I
have the same objection to the patch above.  No doubt there are many
ways we could "fix" this, but unless we know the root cause, we're
likely to make a change that's not a complete fix or will cause other
issues in the future.

Bjorn
