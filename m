Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:55613 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeGSUks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jul 2018 16:40:48 -0400
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To: Sinan Kaya <okaya@kernel.org>, bhelgaas@google.com,
        keith.busch@intel.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <494a5df8-0987-3a6c-30a4-a3c9ef4ed1f3@kernel.org>
 <37509c44-64fe-4140-c776-53c3346cbfe5@gmail.com>
 <da6335db-1e6b-c19b-4bbd-0f5523484e0e@kernel.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <61c8a5d7-d520-e927-071a-bf5620bc0f4e@gmail.com>
Date: Thu, 19 Jul 2018 14:56:06 -0500
MIME-Version: 1.0
In-Reply-To: <da6335db-1e6b-c19b-4bbd-0f5523484e0e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 07/19/2018 11:58 AM, Sinan Kaya wrote:
> 
> On 7/19/2018 8:55 AM, Alex G. wrote:
>> I find the intent clearer if we check it here rather than having to do 
>> the mental parsing of the state of aer_cap.
> 
> I don't feel too strong about my comment to be honest. This was a
> style/maintenance comment.
> 
> It feels like we are putting pcie_aer_get_firmware_first() into core
> functions unnecessarily after your change. I understand the need for
> your change. I'm asking if it is the right place or not.
> 
> pcie_aer_get_firmware_first() should be called from either the init or
> probe function so that the rest of the AER functions do not get called
> from any other context.
> 
> If someone adds another AER function, we might need to add another
> pcie_aer_get_firmware_first() check there. So, we have unnecessary code
> duplication.

We could move the aer_cap and get_ffs() check into one function that we 
end up calling all over the place. I understand your concern about code 
duplication, and I agree with it. I don't think that at this point it's 
that big of a deal, although we might need to guard every aer_() call.

So moving all the checks in a pcie_aer_is_kernel_first() makes sense.

Alex
