Return-Path: <SRS0=o6Kt=A5=redhat.com=ddutile@kernel.org>
Return-Path: <SRS0=o6Kt=A5=redhat.com=ddutile@kernel.org>
Subject: Re: [PATCH] uio/uio_pci_generic: Add SR-IOV support
To: David Woodhouse <dwmw2@infradead.org>,
 Alexander Duyck <alexander.duyck@gmail.com>
References: <1506517162.30379.2.camel@infradead.org>
 <20170927220005.GB23674@bhelgaas-glaptop.roam.corp.google.com>
 <1506550852.7476.33.camel@infradead.org>
 <CAKgT0UeAg01Yy189pyzo_wDGYOEX6mBgsr_M9Lsi3u0+a-cW2w@mail.gmail.com>
 <bb77ab51-858b-df31-e672-7ccee964b269@redhat.com>
 <1506606369.7476.96.camel@infradead.org>
 <7bbb6cce-3462-fbb2-9ae4-5c08ab2b01b4@redhat.com>
 <1506613946.7476.130.camel@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@intel.com>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Bodong Wang <bodong@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
From: Don Dutile <ddutile@redhat.com>
Message-ID: <3ddc65bd-bf47-acb8-4cc5-db2531e1e864@redhat.com>
Date: Thu, 28 Sep 2017 12:56:15 -0400
MIME-Version: 1.0
In-Reply-To: <1506613946.7476.130.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 09/28/2017 11:52 AM, David Woodhouse wrote:
> On Thu, 2017-09-28 at 11:05 -0400, Don Dutile wrote:
>> ah, nickel summary: no in-kernel driver w/.sriov-configure method.
>> if so, now I'm up to speed with you....
>> hmmmm....
>> so, that would imply we need an in-kernel, pcie-common, .sriov-
>> configure method
>> that's invoked if a driver isn't bound to a device? ... yes?
>
> Well that was kind of the point in my question below the ---
>
> Is that something we want to be generic? Would we want to have quirks
> for the devices where we might *not* want it?
>
> Anything that *has* a driver for the PF, should have .sriov_configure
> already. Anything that doesn't have a driver can (now) use UIO to
> enable SR-IOV. So we don't *have* to make it unconditionally
> available...
>
Well, my point is more like: why put it in uio?
why not make it available via pcie, setup while/if no driver attached?
i.e., other non-uio users can use the mechanism.... like libvirt? ...
if a PF driver isn't required.
