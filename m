Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbeGSRm1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jul 2018 13:42:27 -0400
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To: "Alex G." <mr.nuke.me@gmail.com>, bhelgaas@google.com,
        keith.busch@intel.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <494a5df8-0987-3a6c-30a4-a3c9ef4ed1f3@kernel.org>
 <37509c44-64fe-4140-c776-53c3346cbfe5@gmail.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <da6335db-1e6b-c19b-4bbd-0f5523484e0e@kernel.org>
Date: Thu, 19 Jul 2018 09:58:24 -0700
MIME-Version: 1.0
In-Reply-To: <37509c44-64fe-4140-c776-53c3346cbfe5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 7/19/2018 8:55 AM, Alex G. wrote:
> I find the intent clearer if we check it here rather than having to do 
> the mental parsing of the state of aer_cap.

I don't feel too strong about my comment to be honest. This was a
style/maintenance comment.

It feels like we are putting pcie_aer_get_firmware_first() into core
functions unnecessarily after your change. I understand the need for
your change. I'm asking if it is the right place or not.

pcie_aer_get_firmware_first() should be called from either the init or
probe function so that the rest of the AER functions do not get called
from any other context.

If someone adds another AER function, we might need to add another
pcie_aer_get_firmware_first() check there. So, we have unnecessary code
duplication.
