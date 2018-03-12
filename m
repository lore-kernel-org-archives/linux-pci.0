Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:39252 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932425AbeCLQB4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2018 12:01:56 -0400
MIME-Version: 1.0
In-Reply-To: <20180312075907.GA5342@lst.de>
References: <20180308185507.5433.98830.stgit@localhost.localdomain>
 <20180308190047.5433.77952.stgit@localhost.localdomain> <20180311215909.16ed4bf1@t450s.home>
 <20180312075907.GA5342@lst.de>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 12 Mar 2018 09:01:54 -0700
Message-ID: <CAKgT0UcJz7go-vRd88M6uo1mqbG9BfedkZmR0CXZ92m6KfRPzw@mail.gmail.com>
Subject: Re: [pci PATCH v4 1/4] pci-iov: Add support for unmanaged SR-IOV
To: Christoph Hellwig <hch@lst.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        netanel@amazon.com, Maximilian Heyne <mheyne@amazon.de>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        David Woodhouse <dwmw2@infradead.org>, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 12, 2018 at 12:59 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Sun, Mar 11, 2018 at 09:59:09PM -0600, Alex Williamson wrote:
>> I still struggle to understand why we need this "unmanaged"
>> complication and how a user of the sysfs API is expected to have any
>> idea whether a PF is managed or unmanaged and why they should care.
>> Can't we just have a pci_simple_sriov_configure() helper and ignore
>> this unmanaged business?  Thanks,
>
> Just a pci_simple_sriov_configure is exactly what I envisioned originally.

I can drop the "unmanaged" bits if that is what is wanted, but based
on previous conversations I thought there was some concern about the
kernel loading VFs when there was some foreign entity managing the VFs
other than the kernel.

Thanks.

- Alex
