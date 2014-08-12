Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog126.obsmtp.com ([207.126.144.174]:51624 "EHLO
	eu1sys200aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752248AbaHLMAY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 08:00:24 -0400
Message-ID: <53EA01B5.5020900@mellanox.com>
Date: Tue, 12 Aug 2014 14:59:49 +0300
From: Amir Vadai <amirv@mellanox.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, <linux-pci@vger.kernel.org>
CC: <alex.williamson@redhat.com>, <eli@mellanox.com>,
	<weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] PCI: Mark broken INTx masking for Mellanox devices
References: <1407844091-20815-1-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1407844091-20815-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/12/2014 2:48 PM, Gavin Shan wrote:
> The VFIO driver is routing LSI interrupts by capturing, masking,
> and then delivering. When passing though Mellanox adapters from
> host to guest, interrupt storm was reported from host and guest.
> That's because we can't mask the LSI interrupt with help of PCI
> command register.
> 
>  # lspci | grep Mellanox
>  0001:05:00.0 Ethernet controller: Mellanox Technologies MT27500 \
>               Family [ConnectX-3]
>  0005:01:00.0 Ethernet controller: Mellanox Technologies MT26448 \
>               [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)
> 
> It's confirmed by Amir Vadai that all Mellanox devices have same
> problem. The patch marks broken INTx masking for all Mellanox
> adapters.
> 
> Cc: Amir Vadai <amirv@mellanox.com>
> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> v3: Mark broken INTx masking for all Mellanox adapters
> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-By: Amir Vadai <amirv@mellanox.com>

