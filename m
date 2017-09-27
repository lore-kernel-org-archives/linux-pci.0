Return-Path: <SRS0=ALZW=A4=gmail.com=alexander.duyck@kernel.org>
Return-Path: <SRS0=ALZW=A4=gmail.com=alexander.duyck@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1506550852.7476.33.camel@infradead.org>
References: <1506517162.30379.2.camel@infradead.org> <20170927220005.GB23674@bhelgaas-glaptop.roam.corp.google.com>
 <1506550852.7476.33.camel@infradead.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 27 Sep 2017 16:06:59 -0700
Message-ID: <CAKgT0UeAg01Yy189pyzo_wDGYOEX6mBgsr_M9Lsi3u0+a-cW2w@mail.gmail.com>
Subject: Re: [PATCH] uio/uio_pci_generic: Add SR-IOV support
To: David Woodhouse <dwmw2@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci <linux-pci@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	Donald Dutile <ddutile@redhat.com>, Alexander Duyck <alexander.h.duyck@intel.com>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, Bodong Wang <bodong@mellanox.com>,
	Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 27, 2017 at 3:20 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2017-09-27 at 17:00 -0500, Bjorn Helgaas wrote:
>>
>>
>> IIUC, this question is basically "why doesn't the PCI core enable IOV
>> automatically when it sees an IOV-capable device?"
>>
>> I think one reason is that an admin might want to control the number
>> of VFs we enable (e.g., via 1789382a72a5 ("PCI: SRIOV control and
>> status via sysfs" [1]).  But I guess you already know about that,
>> since this patch uses that sysfs path, so maybe I don't understand
>> your question.
>
>
> I mean, why doesn't the PCI core *allow* SR-IOV to be enabled via
> sysfs, unless the driver does this?

The general idea is that the driver usually has to free up resources
so they can be reassigned to the VF devices.

For example in the case of the Intel NICs enabling SR-IOV reassigns
the queues to the VFs, and the PF has to be aware that this change is
happening so that it doesn't try to make use of queues that then
belong to the VFs.

- Alex
