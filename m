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
Message-ID: <7bbb6cce-3462-fbb2-9ae4-5c08ab2b01b4@redhat.com>
Date: Thu, 28 Sep 2017 11:05:24 -0400
MIME-Version: 1.0
In-Reply-To: <1506606369.7476.96.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 09/28/2017 09:46 AM, David Woodhouse wrote:
> On Thu, 2017-09-28 at 08:22 -0400, Don Dutile wrote:
>>
>> After reading Alex's response, I now understand Dave's question
>> better and why the patch won't work in general.
>
> UIO doesn't work "in general". It requires a very *specific* userspace
> driver for the hardware in question, which needs to know what it's
> doing.
>
>> In every SRIOV capable device I've run into to date, the PF has
>> to know the VFs are being assigned due to some resource mgmt, if not
>> internal (e.g., switch) configuration reasons.
>> The reasons are often subtle.
>
> Sure. If there's actually a userspace driver (which in my case there
> isn't), and if that's needed for the hardware ins question (which in my
> case it isn't), then it'd need to do that before enabling the VFs via
> the user-level sysfs interface of which you speak.
>
>>  From the context of the patches (uio), why aren't VFs enabled via
>> user-level sysfs interface? That was provided for user-mgmt apps
>> to have a PCIe-generic/common, device-independent method of VF
>> enablement
>
> That is *precisely* what we're doing. But the user-space sysfs
> interface doesn't actually *exist* unless a driver is bound to the
> device in question, with a .sriov-configure method. Which is where I
> came in... :)
>
ah, nickel summary: no in-kernel driver w/.sriov-configure method.
if so, now I'm up to speed with you....
hmmmm....
so, that would imply we need an in-kernel, pcie-common, .sriov-configure method
that's invoked if a driver isn't bound to a device? ... yes?
