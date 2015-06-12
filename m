Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34804 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbbFLWZ7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2015 18:25:59 -0400
Received: by pdbki1 with SMTP id ki1so31907713pdb.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2015 15:25:58 -0700 (PDT)
Message-ID: <557B5C75.7040905@boundarydevices.com>
Date: Fri, 12 Jun 2015 15:25:57 -0700
From: Troy Kisky <troy.kisky@boundarydevices.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: festevam@gmail.com, marex@denx.de, linux-pci@vger.kernel.org,
	r65037@freescale.com, l.stach@pengutronix.de, tharvey@gateworks.com
Subject: Re: [PATCH 1/1] pci-imx6: add speed change timeout message
References: <1433543864-7252-1-git-send-email-troy.kisky@boundarydevices.com> <20150612202008.GI23119@google.com>
In-Reply-To: <20150612202008.GI23119@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/12/2015 1:20 PM, Bjorn Helgaas wrote:
> Hi Troy,
> 
> On Fri, Jun 05, 2015 at 03:37:44PM -0700, Troy Kisky wrote:
>> Currently, the timeout is never detected as count
>> has a value of -1 if a timeout happens, but the code is checking
>> for 0. Also, this patch removes the unneeded final wait
>> if a timeout occurs.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>> ---
>>  drivers/pci/host/pci-imx6.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
>> index fdb9536..51be92c 100644
>> --- a/drivers/pci/host/pci-imx6.c
>> +++ b/drivers/pci/host/pci-imx6.c
>> @@ -398,20 +398,22 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
>>  	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
>>  
>>  	count = 200;
>> -	while (count--) {
>> +	while (1) {
>>  		tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
>>  		/* Test if the speed change finished. */
>> -		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
>> +		if (!(tmp & PORT_LOGIC_SPEED_CHANGE)) {
>> +			/* Make sure link training is finished as well! */
>> +			ret = imx6_pcie_wait_for_link(pp);
>> +			break;
>> +		}
>> +		if (count-- == 0) {
>> +			dev_err(pp->dev, "Speed change timeout\n");
>> +			ret = -EINVAL;
>>  			break;
>> +		}
>>  		usleep_range(100, 1000);
>>  	}
>>  
>> -	/* Make sure link training is finished as well! */
>> -	if (count)
>> -		ret = imx6_pcie_wait_for_link(pp);
>> -	else
>> -		ret = -EINVAL;
>> -
>>  	if (ret) {
>>  		dev_err(pp->dev, "Failed to bring link up!\n");
>>  	} else {
> 
> This looks fine functionally, but I propose the following slight
> rearrangement because I have another patch that makes all the
> "wait_for_link" timeout loops look similar, and this loop might as
> well be similar, too.
> 
> Unrelated to your patch, but noticed while doing this: what's the magic
> constant 0x80 here?
> 
> +	tmp = readl(pp->dbi_base + 0x80);
> 
> Is that correct?  Can we add a symbolic name for it?
> 
> Bjorn
> 

The name in the manual for +x80 is
PCIE_RC_LCSR - Link Control and Status Register

