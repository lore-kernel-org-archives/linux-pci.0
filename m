Return-Path: <SRS0=o6Kt=A5=redhat.com=ddutile@kernel.org>
Return-Path: <SRS0=o6Kt=A5=redhat.com=ddutile@kernel.org>
Subject: Re: [PATCH] uio/uio_pci_generic: Add SR-IOV support
To: Alexander Duyck <alexander.duyck@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <1506517162.30379.2.camel@infradead.org>
 <20170927220005.GB23674@bhelgaas-glaptop.roam.corp.google.com>
 <1506550852.7476.33.camel@infradead.org>
 <CAKgT0UeAg01Yy189pyzo_wDGYOEX6mBgsr_M9Lsi3u0+a-cW2w@mail.gmail.com>
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
Message-ID: <bb77ab51-858b-df31-e672-7ccee964b269@redhat.com>
Date: Thu, 28 Sep 2017 08:22:16 -0400
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeAg01Yy189pyzo_wDGYOEX6mBgsr_M9Lsi3u0+a-cW2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 09/27/2017 07:06 PM, Alexander Duyck wrote:
> On Wed, Sep 27, 2017 at 3:20 PM, David Woodhouse <dwmw2@infradead.org> wrote:
>> On Wed, 2017-09-27 at 17:00 -0500, Bjorn Helgaas wrote:
>>>
>>>
>>> IIUC, this question is basically "why doesn't the PCI core enable IOV
>>> automatically when it sees an IOV-capable device?"
>>>
>>> I think one reason is that an admin might want to control the number
>>> of VFs we enable (e.g., via 1789382a72a5 ("PCI: SRIOV control and
>>> status via sysfs" [1]).  But I guess you already know about that,
>>> since this patch uses that sysfs path, so maybe I don't understand
>>> your question.
>>
>>
>> I mean, why doesn't the PCI core *allow* SR-IOV to be enabled via
>> sysfs, unless the driver does this?
>
> The general idea is that the driver usually has to free up resources
> so they can be reassigned to the VF devices.
>
> For example in the case of the Intel NICs enabling SR-IOV reassigns
> the queues to the VFs, and the PF has to be aware that this change is
> happening so that it doesn't try to make use of queues that then
> belong to the VFs.
>
> - Alex
>
After reading Alex's response, I now understand Dave's question
better and why the patch won't work in general.

In every SRIOV capable device I've run into to date, the PF has
to know the VFs are being assigned due to some resource mgmt, if not
internal (e.g., switch) configuration reasons.
The reasons are often subtle.

 From the context of the patches (uio), why aren't VFs enabled via
user-level sysfs interface? That was provided for user-mgmt apps
to have a PCIe-generic/common, device-independent method of VF enablement
(read: libvirt for device-assignment of VFs to VMs).
This also enables one to manage it at a finer, not-all-or-nothing level,
which is good due to bios strengths/weaknesses that various systems have
for SRIOV/VF-enablement.
