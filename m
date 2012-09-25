Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64038 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781Ab2IYJUN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 05:20:13 -0400
Message-ID: <1348564801.10028.1.camel@localhost.localdomain>
Subject: Re: [PATCH 15/29] PCI, edac: kill pci_find_next_bus in edac
From: Mauro Carvalho Chehab <mchehab@redhat.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	Doug Thompson <dougthompson@xmission.com>,
	linux-edac@vger.kernel.org
Date: Tue, 25 Sep 2012 06:20:01 -0300
In-Reply-To: <1348561590-28067-16-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
	 <1348561590-28067-16-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Ter, 2012-09-25 às 01:26 -0700, Yinghai Lu escreveu:
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>

Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

> Cc: Doug Thompson <dougthompson@xmission.com>
> Cc: linux-edac@vger.kernel.org
> ---
>  drivers/edac/i7core_edac.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
> index 3672101..ae4c484 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -1294,10 +1294,10 @@ static void __init i7core_xeon_pci_fixup(const struct pci_id_table *table)
>  static unsigned i7core_pci_lastbus(void)
>  {
>  	int last_bus = 0, bus;
> -	struct pci_bus *b = NULL;
> +	struct pci_host_bridge *host_bridge = NULL;
>  
> -	while ((b = pci_find_next_bus(b)) != NULL) {
> -		bus = b->number;
> +	for_each_pci_host_bridge(host_bridge) {
> +		bus = host_bridge->bus->number;
>  		edac_dbg(0, "Found bus %d\n", bus);
>  		if (bus > last_bus)
>  			last_bus = bus;

