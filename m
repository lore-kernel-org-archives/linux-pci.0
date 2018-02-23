Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeBWF1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 00:27:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 23 Feb 2018 10:57:53 +0530
From: poza@codeaurora.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v10 3/7] PCI/ERR: add mutex to synchronize recovery
In-Reply-To: <20180222183602.GC6267@infradead.org>
References: <1519315332-26852-1-git-send-email-poza@codeaurora.org>
 <1519315332-26852-4-git-send-email-poza@codeaurora.org>
 <20180222183602.GC6267@infradead.org>
Message-ID: <2f79e5c643858e13f5ac9d6aef6e536c@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-02-23 00:06, Christoph Hellwig wrote:
> On Thu, Feb 22, 2018 at 09:32:08PM +0530, Oza Pawandeep wrote:
>> This patch protects pci_do_recovery with mutex.
> 
> Do we really want a global mutex for this and not one per root complex
> at very least?

This protects pcie_do_recovery, which is called by port service drivers.
mainly aer and dpc as of now. so the association is not root complex 
agents
instead service drivers who attempts to do link recovery.

so I think we are good here.
