Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62329 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbdBXRUC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Feb 2017 12:20:02 -0500
Date: Fri, 24 Feb 2017 09:17:43 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        james puthukattukaran <james.puthukattukaran@oracle.com>,
        Yinghai Lu <yinghai.lu@oracle.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH] PCI, pciehp: Reuse set_slot_off()
Message-ID: <20170224171743.GA4964@otc-nc-03>
References: <20170224065435.14954-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170224065435.14954-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai

On Thu, Feb 23, 2017 at 10:54:35PM -0800, Yinghai Lu wrote:
> +++ linux-2.6/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -71,9 +71,6 @@ static void set_slot_off(struct controll
>  		 */
>  		msleep(1000);
>  	}
> -
> -	pciehp_green_led_off(pslot);
> -	pciehp_set_attention_status(pslot, 1);

Re using set_slot_off() in remove_board() make sense.. but i'm not sure
why these are pulled out? It seems to be functionally complete 
when these are done in set_slot_off(). 

>  }
>  
>  /**
> @@ -126,6 +123,8 @@ static int board_added(struct slot *p_sl
>  
>  err_exit:
>  	set_slot_off(ctrl, p_slot);
> +	pciehp_green_led_off(p_slot);
> +	pciehp_set_attention_status(p_slot, 1);
>  	return retval;
>  }
>  
> @@ -142,16 +141,7 @@ static int remove_board(struct slot *p_s
>  	if (retval)
>  		return retval;
>  
> -	if (POWER_CTRL(ctrl)) {
> -		pciehp_power_off_slot(p_slot);
> -
> -		/*
> -		 * After turning power off, we must wait for at least 1 second
> -		 * before taking any action that relies on power having been
> -		 * removed from the slot/adapter.
> -		 */
> -		msleep(1000);
> -	}
> +	set_slot_off(ctrl, p_slot);
>  
>  	/* turn off Green LED */
>  	pciehp_green_led_off(p_slot);
Don't we need the pciehp_set_attention_status() here?

Cheers,
Ashok
