Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44639 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759707Ab3BZDzz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Feb 2013 22:55:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: ALLurGroceries <allurgroceries@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	Zheng Yan <zheng.z.yan@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [Bug 53811] [REGRESSION]: acpiphp broken on Lenovo X220 from 3.6 onwards
Date: Tue, 26 Feb 2013 05:02:39 +0100
Message-ID: <5101020.3N450MHRvH@vostro.rjw.lan>
In-Reply-To: <CAErSpo6_tO8r2xq-7uo8H18L61Kunb0HgTOvZv0u-sCQKwipxA@mail.gmail.com>
References: <CAErSpo5PFn9gDgKWHoGpiSEE9862WbTDm7VVtxMxX05zK7b6kw@mail.gmail.com> <1360874504.16827.5.camel@x220> <CAErSpo6_tO8r2xq-7uo8H18L61Kunb0HgTOvZv0u-sCQKwipxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, February 25, 2013 08:52:42 PM Bjorn Helgaas wrote:
> [+to Huang]
> 
> On Thu, Feb 14, 2013 at 1:41 PM, ALLurGroceries
> <allurgroceries@gmail.com> wrote:
> > On Thu, 2013-02-14 at 10:40 -0700, Bjorn Helgaas wrote:
> >> [+cc Zheng, Rafael, linux-pci]
> >>
> >> On Wed, Feb 13, 2013 at 11:55 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> >> > https://bugzilla.kernel.org/show_bug.cgi?id=53811
> >> >
> >> >            Summary: acpiphp broken on Lenovo X220 from 3.6 onwards
> >>
> >> Thanks for the report.  Can you please attach complete dmesg logs from
> >> kernels with your patch (showing a working hotplug) and without your
> >> patch (showing the failing hotplug)?
> >
> > OK, they're attached. The hotplug is at the very end of both. Without
> > the patch, when I try to power the card on with
> > echo 1 > /sys/bus/pci/slots/1/power
> >
> > I get:
> > acpiphp_glue: acpiphp_enable_slot: Slot status is not ACPI_STA_ALL
> 
> Does anybody care about this runtime PM support for PCIe ports?

Yes.

> If nobody wants to fix this regression, I'm going to revert 71a83bd727
> "PCI/PM: add runtime PM support to PCIe port" and anything that
> depends on it.

I'll have a look at this tomorrow.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
