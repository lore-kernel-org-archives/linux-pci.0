Return-Path: <SRS0=V0U7=BB=redhat.com=ddutile@kernel.org>
Return-Path: <SRS0=V0U7=BB=redhat.com=ddutile@kernel.org>
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
 <3ddc65bd-bf47-acb8-4cc5-db2531e1e864@redhat.com>
 <1506947750.18322.7.camel@infradead.org>
 <5c744ed0-2937-4460-fb8a-6e92fe5bfffa@redhat.com>
 <1506971418.18322.47.camel@infradead.org>
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
Message-ID: <01545a87-f121-299f-9e7e-48fe17378ff1@redhat.com>
Date: Mon, 2 Oct 2017 18:02:55 -0400
MIME-Version: 1.0
In-Reply-To: <1506971418.18322.47.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 10/02/2017 03:10 PM, David Woodhouse wrote:
> On Mon, 2017-10-02 at 14:52 -0400, Don Dutile wrote:
>> On 10/02/2017 08:35 AM, David Woodhouse wrote:
>>> This would allow you to enable SR-IOV on a PF before its driver is
>>> loaded, right? Even when that driver *is* going to need to perform
>>> resource management for those VFs?
>>>
>>> Would existing drivers cope with SR-IOV being enabled, and VFs being
>>> assigned to guests, before they're loaded? If so then sure, let's do it
>>> generically. But I'm not sure that's the case.
>>>
>> No better than a uio driver/mgmt api that may have to configure a PF
>> before a VF is enabled.
>
> Conceptually, the current model is that you don't have SR-IOV until you
> have a driver loaded for the physical function which can do any
> necessary resource management.
>
> That's *why* the generic "sriov_numvfs" interface in sysfs isn't
> present until such a driver is loaded.
>
> In the UIO case, *userspace* is responsible for the PF. So it's not an
> "attack vector"; we let userspace do what it likes with the PF and that
> includes enabling SR-IOV too.
>
> Do we actually *disable* SR-IOV when a (UIO or in-kernel) driver for
> the PF is unloaded? If not, that's the only "attack vector" I see — to
> load a driver which permits SR-IOV to be enabled, and do so, and then
> unload it and load a different driver which doesn't cope.
>
> And each driver in that scenario can be either an in-kernel driver or
> UIO+userspace; it doesn't matter either way. The patch I sent is just
> following the *existing* model.
>
> But sure, my question was intended to ask whether we want to *stick*
> with that model. Given the answers I got, my own conclusion was that we
> probably do...
>
ok. got the whole picture now.
+1 to your reply.
