Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:45804 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab3DVGQS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 02:16:18 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Mon, 22 Apr 2013 11:41:03 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0B2F71258051
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 11:47:46 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r3M6G4sS58065064
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 11:46:05 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r3M6G9YO031603
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:16:11 +1000
Message-ID: <5174D596.9070308@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 14:15:50 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
CC: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	tglx@linutronix.de
Subject: Re: [PATCH] PowerNV/PCI: Fix NULL PCI controller
References: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com>
In-Reply-To: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset=GB2312
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2013/4/22 14:13, Mike Qiu wrote:
Resend this patch because it has been send to kernel mailling list before :)
> In pnv_pci_read_config() or pnv_pci_write_config(), we never check if
> the PCI controller is valid before converting that into platform
> dependent one, this is very dangerous. 
>
> To avoid this potential risks, the patch check PCI controller first
> before use it.
>
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index b8b8e0b..e7b7f1a 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -286,11 +286,11 @@ static int pnv_pci_read_config(struct pci_bus *bus,
>  			       int where, int size, u32 *val)
>  {
>  	struct pci_controller *hose = pci_bus_to_host(bus);
> -	struct pnv_phb *phb = hose->private_data;
> +	struct pnv_phb *phb = hose ? hose->private_data : NULL;
>  	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
>  	s64 rc;
>
> -	if (hose == NULL)
> +	if (!phb)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>
>  	switch (size) {
> @@ -330,10 +330,10 @@ static int pnv_pci_write_config(struct pci_bus *bus,
>  				int where, int size, u32 val)
>  {
>  	struct pci_controller *hose = pci_bus_to_host(bus);
> -	struct pnv_phb *phb = hose->private_data;
> +	struct pnv_phb *phb = hose ? hose->private_data : NULL;
>  	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
>
> -	if (hose == NULL)
> +	if (!phb)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>
>  	cfg_dbg("pnv_pci_write_config bus: %x devfn: %x +%x/%x -> %08x\n",

