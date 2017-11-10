Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35017 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdKJV5t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2017 16:57:49 -0500
Subject: Re: [PATCH V2] PCI: rcar: Use runtime PM to control controller clock
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20171108095816.14192-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdVqkx-eVzW=0D8eOKZ2OGc-XTenYW8FHnKgBAvjKvv4tw@mail.gmail.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <e6bf9480-0b82-b5c1-484a-f7d852cf6a19@gmail.com>
Date: Fri, 10 Nov 2017 21:34:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVqkx-eVzW=0D8eOKZ2OGc-XTenYW8FHnKgBAvjKvv4tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/08/2017 11:08 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi Geert,

> On Wed, Nov 8, 2017 at 10:58 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>>
>> The controller clock can be switched off during suspend/resume,
>> let runtime PM take care of that.
>>
>> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
>> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -1125,6 +1112,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>
>>         rcar_pcie_parse_request_of_pci_ranges(pcie);
>>
>> +       pm_runtime_enable(pcie->dev);
>> +       err = pm_runtime_get_sync(pcie->dev);
>> +       if (err < 0) {
>> +               dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
>> +               goto err_pm_disable;
>> +       }
>> +
>>         err = rcar_pcie_get_resources(pcie);
>>         if (err < 0) {
>>                 dev_err(dev, "failed to request resources: %d\n", err);
> 
> (out of context)
>                  goto err_free_bridge;
> 
> But that should do pm_runtime_put(), too.
> 
>> @@ -1135,13 +1129,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>         if (err)
>>                 goto err_free_bridge;
>>
>> -       pm_runtime_enable(dev);
>> -       err = pm_runtime_get_sync(dev);
>> -       if (err < 0) {
>> -               dev_err(dev, "pm_runtime_get_sync failed\n");
>> -               goto err_pm_disable;
>> -       }
>> -
>>         /* Failure to get a link might just be that no cards are inserted */
>>         hw_init_fn = of_device_get_match_data(dev);
>>         err = hw_init_fn(pcie);
>> @@ -1173,13 +1160,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>  err_pm_put:
>>         pm_runtime_put(dev);
> 
> "err_pm_put" should be moved, too.

ACK. I combed through the probe function one more time and I hope I'll
have it right in V3.

>> -err_pm_disable:
>> -       pm_runtime_disable(dev);
>> -
>>  err_free_bridge:
>>         pci_free_host_bridge(bridge);
>>         pci_free_resource_list(&pcie->resources);

^ IMO this should happen after pm_runtime_disable too , just to be
consistent.

>> +err_pm_disable:
>> +       pm_runtime_disable(dev);
>> +
>>         return err;
>>  }

[...]


-- 
Best regards,
Marek Vasut
