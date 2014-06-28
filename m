Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:41487 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbaF1AWD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jun 2014 20:22:03 -0400
Received: by mail-lb0-f175.google.com with SMTP id n15so4526901lbi.34
        for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2014 17:22:01 -0700 (PDT)
Message-ID: <53AE0ABB.4010501@cogentembedded.com>
Date: Sat, 28 Jun 2014 04:22:19 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>
CC: Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: host: pcie-rcar: Style and formatting changes.
References: <1403888155-9709-1-git-send-email-phil.edworthy@renesas.com> <1403888155-9709-3-git-send-email-phil.edworthy@renesas.com> <20140628001448.GE27128@verge.net.au> <20140628001542.GA32431@verge.net.au>
In-Reply-To: <20140628001542.GA32431@verge.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 06/28/2014 04:15 AM, Simon Horman wrote:

>>> This patch just makes symbol and function name changes to avoid
>>> potential conflicts, along with minor formatting changes.
>>> The only other change is to replace an arg passed into a func
>>> with a local variable.

>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>>> ---
>>>   drivers/pci/host/pcie-rcar.c | 131 ++++++++++++++++++++++---------------------
>>>   1 file changed, 67 insertions(+), 64 deletions(-)

>>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>>> index 680a8cc..efdea07 100644
>>> --- a/drivers/pci/host/pcie-rcar.c
>>> +++ b/drivers/pci/host/pcie-rcar.c
[...]
>>> @@ -318,14 +319,15 @@ static struct pci_ops rcar_pcie_ops = {
>>>   	.write	= rcar_pcie_write_conf,
>>>   };
>>>
>>> -static void rcar_pcie_setup_window(int win, struct resource *res,
>>> -				   struct rcar_pcie *pcie)
>>> +static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie)
>>>   {
>>> +	struct resource *res = &pcie->res[win];
>>> +
>>
>> The removal of the res parameter is not in keeping with the changelog.
>> Could you break it out into a separate patch?
>
> Sorry, I see that it is mentioned in the changelog.
> But could you split the patch all the same?

    I agree. Generally, you should not mix several changes of a different 
nature in one patch.

WBR, Sergei

