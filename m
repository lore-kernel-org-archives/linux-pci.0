Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37877 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966364AbeBNBpQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Feb 2018 20:45:16 -0500
Received: by mail-ot0-f195.google.com with SMTP id e64so19060006ote.4
        for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2018 17:45:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171220121438.GB1709@red-moon>
References: <1513730309-18831-1-git-send-email-festevam@gmail.com> <20171220121438.GB1709@red-moon>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Feb 2018 23:45:15 -0200
Message-ID: <CAOMZO5CwQwxeuaswRHmgY=KA8o8-Zidz0N5tVFhtn9iZJqqh=A@mail.gmail.com>
Subject: Re: [PATCH] PCI: xgene: Fix the error return code
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: kdinh@apm.com, Bjorn Helgaas <bhelgaas@google.com>, dhdang@apm.com,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Khuong Dinh, Lorenzo,

On Wed, Dec 20, 2017 at 10:14 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> [+ Khuong Dinh]
>
> On Tue, Dec 19, 2017 at 10:38:29PM -0200, Fabio Estevam wrote:
>> In the case of IS_ERR() error, we should return PTR_ERR().
>>
>> Fix the error return code.
>>
>> Signed-off-by: Fabio Estevam <festevam@gmail.com>
>> ---
>>  drivers/pci/host/pci-xgene-msi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I am about to apply this patch, please let me know if you see
> any issue with that.

A gente ping.

>
> Thanks,
> Lorenzo
>
>> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
>> index 1f42a20..4a1fb01 100644
>> --- a/drivers/pci/host/pci-xgene-msi.c
>> +++ b/drivers/pci/host/pci-xgene-msi.c
>> @@ -465,7 +465,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
>>       xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
>>       if (IS_ERR(xgene_msi->msi_regs)) {
>>               dev_err(&pdev->dev, "no reg space\n");
>> -             rc = -EINVAL;
>> +             rc = PTR_ERR(xgene_msi->msi_regs);
>>               goto error;
>>       }
>>       xgene_msi->msi_addr = res->start;
>> --
>> 2.7.4
>>
