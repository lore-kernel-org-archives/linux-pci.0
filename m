Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [REPLACEMENT PATCH] PCI: pciehp: Avoid slot access during reset
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci@vger.kernel.org
References: <9c58b565d0c1bac1fd6e16742caae7097348268e.1532752826.git.lukas@wunner.de>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <db5db1bc-7652-e668-786c-9910e8a02902@kernel.org>
Date: Sat, 28 Jul 2018 13:01:07 -0700
MIME-Version: 1.0
In-Reply-To: <9c58b565d0c1bac1fd6e16742caae7097348268e.1532752826.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 7/27/2018 10:18 PM, Lukas Wunner wrote:
> According to Sinan Kaya:
> 
>   "I know for a fact that bus reset clears the Data Link Layer Active bit
>    as soon as link goes down.  It gets set again following link up.
>    Presence detect depends on the HW implementation.  QDT root ports
>    don't change presence detect for instance since nobody actually
>    removed the card.  If an implementation supports in-band presence
>    detect, the answer is yes.  As soon as the link goes down, presence
>    detect bit will get cleared until recovery."
>    https://lkml.kernel.org/r/42e72f83-3b24-f7ef-e5bc-290fae99259a@codeaurora.org

You can put a reference to the table in the spec.

PCIe Specification 3.0
Table 4-14: Link Status Mapped to the LTSSM
Column: In-Band Presence.
