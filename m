Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752862AbdDLPXS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Apr 2017 11:23:18 -0400
Date: Wed, 12 Apr 2017 10:22:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bodong Wang <bodong@mellanox.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, saeedm@mellanox.com,
        Eli Cohen <eli@mellanox.com>
Subject: Re: [v2] PCI: Add an option to control probing of VFs before
 enabling SR-IOV
Message-ID: <20170412152216.GA25197@bhelgaas-glaptop.roam.corp.google.com>
References: <1490198038-20465-1-git-send-email-bodong@mellanox.com>
 <20170411211211.GB14778@bhelgaas-glaptop.roam.corp.google.com>
 <2e39e1b6-0205-2780-0223-3552d2c871a3@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2e39e1b6-0205-2780-0223-3552d2c871a3@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 12, 2017 at 09:37:22AM -0500, Bodong Wang wrote:
> On 4/11/2017 4:12 PM, Bjorn Helgaas wrote:
> >Hi Bodong,
> >
> >On Wed, Mar 22, 2017 at 05:53:58PM +0200, bodong@mellanox.com wrote:
> >>From: Bodong Wang <bodong@mellanox.com>
> >>
> >>Sometimes it is not desirable to probe the virtual functions after
> >>SRIOV is enabled. This can save host side resource usage by VF
> >>instances which would be eventually probed to VMs.
> >>
> >>Add a new PCI sysfs interface "sriov_probe_vfs" to control that
> >>from the PF, all current callers still retain the same functionality.
> >>To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to
> >>
> >>/sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
> >Is this basically the same functionality as /sys/bus/pci/drivers_autoprobe,
> >but limited to a specific PF?  I.e., could we accomplish the same thing
> >with the following?
> >
> >   # echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
> >   # echo 0 > /sys/bus/pci/drivers_autoprobe
> >   # echo 2 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
> >   # echo 1 > /sys/bus/pci/drivers_autoprobe
> >
> >If not, can you contrast the above with drivers_autoprobe?  If we need
> >both, should they be named more similarly?
> Hi Bjorn,
> 
> I agree with Alex about not using driver_autoprobe to achieve this.
> It will affect all pci related device once it's disabled(probably in
> a bad way). 

I agree drivers_autoprobe is racy with respect to other PCI devices, so
it's not a great solution to your issue.  But I do want to make it
obvious that these are related concepts.

Alex mooted the idea of a generic driver core knob for devices that
create child devices.  That's intriguing.  What other situations
besides SR-IOV do this?  Maybe we could add a "drivers_autoprobe"
inside the directory of each device that's capable of having child
devices?

If we continue with the current approach (instead of Alex's idea),
I propose that you:

  - Name your new knob "sriov_drivers_autoprobe" to be consistent with
    other sriov sysfs files while also being parallel to
    "drivers_autoprobe"

  - Update Documentation/ABI/testing/sysfs-bus-pci to document your
    new knob

  - Update Documentation/ABI/... to document drivers_autoprobe

Bjorn
