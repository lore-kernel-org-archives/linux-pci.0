Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:58427 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933659AbcFQKcR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 06:32:17 -0400
In-Reply-To: <1463726502-14679-18-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: aik@ozlabs.ru, linux-pci@vger.kernel.org,
	Gavin Shan <gwshan@linux.vnet.ibm.com>, alistair@popple.id.au
Subject: Re: [v10,17/18] powerpc/powernv: Functions to get/set PCI slot state
Message-Id: <3rWGlZ2Qs5z9t0v@ozlabs.org>
Date: Fri, 17 Jun 2016 20:32:10 +1000 (AEST)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2016-20-05 at 06:41:41 UTC, Gavin Shan wrote:
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 9bb8ddf..2417c86 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -344,6 +348,18 @@ enum OpalPciResetState {
>  	OPAL_ASSERT_RESET   = 1
>  };
>  
> +enum OpalPciSlotPresentenceState {

In skiboot this is called "OpalPciSlotPresence".

I've renamed it.

> +	OPAL_PCI_SLOT_EMPTY	= 0,
> +	OPAL_PCI_SLOT_PRESENT	= 1
> +};
> +
> +enum OpalPciSlotPowerState {

In skiboot this is called "OpalPciSlotPower".

I've renamed it.

> +	OPAL_PCI_SLOT_POWER_OFF	= 0,
> +	OPAL_PCI_SLOT_POWER_ON	= 1,
> +	OPAL_PCI_SLOT_OFFLINE	= 2,
> +	OPAL_PCI_SLOT_ONLINE	= 3
> +};
> +
>  enum OpalSlotLedType {
>  	OPAL_SLOT_LED_TYPE_ID = 0,	/* IDENTIFY LED */
>  	OPAL_SLOT_LED_TYPE_FAULT = 1,	/* FAULT LED */
> @@ -378,6 +394,7 @@ enum opal_msg_type {
>  	OPAL_MSG_DPO		= 5,
>  	OPAL_MSG_PRD		= 6,
>  	OPAL_MSG_OCC		= 7,
> +	OPAL_MSG_PCI_HOTPLUG	= 8,

I don't see this in skiboot?

It also doesn't seem to be used, so I've dropped it.

>  	OPAL_MSG_TYPE_MAX,
>  };
>  

cheers
