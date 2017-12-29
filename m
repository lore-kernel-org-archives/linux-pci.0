Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29280 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbdL2RTm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Dec 2017 12:19:42 -0500
Date: Fri, 29 Dec 2017 10:23:24 -0700
From: Keith Busch <keith.busch@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 2/4] PCI/DPC/AER: Address Concurrency between AER and
 DPC
Message-ID: <20171229172324.GF16407@localhost.localdomain>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
 <1514532259-19383-3-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1514532259-19383-3-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 29, 2017 at 12:54:17PM +0530, Oza Pawandeep wrote:
> This patch addresses the race condition between AER and DPC for recovery.
> 
> Current DPC driver does not do recovery, e.g. calling end-point's driver's
> callbacks, which sanitize the device.
> DPC driver implements link_reset callback, and calls pci_do_recovery.

I'm not sure I see why any of this is necessary for two reasons:

1. A downstream port containment event disables the link. How can a driver
sanitize an end device when all the end devices below the containment are
physically inaccessible? Any attempt to access such devices will just
end with either CA or UR (depending on DPC control settings). Since we
already know the failed outcome from attempting to access such devices,
why do you want the drivers to do anything?

2. A DPC event suppresses the error message required for the Linux
AER driver to run. How can AER and DPC run concurrently?
