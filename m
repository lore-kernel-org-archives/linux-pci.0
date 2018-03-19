Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35468 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754923AbeCSKCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 06:02:36 -0400
Subject: Re: [PATCH 1/2] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
To: Simon Horman <horms@verge.net.au>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20180318105253.30532-1-marek.vasut+renesas@gmail.com>
 <20180319083839.h3qdt4obbsbqlx73@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b7dad289-c9de-ae19-a0d2-3eb127e0955a@gmail.com>
Date: Mon, 19 Mar 2018 10:53:45 +0100
MIME-Version: 1.0
In-Reply-To: <20180319083839.h3qdt4obbsbqlx73@verge.net.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/19/2018 09:38 AM, Simon Horman wrote:
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
> 
> Unless my eyes deceive me this seems to be quite a lot (100x) more often,
> but so be it.

It's just a higher frequency to avoid slowdown when bringing the link up.

> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
> 
>> ---
>>  drivers/pci/host/pcie-rcar.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>> index 93d59f15c589..099998f1923a 100644
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -528,13 +528,13 @@ static void phy_write_reg(struct rcar_pcie *pcie,
>>  
>>  static int rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
>>  {
>> -	unsigned int timeout = 10;
>> +	unsigned int timeout = 10000;
>>  
>>  	while (timeout--) {
>>  		if ((rcar_pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
>>  			return 0;
>>  
>> -		msleep(5);
>> +		udelay(5);
>>  	}
>>  
>>  	return -ETIMEDOUT;
>> -- 
>> 2.16.2
>>


-- 
Best regards,
Marek Vasut
