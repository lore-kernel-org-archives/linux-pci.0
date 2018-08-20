Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40127 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTUq7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2018 16:46:59 -0400
Date: Mon, 20 Aug 2018 19:22:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] PCI: pciehp: Ignore link events when there is a
 fatal error pending
Message-ID: <20180820172213.tg4fle6ugi7lkhxx@wunner.de>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180820092238.kvktwlovc64oa66e@wunner.de>
 <c207adfb-ba3d-700b-2935-aab2fe171e6b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c207adfb-ba3d-700b-2935-aab2fe171e6b@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2018 at 12:59:05PM -0400, Sinan Kaya wrote:
> On 8/20/2018 5:22 AM, Lukas Wunner wrote:
> > > +
> > This differs from v7 of the patch in that*any*  fatal error, not just
> > a Surprise Link Down, results in pciehp waiting for the error to clear.
> > 
> > I'm wondering if that's safe:  Theoretically, the user might quickly
> > swap the card in the slot during, say, a Completion Timeout Error,
> > and with this patch pciehp would carry on as if nothing happened.
> 
> Functionally both patches are identical. The v7 was still allowing
> AER/DPC to handle all fatal error events except Surprise Link Down.
> 
> Now, second patch (v8 2/2) is masking the surprise link down event
> as we have talked before. Therefore, there is no need to filter
> out incoming errors by reading the status register and masking the
> unwanted bits.

Ok, missed that.


> Just to clarify something, this patch will wait for only the FATAL
> error events to be handled by the error handling services only.
> 
> Completion Timeout is a NONFATAL error event by default unless
> somebody tweaks the severity bits.
> 
> Anyhow, all FATAL errors cause one sort of link down either
> initiated by software (AER) or hardware (DPC).
> Therefore, hotplug driver will observe a link down event and
> AER/DPC needs to handle the event as usual.

Thanks for the clarification.

Lukas
