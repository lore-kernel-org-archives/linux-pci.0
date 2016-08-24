Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 24 Aug 2016 16:39:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: wangyijing <wangyijing@huawei.com>
Cc: bhelgaas@google.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: release pci_host_bridge resource after remove root
 bus
Message-ID: <20160824213921.GH23914@localhost>
References: <1466682138-25281-1-git-send-email-wangyijing@huawei.com>
 <20160822172821.GG18628@localhost>
 <57BBB383.50503@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <57BBB383.50503@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 10:22:59AM +0800, wangyijing wrote:
> 在 2016/8/23 1:28, Bjorn Helgaas 写道:
> > On Thu, Jun 23, 2016 at 07:42:18PM +0800, Yijing Wang wrote:
> >> pci_host_bridge holds the top resources(IO port/Mem/bus),
> >> now we release pci_host_bridge resources in
> >> acpi_pci_root_release_info() which would be called when
> >> pci_host_bridge device refcount reach 0. In some cases,
> >> pci_host_bridge refcount cannot reach 0 after we remove
> >> pci root bus in pci_remove_root_bus(). 
> > 
> > Did you figure out *why* the host bridge refcount is non-zero?
> > That seems like it could be part of the problem.
> 
> 1. pci_create_root_bus()  //root bus get a refcount of hostbridge， put the
>    refcount when root bus release(bus dev refcount == 0);
> 2. pci_alloc_dev()  //pci dev get a refcount of pci_bus, put the refcount
>    when pci_dev release(pci_dev refcount == 0)
> 3. some upper driver could get the pci dev refcount(e.g. we found if we mount a fs in mptsas disk, the mptsas pci dev refcount would be added)
> 
> 4. if we start remove the root bus before umount, in this case, the mptsas pci dev refcount won't reach 0, so as the step 1 and 2 show,
>    the root bus and host bridge refcount won't reach 0 too.
> 
> 
> > 
> > You're moving some release_resource() calls from pci_root.c to
> > host-bridge.c.  Where are the corresponding insert or request resource
> > calls?  It's more maintainable if we keep the insert and remove paths
> > close in the code.
> > 
> >> Then if we want to
> >> hot add pci root bus, we cannot use pci_host_bridge
> >> resources because of conflicts with old resources which are
> >> still in system. I think this is not reasonable.
> >>
> >> 1. For pci devices, we would release their resources in
> >>    pci_destroy_dev() regardless of pci device refcount.
> >> 2. When we try to remove pci root bus, there is no devices
> >>    need to use the pci_host_bridge resources again, release
> >>    pci_host_bridge resources is safe.
> >> 3. In some cases, users woule make mistake, for example,
> >>    user get a pci device(increase refcount), but forget to
> >>    put this device, then if we do hotplug pci root bus,
> >>    it would make all pci devices cannot work after hot add.
> > 
> > Can you explain this a little more?  Are you talking about a *driver*
> > that forgets to put the device?
> 
> Yes, may some pci drivers make a mistake, the refcount control the device object
> release is fine, but I think move the mem resource release out is better.

If this is caused by driver bugs, I think we need to fix the driver
bugs.

So far all I see here is "it works when I do this."  What we need is
an argument for "it's correct to do this."  It's certainly possible
that you're already making that argument and I'm just not
understanding it.

> >> I found this issue in the following case:
> >> 1. I have a raid pci device in my system;
> >> 2. I mount a disk which connect to this raid.
> >> 3. hot remove the pci root bus.
> >> 4. hot add the pci root bus.
> >> 5. found the resource conflicts for the children pci devices under this root bus.
> >>
> >> pci_root_bus increase a refcount at pci_host_bridge.
> >> pci_root_bus decrease a refcount at pci_host_bridge in
> >>   release_pcibus_dev() when pci_root_bus device refcount reach 0.
> >>
> >> pci_dev increase a refcount at pci_bus in pci_alloc_dev().
> >> pci_dev decrease a refcount at pci_bus in pci_release_dev()
> >> when pci_dev refcount reach 0.
> >>
> >> If any pci device refcount cannot reach 0, then its pci_bus
> >> refcount cannot reach 0 too, the result is pci_host_bridge
> >> refcount cannot reach 0.
> > 
> > .
> > 
> 
