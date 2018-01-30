Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752546AbeA3Sau (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:30:50 -0500
Date: Tue, 30 Jan 2018 12:30:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Oza Pawandeep <oza.pawandeep@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI/DPC: Leave interrupts enabled while handling
 event
Message-ID: <20180130183046.GG232763@bhelgaas-glaptop.roam.corp.google.com>
References: <20180129213145.26068-1-keith.busch@intel.com>
 <20180129213145.26068-2-keith.busch@intel.com>
 <56d77093-b630-148d-52ab-14dcb7714e6b@codeaurora.org>
 <CAK1A=4w-uDm+gau6WdwM=ZrgO=bWDtDKqwabxWxm2EZZb+YoKw@mail.gmail.com>
 <f0afb7badc99dcfc3b6818cc2356250d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f0afb7badc99dcfc3b6818cc2356250d@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 30, 2018 at 12:04:44PM +0530, poza@codeaurora.org wrote:
> Bjorn: Can you please help to review my AER/DPC series of patches so
> that I do not have to keep rebasing and do manual merge ?

They're in the queue and I'll get to them this cycle.

You don't need to rebase them unless you change your patches to
actually require something from another branch.  If there are
conflicts with other patches that are in-flight, I'll resolve those
myself.

Since your patches will probably land in the v4.17 merge, it *will* be
nice if you rebase them when I update the pci/master branch, which
will probably be to v4.16-rc1.  But unless you *depend* on features in
another branch, it's easiest if you base them on pci/master, which
generally stays the same throughout the cycle.

Bjorn
