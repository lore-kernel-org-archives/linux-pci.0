Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54524 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755232AbeDYPtl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2018 11:49:41 -0400
Subject: Re: [PATCH 1/2] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20180318105253.30532-1-marek.vasut+renesas@gmail.com>
 <20180425141329.GA20923@e107981-ln.cambridge.arm.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <2b9d300b-09d7-d2ad-a22d-4f532276ae4c@gmail.com>
Date: Wed, 25 Apr 2018 17:49:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180425141329.GA20923@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/25/2018 04:13 PM, Lorenzo Pieralisi wrote:
> Hi Marek,
> 
> On Sun, Mar 18, 2018 at 11:52:52AM +0100, Marek Vasut wrote:
>> The data link active signal usually takes ~20 uSec to be asserted,
>> poll the bit more often to avoid useless delays in this function.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>>  drivers/pci/host/pcie-rcar.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> I assume this patch is still a valid change, I noticed you split this
> series but I think this patch was not updated so I should take it as-is.
> 
> Please let me know.

The discussion from a month ago would indicate that I need to resubmit it.

-- 
Best regards,
Marek Vasut
