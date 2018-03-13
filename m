Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60131 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752864AbeCMQRi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 12:17:38 -0400
Subject: Re: [pci PATCH v5 3/4] ena: Migrate over to unmanaged SR-IOV support
To: David Woodhouse <dwmw2@infradead.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>, netanel@amazon.com,
        Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180312171813.3487.94803.stgit@localhost.localdomain>
 <20180312172309.3487.76690.stgit@localhost.localdomain>
 <1520928772.28745.53.camel@infradead.org>
 <CAKgT0UdkUSsHQC7CpJQ0CT77AD8k7P-HeeomWXNJQ-Ek4dJRMQ@mail.gmail.com>
 <1520953463.20126.15.camel@infradead.org>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <3d291517-fc7d-53ea-66b4-27137bdb14e5@redhat.com>
Date: Tue, 13 Mar 2018 12:17:34 -0400
MIME-Version: 1.0
In-Reply-To: <1520953463.20126.15.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/13/2018 11:04 AM, David Woodhouse wrote:
> On Tue, 2018-03-13 at 07:51 -0700, Alexander Duyck wrote:
> 
>> Actually the suggestion I had from Don Dutile was that we should be
>> looking at creating a pci-stub like driver specifically for those type
>> of devices, but without the ability to arbitrarily assign devices.
>> Basically we have to white-list it in one device at a time for those
>> kind of things.
> 
> It's still not clear what the point of that would be.
> 
A PF-stub to do device-assignment(-like) ops preserves the current security model,
and allows one to add pci-quirks at a device-level as well -- when the usual ACS
structs aren't properly added for a device, which happens quite frequently -- which
retains that common workaround as well.
Yet-another-method for VF assignment w/o even a simple PF driver stub
created multiple failure cases/configs when we were hashing the multiple options
a few weeks ago.
It's just simpler to implement a PF stub w/VF enablement ... b/c it's simple...

>> If you have the device ID of the thing you wanted to have work with
>> pci-stub before I could look at putting together a quick driver and
>> adding it to this set.
> 
> 1d0f:0053 would be an example.
> 
