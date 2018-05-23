Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35544 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933767AbeEWRRs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 13:17:48 -0400
Subject: Re: [PATCH 1/4] PCI: rcar: Rename
 rcar_pcie_parse_request_of_pci_ranges()
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
 <20180523161711.GA8113@e107981-ln.cambridge.arm.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <5fc7b4ff-1c75-4d3f-6cb7-fda4559a3635@gmail.com>
Date: Wed, 23 May 2018 19:05:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180523161711.GA8113@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/23/2018 06:17 PM, Lorenzo Pieralisi wrote:
> On Mon, May 21, 2018 at 03:11:20PM +0200, Marek Vasut wrote:
>> The function name is just too confusing, rename it, no functional change.
>> Rename the function to rcar_pcie_alloc_and_parse_pci_resource_list() as
>> it's matching failpath function is pci_free_resource_list() so the names
>> align much better and the new name also describes what the function does
>> much better.
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
> Can you rebase this series against my pci/rcar branch please ?
> 
> I will merge it then, thanks.

Where is that tree/branch located ?

It applies fine on current next 20180517, is there a problem ?

-- 
Best regards,
Marek Vasut
