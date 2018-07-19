Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:37106 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbeGSQi4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jul 2018 12:38:56 -0400
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To: Sinan Kaya <okaya@kernel.org>, bhelgaas@google.com,
        keith.busch@intel.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <494a5df8-0987-3a6c-30a4-a3c9ef4ed1f3@kernel.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <37509c44-64fe-4140-c776-53c3346cbfe5@gmail.com>
Date: Thu, 19 Jul 2018 10:55:06 -0500
MIME-Version: 1.0
In-Reply-To: <494a5df8-0987-3a6c-30a4-a3c9ef4ed1f3@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 07/17/2018 10:41 AM, Sinan Kaya wrote:
> 
> On 7/17/2018 8:31 AM, Alexandru Gagniuc wrote:
>> +    if (pcie_aer_get_firmware_first(dev))
>> +        return -EIO;
> 
> Can you move this to closer to the caller pci_aer_init()?

I could move it there. although pci_cleanup_aer_error_status_regs() is 
called directly from pci_restore_state.  Of course, aer_cap should be 
zero in this case, and we'd still bail out.
I find the intent clearer if we check it here rather than having to do 
the mental parsing of the state of aer_cap.

Alex
