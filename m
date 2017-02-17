Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:22597 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934101AbdBQSGp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Feb 2017 13:06:45 -0500
Date: Fri, 17 Feb 2017 09:40:09 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI,pciehp: Don't handle PDC for cards with attention
 button
Message-ID: <20170217174009.GA21480@otc-nc-03>
References: <20170217061247.5591-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217061247.5591-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai

Which version of linux did you apply this? 

I'm not sure if you can ignore PDC when ATTN isn't present. Surprise hot-add on
systems with Power Control would depend on PDC.

There is some new code to deal with both Presence detect and DLLSC events since
4.10-rc1. 


On Thu, Feb 16, 2017 at 10:12:47PM -0800, Yinghai Lu wrote:
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    5 +++--

> +		if (!ATTN_BUTTN(ctrl))
> +			pciehp_queue_interrupt_event(slot, present ?
> +					INT_PRESENCE_ON : INT_PRESENCE_OFF);
>  	}
>  
>  	/* Check Power Fault Detected */

This is what we have since v4.10-rc1

    /*
     * Check Link Status Changed at higher precedence than Presence
     * Detect Changed.  The PDS value may be set to "card present" from
     * out-of-band detection, which may be in conflict with a Link Down
     * and cause the wrong event to queue.
     */
    if (events & PCI_EXP_SLTSTA_DLLSC) {
        ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
              link ? "Up" : "Down");
        pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
                         INT_LINK_DOWN);
    } else if (events & PCI_EXP_SLTSTA_PDC) {
        present = !!(status & PCI_EXP_SLTSTA_PDS);
        ctrl_info(ctrl, "Slot(%s): Card %spresent\n", slot_name(slot),
              present ? "" : "not ");
        pciehp_queue_interrupt_event(slot, present ? INT_PRESENCE_ON :
                         INT_PRESENCE_OFF);
    }


Cheers
Ashok
