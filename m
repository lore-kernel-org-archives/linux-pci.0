Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"paulus@samba.org" <paulus@samba.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"warrier@linux.vnet.ibm.com" <warrier@linux.vnet.ibm.com>,
	"zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>,
	"nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
	"gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>
Subject: RE: [PATCH] vfio-pci: Allow to mmap sub-page MMIO BARs if the mmio
 page is exclusive
Date: Tue, 3 May 2016 02:59:30 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F84131D@SHSMSX101.ccr.corp.intel.com>
References: <1461759740-5072-1-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1461759740-5072-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Yongji Xie
> Sent: Wednesday, April 27, 2016 8:22 PM
> 
> Current vfio-pci implementation disallows to mmap
> sub-page(size < PAGE_SIZE) MMIO BARs because these BARs' mmio
> page may be shared with other BARs. This will cause some
> performance issues when we passthrough a PCI device with
> this kind of BARs. Guest will be not able to handle the mmio
> accesses to the BARs which leads to mmio emulations in host.
> 
> However, not all sub-page BARs will share page with other BARs.
> We should allow to mmap those sub-page MMIO BARs which we can
> make sure will not share page with other BARs.
> 
> This patch adds support for this case. And we also try to use
> shadow resource to reserve the remaind of the page which hot-add
> device's BAR might be assigned into.

'shadow' usually means you have a corresponding part being
shadowed, while here looks you mostly want some 'dummy'
resource for reservation purpose?

> +
> +		if (!(res->start & ~PAGE_MASK)) {
> +			/*
> +			 * Add shadow resource for sub-page bar whose mmio
> +			 * page is exclusive in case that hot-add device's
> +			 * bar is assigned into the mem hole.
> +			 */
> +			shadow_res = kzalloc(sizeof(*shadow_res), GFP_KERNEL);
> +			shadow_res->resource.start = res->end + 1;
> +			shadow_res->resource.end = res->start + PAGE_SIZE - 1;

What about res->start not page aligned so you end up still having 
a portion before res->start not exclusively reserved?

> +			shadow_res->resource.flags = res->flags;
> +			if (request_resource(res->parent,
> +					&shadow_res->resource)) {
> +				kfree(shadow_res);
> +				return false;
> +			}
> +			shadow_res->index = index;
> +			list_add(&shadow_res->res_next,
> +					&vdev->shadow_resources_list);
> +			return true;

Thanks
Kevin
