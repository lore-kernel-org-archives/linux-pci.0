Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732061AbeISWH5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 18:07:57 -0400
Subject: Re: [PATCH 11/12] PCI/AER: Use managed resource allocations
To: Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20180918235848.26694-12-keith.busch@intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <5b3f6bf5-2511-6a71-3410-a4f4ced4fb8c@kernel.org>
Date: Wed, 19 Sep 2018 12:29:15 -0400
MIME-Version: 1.0
In-Reply-To: <20180918235848.26694-12-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/18/2018 7:58 PM, Keith Busch wrote:
>   	if (status) {
>   		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
>   			   dev->irq);
> -		aer_remove(dev);
>   		return status;
>   	}
>   

Don't we still need to call aer_remove() here?

Old code would call aer_disable_rootport(rpc) via aer_remove() on IRQ allocation
failure. We are no longer doing this.
