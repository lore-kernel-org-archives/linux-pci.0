Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33776 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeIDSvu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 14:51:50 -0400
Date: Tue, 4 Sep 2018 08:27:54 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 12/16] PCI/pciehp: Fix powerfault detection order
Message-ID: <20180904142753.GI9677@localhost.localdomain>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-13-keith.busch@intel.com>
 <20180901151836.oceptz267wy33bes@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180901151836.oceptz267wy33bes@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 01, 2018 at 05:18:36PM +0200, Lukas Wunner wrote:
> * In pcie_enable_notification() there's a code comment:
>   "TBD: Power fault detected software notification support"
>   Is there really anything left to be done or can this code comment be
>   deleted?  AFAICS, a power fault *is* detected and acted upon, then
>   has to be cleared by the user, either through enablement via sysfs
>   or by physically replacing the card.
> 
> * In pciehp_ist(), the if-condition to check for a power fault also
>   checks for "&& !ctrl->power_fault_detected".  The check seems
>   superfluous to me because pciehp_isr() clears the PCI_EXP_SLTSTA_PFD
>   bit in the pending events if ctrl->power_fault_detected is true.
>   Can the additional check be removed from the if-condition in
>   pciehp_ist()?

The slot is supposed to have PFD set while the controller detects a
power fault. The host acknowledging the event doesn't actually make the
power fault stop exisiting, so we have to make the observation sticky
until it goes away.
 
> * In pciehp_ist(), we call pciehp_green_led_off() if a power fault is
>   detected.  However my (limited) understanding is that a power fault
>   always results in a Link Down, and when bringing down the slot in
>   response to that, we already call pciehp_green_led_off() in
>   remove_board().  Can the call to pciehp_green_led_off() be removed
>   from pciehp_ist()?  Or does the link not necessarily go down on a
>   power fault and we should rather bring the slot down when a power
>   fault is detected?  Is that the "TBD" mentioned in the code comment?
>   Or is this just an intentional cosmetic behavior that we turn off
>   the green LED as early as possible once we detect the slot is off?
