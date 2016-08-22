Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 22 Aug 2016 12:28:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: bhelgaas@google.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: release pci_host_bridge resource after remove root
 bus
Message-ID: <20160822172821.GG18628@localhost>
References: <1466682138-25281-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466682138-25281-1-git-send-email-wangyijing@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 23, 2016 at 07:42:18PM +0800, Yijing Wang wrote:
> pci_host_bridge holds the top resources(IO port/Mem/bus),
> now we release pci_host_bridge resources in
> acpi_pci_root_release_info() which would be called when
> pci_host_bridge device refcount reach 0. In some cases,
> pci_host_bridge refcount cannot reach 0 after we remove
> pci root bus in pci_remove_root_bus(). 

Did you figure out *why* the host bridge refcount is non-zero?
That seems like it could be part of the problem.

You're moving some release_resource() calls from pci_root.c to
host-bridge.c.  Where are the corresponding insert or request resource
calls?  It's more maintainable if we keep the insert and remove paths
close in the code.

> Then if we want to
> hot add pci root bus, we cannot use pci_host_bridge
> resources because of conflicts with old resources which are
> still in system. I think this is not reasonable.
> 
> 1. For pci devices, we would release their resources in
>    pci_destroy_dev() regardless of pci device refcount.
> 2. When we try to remove pci root bus, there is no devices
>    need to use the pci_host_bridge resources again, release
>    pci_host_bridge resources is safe.
> 3. In some cases, users woule make mistake, for example,
>    user get a pci device(increase refcount), but forget to
>    put this device, then if we do hotplug pci root bus,
>    it would make all pci devices cannot work after hot add.

Can you explain this a little more?  Are you talking about a *driver*
that forgets to put the device?

> I found this issue in the following case:
> 1. I have a raid pci device in my system;
> 2. I mount a disk which connect to this raid.
> 3. hot remove the pci root bus.
> 4. hot add the pci root bus.
> 5. found the resource conflicts for the children pci devices under this root bus.
> 
> pci_root_bus increase a refcount at pci_host_bridge.
> pci_root_bus decrease a refcount at pci_host_bridge in
>   release_pcibus_dev() when pci_root_bus device refcount reach 0.
> 
> pci_dev increase a refcount at pci_bus in pci_alloc_dev().
> pci_dev decrease a refcount at pci_bus in pci_release_dev()
> when pci_dev refcount reach 0.
> 
> If any pci device refcount cannot reach 0, then its pci_bus
> refcount cannot reach 0 too, the result is pci_host_bridge
> refcount cannot reach 0.
