Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45837 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbeCLQ2i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Mar 2018 12:28:38 -0400
Date: Mon, 12 Mar 2018 10:28:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [pci PATCH v4 1/4] pci-iov: Add support for unmanaged SR-IOV
Message-ID: <20180312102836.6db05ef8@w520.home>
In-Reply-To: <CAKgT0UcJz7go-vRd88M6uo1mqbG9BfedkZmR0CXZ92m6KfRPzw@mail.gmail.com>
References: <20180308185507.5433.98830.stgit@localhost.localdomain>
        <20180308190047.5433.77952.stgit@localhost.localdomain>
        <20180311215909.16ed4bf1@t450s.home>
        <20180312075907.GA5342@lst.de>
        <CAKgT0UcJz7go-vRd88M6uo1mqbG9BfedkZmR0CXZ92m6KfRPzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 12 Mar 2018 09:01:54 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> On Mon, Mar 12, 2018 at 12:59 AM, Christoph Hellwig <hch@lst.de> wrote:
> > On Sun, Mar 11, 2018 at 09:59:09PM -0600, Alex Williamson wrote:  
> >> I still struggle to understand why we need this "unmanaged"
> >> complication and how a user of the sysfs API is expected to have any
> >> idea whether a PF is managed or unmanaged and why they should care.
> >> Can't we just have a pci_simple_sriov_configure() helper and ignore
> >> this unmanaged business?  Thanks,  
> >
> > Just a pci_simple_sriov_configure is exactly what I envisioned originally.  
> 
> I can drop the "unmanaged" bits if that is what is wanted, but based
> on previous conversations I thought there was some concern about the
> kernel loading VFs when there was some foreign entity managing the VFs
> other than the kernel.

My concern has always been whether the PF driver is trusted and by
dropping the vfio bits, the remaining drivers here are native, trusted,
host drivers, so I don't see that we have any reason to consider the
VFs as anything other than trusted as well.  It's VFs where the PF
driver is untrusted, such as a userspace driver, which needs some kind
of quarantine, imo.  Thanks,

Alex
