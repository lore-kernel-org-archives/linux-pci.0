Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 16 Nov 2016 16:48:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>,
        Hadden Hoppert <haddenh@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI: hv: clean-up and 2 fixes to the hot-remove case
Message-ID: <20161116224858.GC16042@bhelgaas-glaptop.roam.corp.google.com>
References: <MWHPR03MB2669C98A17A4B450BB0BA72EBFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB2669C98A17A4B450BB0BA72EBFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 10, 2016 at 07:16:22AM +0000, Dexuan Cui wrote:
> PATCH 1 is just a clean-up. There should be no functional change.
> 
> PATCH 2 and 3 are for device hot-remove case. 
> Currently the driver will stop working or even cause panic, if we do
> hot add/remove quickly a few times. With the 2 patches, everything works
> reliably in my tests now.
> 
> There can be still a potential issue with hot-remove when we unload 
> the driver at the same time. That would require more work of proper
> synchronization among the 3 paths: the .probe/.remove, the channel callback,
> and the offloaded hv_pci_devices_present()/hv_eject_device_work().
> 
> But for now, PATCH 2 and 3 do improve the situation a lot.
> 
> Dexuan Cui (3):
>   PCI: hv: use the correct buffer size in new_pcichild_device()
>   PCI: hv: fix hv_pci_remove() for hot-remove
>   PCI: hv: delete the device earlier from hbus->children for hot-remove
> 
>  drivers/pci/host/pci-hyperv.c | 67 ++++++++++++++++++++++++++-----------------
>  1 file changed, 40 insertions(+), 27 deletions(-)

I applied all three of these to pci/host-hv for v4.10, thanks!

Jake, I converted your "looks good to me" to Reviewed-by tags.

K. Y., I added your acks on 2 & 3.  If you acked 1, I missed it.
