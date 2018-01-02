Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42909 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbeABRIs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jan 2018 12:08:48 -0500
Date: Tue, 2 Jan 2018 10:12:39 -0700
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 2/4] PCI/DPC/AER: Address Concurrency between AER and
 DPC
Message-ID: <20180102171238.GB24386@localhost.localdomain>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
 <1514532259-19383-3-git-send-email-poza@codeaurora.org>
 <20171229172324.GF16407@localhost.localdomain>
 <5e9ffecf-2da7-0014-9a62-e2ae10323ce3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5e9ffecf-2da7-0014-9a62-e2ae10323ce3@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 02, 2018 at 08:25:08AM -0500, Sinan Kaya wrote:
> > 2. A DPC event suppresses the error message required for the Linux
> > AER driver to run. How can AER and DPC run concurrently?
> > 
> 
> As we briefly discussed in previous email exchanges, I think you are
> looking at a use case with a switch that supports DPC functionality. 

No, I'm interested in DPC in a general.

> Oza and I are looking at a root port functionality with DPC feature. 
> 
> As you already know, AER errors are logged to AER capability register
> independent of the DPC driver presence.

The error is noted in the Uncorrectable Error Status Register if that's
what triggered the DPC event. This register has nothing to do with the
Root Error Status Register, which is required to have received an error
Message in order to have a status for the AER driver.

> A root port is also allowed to share the MSI interrupts across DPC and
> AER. 
> 
> Therefore, when a DPC interrupt fires; both AER driver and DPC driver
> starts recovery work. This is the issue we are trying to deal with. 

If DPC is implemented correctly, the AER Root Status can't have an
uncorrectable status for the driver to deal with. The only thing the AER
driver could possibly see is a correctable error if DPC ERR_COR Enable
is set.

> In the end, the driver needs to work for both root port and switches.
> I think you verified it against a switch. We are doing the same for a
> root port and submitting the plumbing code. 

I think we need to consider the possibility you are enabling a platform
that implemented DPC incorrectly. There's nothing in the specification
that says that DPC enabled root ports are not to discard the error message
if it came from downstream, or skip signalling the message for root port
detected errors.
