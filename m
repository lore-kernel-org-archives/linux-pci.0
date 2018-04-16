Return-Path: <SRS0=yohJ=HF=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=yohJ=HF=davemloft.net=davem@kernel.org>
Date: Mon, 16 Apr 2018 18:06:22 -0400 (EDT)
Message-Id: <20180416.180622.47531730658466358.davem@davemloft.net>
To: helgaas@kernel.org
Cc: hkallweit1@gmail.com, bhelgaas@google.com, nic_swsd@realtek.com,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] PCI: Add two more values for PCIe
 Max_Read_Request_Size
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180416214204.GD28657@bhelgaas-glaptop.roam.corp.google.com>
References: <00f1255f-acf0-4760-c20f-0b78bda44645@gmail.com>
	<ab8696d7-59e0-1f24-0ead-757057eb50cf@gmail.com>
	<20180416214204.GD28657@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 16 Apr 2018 16:42:04 -0500

> On Mon, Apr 16, 2018 at 09:37:13PM +0200, Heiner Kallweit wrote:
>> This patch adds missing values for the max read request size.
>> E.g. network driver r8169 uses a value of 4K.
>> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> I'd prefer a subject line with more details, e.g.,
> 
>   PCI: Add #defines for 2K and 4K Max Read Request Size
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I suspect conflicts are more likely in r8169.c so it might make more
> sense to route these through the netdev tree.  I'd also be happy to
> take them, so let me know if you want me to take them, David.

I'll take them into net-next, thanks Bjorn.
