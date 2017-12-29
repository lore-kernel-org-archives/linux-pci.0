Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:24375 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbdL2SJ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Dec 2017 13:09:58 -0500
Date: Fri, 29 Dec 2017 11:13:41 -0700
From: Keith Busch <keith.busch@intel.com>
To: poza@codeaurora.org
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
Message-ID: <20171229181340.GG16407@localhost.localdomain>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
 <1514532259-19383-3-git-send-email-poza@codeaurora.org>
 <20171229172324.GF16407@localhost.localdomain>
 <481784bb38707839493fc04e6a2b4068@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <481784bb38707839493fc04e6a2b4068@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 29, 2017 at 11:30:02PM +0530, poza@codeaurora.org wrote:
> On 2017-12-29 22:53, Keith Busch wrote:
> 
> > 2. A DPC event suppresses the error message required for the Linux
> > AER driver to run. How can AER and DPC run concurrently?
> 
> I afraid I could not grasp the first line completely.

A DPC capable and enabled port discards error messages; the ERR_FATAL
or ERR_NONFATAL message required to trigger AER handling won't exist in
such a setup.

This behavior is defined in the specification 6.2.10 for Downstream
Port Containment:

  When DPC is triggered due to receipt of an uncorrectable error Message,
  the Requester ID from the Message is recorded in the DPC Error
  Source ID register and that Message is discarded and not forwarded
  Upstream. When DPC is triggered by an unmasked uncorrectable error,
  that error will not be signaled with an uncorrectable error Message,
  even if otherwise enabled.
