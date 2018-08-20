Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] PCI: pciehp: Ignore link events when there is a
 fatal error pending
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180820092238.kvktwlovc64oa66e@wunner.de>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <c207adfb-ba3d-700b-2935-aab2fe171e6b@kernel.org>
Date: Mon, 20 Aug 2018 12:59:05 -0400
MIME-Version: 1.0
In-Reply-To: <20180820092238.kvktwlovc64oa66e@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/20/2018 5:22 AM, Lukas Wunner wrote:
>> +
> This differs from v7 of the patch in that*any*  fatal error, not just
> a Surprise Link Down, results in pciehp waiting for the error to clear.
> 
> I'm wondering if that's safe:  Theoretically, the user might quickly
> swap the card in the slot during, say, a Completion Timeout Error,
> and with this patch pciehp would carry on as if nothing happened.

Functionally both patches are identical. The v7 was still allowing
AER/DPC to handle all fatal error events except Surprise Link Down.

Now, second patch (v8 2/2) is masking the surprise link down event
as we have talked before. Therefore, there is no need to filter
out incoming errors by reading the status register and masking the
unwanted bits.

Just to clarify something, this patch will wait for only the FATAL
error events to be handled by the error handling services only.

Completion Timeout is a NONFATAL error event by default unless
somebody tweaks the severity bits.

Anyhow, all FATAL errors cause one sort of link down either
initiated by software (AER) or hardware (DPC).
Therefore, hotplug driver will observe a link down event and
AER/DPC needs to handle the event as usual.
