Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:53374 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbbBZBK4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 20:10:56 -0500
Received: by mail-wi0-f180.google.com with SMTP id h11so9097271wiw.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2015 17:10:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150226010438.GT6220@google.com>
References: <1423512731-9625-1-git-send-email-festevam@gmail.com> <20150226010438.GT6220@google.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 25 Feb 2015 19:10:35 -0600
Message-ID: <CAL_JsqJKkRQLkMkSc_S1RLGRbRCc-6GoFYrvOtY3WgPs_qpdmA@mail.gmail.com>
Subject: Re: [PATCH] PCI: xgene: Fix xgene_pcie_map_bus() return type
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 25, 2015 at 7:04 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Tanmay]
>
> On Mon, Feb 09, 2015 at 06:12:11PM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Commit 350f8be5bb402a1 ("PCI: xgene: Convert to use generic config accessors")
>> introduced the following build warnings:
>>
>> drivers/pci/host/pci-xgene.c:137:3: warning: return makes integer from pointer without a cast
>> drivers/pci/host/pci-xgene.c:140:2: warning: return makes integer from pointer without a cast
>> drivers/pci/host/pci-xgene.c:144:2: warning: initialization from incompatible pointer type
>> drivers/pci/host/pci-xgene.c:144:2: warning: (near initialization for 'xgene_pcie_ops.map_bus')
>>
>> The .map_bus function should return 'void __iomem *' instead of 'int'.
>>
>> Reported-by: Olof's autobuilder <build@lixom.net>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Applied to for-linus for v4.0, thanks!
>
> Rob, Tanmay, speak up if you object.

While this fixes the warning, it doesn't fix the real problem. You
should apply this instead:

https://patchwork.ozlabs.org/patch/440759/

Rob

>
>> ---
>>  drivers/pci/host/pci-xgene.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
>> index aab5547..22addb6 100644
>> --- a/drivers/pci/host/pci-xgene.c
>> +++ b/drivers/pci/host/pci-xgene.c
>> @@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
>>       return false;
>>  }
>>
>> -static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>> +static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
>>                             int offset)
>>  {
>>       struct xgene_pcie_port *port = bus->sysdata;
>> --
>> 1.9.1
>>
