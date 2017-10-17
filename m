Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965952AbdJQThE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 15:37:04 -0400
Date: Tue, 17 Oct 2017 13:37:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Casey Leedom <leedom@chelsio.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "Komali Katari" <komali@chelsio.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: 4.14.0-rc3 is auto-reloading PCIe SR-IOV Virtual Function
 device drivers when VFs are attached to VMs ...
Message-ID: <20171017133702.1b0e35bc@t450s.home>
In-Reply-To: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <MWHPR12MB1600C4F1693E88236CA8F78EC84C0@MWHPR12MB1600.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 17 Oct 2017 18:36:21 +0000
Casey Leedom <leedom@chelsio.com> wrote:

> Hi there,
> 
>   I hope this is the right Linux list for this issue.  One of our QA staff
> has noticed a new behavior starting about 4.14.0-rc3.  We instantiate PCIe
> SR-IOV Virtual Functions and the corresponding driver (cxgb4vf in this case)
> is automatically loaded.  That's fine and has been the case for some time.
> But, we remove the driver module (rmmod cxgb4vf) and then attach one of the
> VFs to a KVM Virtual Machine and the cxgb4vf driver module gets reloaded in
> the KVM Hypervisor.  This is new behavior.  I see that there was a pretty
> big change done by Luis R. Rodriguez in kernel.org commit revision 2355869
> but we haven't yet isolated the new behavior to that commit.  That'll be our
> next test but I wanted to get this out there for comment.

I'm not sure I understand the problem, generally when doing device
assignment you're using vfio-pci, which I'll assume is the case since
we're talking about an upstream kernel and Legacy KVM device assignment
no longer exists upstream.  That means the VF being assigned needs to
be bound to the vfio-pci driver, which libvirt might do for you if the
hostdev XML is specified with managed='yes'.  At what point is cxgb4vf
being re-loaded?  Is it correlated with the VM starting or VF being
hot-added to a VM or the reverse, VM shutdown or VF removed?  Is the
cxgb4vf driver replacing vfio-pci for the device being assigned?
libvirt might do a drivers_probe on remove, but that behavior shouldn't
have changed.  Being a VF, it needs to support FLR, so that would be
the means vfio would use to reset the device.  I wouldn't expect an FLR
to trigger any sort of device remove/re-add that might cause udev to
reload the driver.  Presumably adding a modprobe.d blacklist entry for
cxgb4vf would resolve it, if so, maybe look at udev events.  If there
are multiple PFs in the host, any creation of new VFs matching the
cxgb4vf driver could trigger udev to re-load the driver.  Thanks,

Alex
