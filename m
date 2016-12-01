Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752948AbcLASCL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 13:02:11 -0500
Date: Thu, 1 Dec 2016 12:01:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
Message-ID: <20161201180130.GD30746@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 02:29:22AM -0600, Bjorn Helgaas wrote:
> This is what I've collected on my pci/ecam branch so far.  This is
> preliminary and probably doesn't even build since I made several
> changes, but at least it's a strawman.  I called it v10 to keep it
> separate from the previous postings of the various pieces.

I don't want to spam the list with a zillion revisions, but I updated
the branch with the build and acpi_resource_consumer() fixes, thanks
to Dongdong, Tomasz, Rober, and Lorenzo.  Current head is:

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=f80edf4d6c05

If you test this, please mention the SHA1 you're testing and collect
the dmesg log and /proc/iomem contents.

I'll post the full set again soon, hopefully including the X-Gene
quirks.

Bjorn
