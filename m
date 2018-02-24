Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40795 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXN7s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Feb 2018 08:59:48 -0500
Date: Sat, 24 Feb 2018 14:59:46 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Feng Kan <fkan@apm.com>, Linux PM <linux-pm@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCIe bridge deferred probe breaks suspend resume
Message-ID: <20180224135946.GA1735@wunner.de>
References: <1519433209-14581-1-git-send-email-fkan@apm.com>
 <CAJZ5v0hDM=DtBZA1awz7ao62cpe4CAhUz1L7KkLTv=G3YQhuEw@mail.gmail.com>
 <CAJZ5v0jJMODOsZV41Jn18LCtttMemFQyXonJxZnUgXday8_4iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0jJMODOsZV41Jn18LCtttMemFQyXonJxZnUgXday8_4iw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 24, 2018 at 10:47:26AM +0100, Rafael J. Wysocki wrote:
> On Sat, Feb 24, 2018 at 10:35 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Sat, Feb 24, 2018 at 1:46 AM, Feng Kan <fkan@apm.com> wrote:
> >> This is not a patch, but rather a question regarding the deferred
> >> probe's effect on PCIe PM ordering. This happens on our system
> >> which defer the probing of root bridge due to  the IOMMU not being
> >> ready. Because of the deferred action, the bridge is moved to the
> >> end of the dpm_list which results in incorrect suspend and resume
> >> sequence.
> >>
> >> In the cases I have seen, the bridge is always reordered because of
> >> startup sequence. They are always place after the endpoint. If that
> >> is the case the following code should be able to prevent such cases.
> >> However, is there some cases here that would violate such situation?
> >
> > The code in dd.c assumes that the device being probed has no children
> > (or consumers, for that matter) and so it is safe to move it to the
> > end of the list.
> >
> > If the device has children (or consumers), moving it to the end of the
> > list by itself doesn't work, which is the case for you.
> >
> > You can try to replace the device_pm_move_last(dev) in
> > deferred_probe_work_func(struct() with device_reorder_to_tail(), but
> > that has to be called under device_links_read_lock/unloc () and
> > device_pm_lock/unloc() (in the right order).
> 
> Alternatively, you can replace your !dev_is_pci(dev) check with a
> check for the presence of children or consumers and only move the
> device to the end of the PM list if there are not any.  That would
> kind of make sense, but it may break other assumptions in the deferred
> probing mechanism which I don't recall ATM.
> 
> Or avoid deferred probing of the host bridge driver entirely.  I guess
> you can use it with limited functionality until the IOMMU driver is
> ready and switch over to the fully functional operation mode when that
> happens, but that would need to hook into the IOMMU code somehow.

Or model the root bridge's dependency on the iommu using a device link:
https://www.kernel.org/doc/html/latest/driver-api/device_link.html

Thanks,

Lukas
