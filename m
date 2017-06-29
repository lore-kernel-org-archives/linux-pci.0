Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:52532 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbdF2WO7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jun 2017 18:14:59 -0400
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-7-logang@deltatee.com>
 <000301d2f103$3310ca60$99325f20$@dell.com>
 <079047c1-6612-2814-e147-844fabd56b75@deltatee.com>
 <000401d2f114$3499f2b0$9dcdd810$@dell.com>
 <63c4b0fa-2f03-6313-2d60-c6dab53bc3a5@deltatee.com>
 <000501d2f11f$af340d70$0d9c2850$@dell.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        'Serge Semin' <fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <470752c9-53f5-aa21-96c5-3fdc9b3d9e7c@deltatee.com>
Date: Thu, 29 Jun 2017 16:14:51 -0600
MIME-Version: 1.0
In-Reply-To: <000501d2f11f$af340d70$0d9c2850$@dell.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 06/16] ntb: add check and comment for link up to mw_count
 and mw_get_align
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29/06/17 03:35 PM, Allen Hubbe wrote:
>> It is not a workaround for alignment restrictions of the mws.  It is a restriction to avoid the use of
>> doorbells and scratchpads.  Memory windows are used exclusively.
>>
>> Read msi-x local <addr,data> and send that to the peer:
> 
> https://github.com/ntrdma/ntrdma/blob/master/drivers/ntc/ntc_ntb_msi.c#L583
> 
>> Transform peer's addr to the memory window region:
> 
> https://github.com/ntrdma/ntrdma/blob/master/drivers/ntc/ntc_ntb_msi.c#L603
> 
>> Append a dma immediate value operation after other operations, to write the data at addr:
> 
> https://github.com/ntrdma/ntrdma/blob/master/drivers/ntc/ntc_ntb_msi.c#L1195


Ok, I'm a little bit confused at the links you are pointing me to. The
patch you nak'd only makes changes to ntb_mw_get_align and ntb_mw_count:

1) ntb_mw_get_align gets the last two parameters of what was formerly
ntb_mw_get_range. However, the only two uses of get_range I can find in
the ntrdma code set those two parameters to NULL and thus would not use
ntb_mw_get_align.

2) ntb_mw_count is technically a new function (ntb_peer_mw_count is
equivalent to the old function of that name). However, the one place in
ntrdma where it would be called is during de-initialization. So if the
link goes down before deinit, the client will not correctly clean up all
the memory windows.

So, it seems to me that ntb_mw_get_align is fine the way I have it but
we should probably change ntb_mw_count: I'll get rid of the check for
link in that function and then have the switchtec driver locally cache
the peer's memory windows whenever the link goes up. So if the link is
down it will return the number of mws the last time the link was seen.
(And if the link was never seen it will return 0).

Thoughts?

Logan
