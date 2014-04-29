Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33832 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbaD2DHA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Apr 2014 23:07:00 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so7221723iec.23
        for <linux-pci@vger.kernel.org>; Mon, 28 Apr 2014 20:06:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BBLesVnHRkSkGaadr=-RpvUm68u2L2MZeQ2WOq28n=xw@mail.gmail.com>
References: <1398682281-18772-1-git-send-email-festevam@gmail.com>
 <CAErSpo70h=DeE3=EpF9d=RQM5y-3tTJ9ZqDiGQ8t5rLfs_zx6w@mail.gmail.com> <CAOMZO5BBLesVnHRkSkGaadr=-RpvUm68u2L2MZeQ2WOq28n=xw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 28 Apr 2014 21:06:39 -0600
Message-ID: <CAErSpo7c+8d9zbSrk_8cdNeyAcSVGve5uEQVcfpbG3feiYRxHg@mail.gmail.com>
Subject: Re: [PATCH] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t' type
To: Fabio Estevam <festevam@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 28, 2014 at 6:52 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Apr 28, 2014 at 9:16 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Mon, Apr 28, 2014 at 4:51 AM, Fabio Estevam <festevam@gmail.com> wrote:
>>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>>
>>> Fix the following build warning that happens when building multi_v7_defconfig
>>> with CONFIG_ARM_LPAE=y:
>>>
>>> drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' [-Wformat=]
>>>
>>> While at it, also use '%zx' for printing 'size_t'.
>>>
>>> Reported-by: Olof's autobuilder <build@lixom.net>
>>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>>> ---
>>>  drivers/pci/host/pci-mvebu.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
>>> index e384e25..572a7b5 100644
>>> --- a/drivers/pci/host/pci-mvebu.c
>>> +++ b/drivers/pci/host/pci-mvebu.c
>>> @@ -330,8 +330,8 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
>>>                                                         sz, remap);
>>>                 if (ret) {
>>>                         dev_err(&port->pcie->pdev->dev,
>>> -                               "Could not create MBus window at 0x%x, size 0x%x: %d\n",
>>> -                               base, sz, ret);
>>> +                               "Could not create MBus window at %pa, size 0x%zx: %d\n",
>>> +                               &base, sz, ret);
>>
>> This is OK, but can we use the same "[mem 0x...-0x...]" format that
>> %pR prints a struct resource with?  That would make it look more like
>> other similar information we print elsewhere.  When you're debugging a
>> problem, sometimes you have to compare address information from
>> different places, and it's convenient if they all look similar.
>
> Understood your point, but in order to use %pR we need to use a
> 'struct resource', which is something that the current code is not
> using. 'sz' is calculated inside the function, so it is helpful to
> print it as is.

I didn't suggest changing the code to use an actual "struct resource".
 I suggested using a similar printk format, e.g., "[mem
%#010llx-%#010llx]".
