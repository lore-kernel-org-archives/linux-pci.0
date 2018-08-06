Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733247AbeHFSoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 14:44:18 -0400
Subject: Re: [PATCH v7 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
To: poza@codeaurora.org
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-pci-owner@vger.kernel.org
References: <20180805225136.5800-1-okaya@kernel.org>
 <20180805225136.5800-2-okaya@kernel.org>
 <c1cfff22c63f6d3d6285575721a2a3e8@codeaurora.org>
 <20180806092614.GA28462@wunner.de>
 <2b4c23a2e97f61a124c95c49d604a853@codeaurora.org>
 <3d491f25-1d59-f257-1125-302e2d50e960@kernel.org>
 <22ce7172-b028-c0b1-d117-8096e016b15b@kernel.org>
 <16b40dfd99c37c67e3d103f6fb7738ef@codeaurora.org>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <1ee81bca-3b64-3977-4a89-5ff924fe117d@kernel.org>
Date: Mon, 6 Aug 2018 12:34:23 -0400
MIME-Version: 1.0
In-Reply-To: <16b40dfd99c37c67e3d103f6fb7738ef@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/6/2018 11:12 AM, poza@codeaurora.org wrote:
>>> That's true. We either need to go poll every single source (AER/DPC) for
>>> an error or rely on the DEVSTA. For ease of implementation, I suggest
>>> DEVSTA. Something like this:
>>
>> Hmm. Too quick...
>>
>> Reduced set doesn't help. Surprise Link Down is also a fatal error.
>> That's what I was trying to exclude. We'll have to poll the error
>> source.
> 
> 
> How about using pcie_port_find_service() ?

pcie_port_find_service() tells you that there is an active driver. We
could potentially use it like follows to query the register themselves.

if ((pcie_port_find_service(AER)) {
	check AER registers
}

if ((pcie_port_find_service(DPC)) {
	check DPC registers
}
