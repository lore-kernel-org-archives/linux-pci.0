Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51790 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdKJV55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2017 16:57:57 -0500
From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 3/3] PCI: rcar: Add the suspend/resume for pcie-rcar
 driver
To: Simon Horman <horms@verge.net.au>
Cc: linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20171108092806.10335-1-marek.vasut+renesas@gmail.com>
 <20171108092806.10335-3-marek.vasut+renesas@gmail.com>
 <20171110090918.jirrnejohfdpcxbo@verge.net.au>
Message-ID: <22cec1d9-dc11-e210-d527-0f39f7b2bccd@gmail.com>
Date: Fri, 10 Nov 2017 22:53:07 +0100
MIME-Version: 1.0
In-Reply-To: <20171110090918.jirrnejohfdpcxbo@verge.net.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/10/2017 10:09 AM, Simon Horman wrote:
> On Wed, Nov 08, 2017 at 10:28:06AM +0100, Marek Vasut wrote:
>> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>>
>> This adds the suspend/resume supports for pcie-rcar. The resume handler
>> reprogram the hardware based on the software state kept in specific
>> device structures. Also it doesn't need to save any registers.
>>
>> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>>  drivers/pci/host/pcie-rcar.c | 86 +++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 78 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>> index 2b28292de93a..7a9e30185c79 100644
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -471,6 +471,36 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
>>  		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
>>  }
>>  
>> +static int rcar_pcie_hw_enable(struct rcar_pcie *pcie)
> 
> This function always returns 0 and the value is not checked by the caller.
> Can we change the return type to void?

Yes, done

>> +{
>> +	struct resource_entry *win;
>> +	LIST_HEAD(res);
>> +	int i = 0;
>> +
>> +	/* Try setting 5 GT/s link speed */
> 
> What if it fails?

If it fails, we're back at 2.5 GT/s . The rcar_pcie_force_speedup()
first checks if the PCIe IP can do 5 GT/s at all. Only if so, tries to
initiate transition to 5 GT/s operation , checks whether that succeeded
and if it failed, falls back to 2.5 GT/s .

>> +	rcar_pcie_force_speedup(pcie);
>> +
>> +	/* Setup PCI resources */
>> +	resource_list_for_each_entry(win, &pcie->resources) {
>> +		struct resource *res = win->res;
>> +
>> +		if (!res->flags)
>> +			continue;
>> +
>> +		switch (resource_type(res)) {
>> +		case IORESOURCE_IO:
>> +		case IORESOURCE_MEM:
>> +			rcar_pcie_setup_window(i, pcie, res);
>> +			i++;
>> +			break;
>> +		default:
>> +			continue;
> 
> Can the default case be omitted?

Sure

>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int rcar_pcie_enable(struct rcar_pcie *pcie)
>>  {
>>  	struct device *dev = pcie->dev;
>> @@ -872,11 +902,25 @@ static const struct irq_domain_ops msi_domain_ops = {
>>  	.map = rcar_msi_map,
>>  };
>>  
>> +static void rcar_pcie_hw_enable_msi(struct rcar_pcie *pcie)
>> +{
>> +	struct rcar_msi *msi = &pcie->msi;
>> +	unsigned long base;
>> +
>> +	/* setup MSI data target */
>> +	base = virt_to_phys((void *)msi->pages);
> 
> Why do you need to cast to void *?
> I expect such casting can be done implicitly.

Because __get_free_pages() returns unsigned long and that's what's used
to assign msi->pages . And virt_to_phys() expects void * instead, thus
the cast.

>> +
>> +	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
>> +	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
>> +
>> +	/* enable all MSI interrupts */
>> +	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
>> +}
>> +
>>  static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>>  {
>>  	struct device *dev = pcie->dev;
>>  	struct rcar_msi *msi = &pcie->msi;
>> -	unsigned long base;
>>  	int err, i;
>>  
>>  	mutex_init(&msi->lock);
>> @@ -915,13 +959,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>>  
>>  	/* setup MSI data target */
>>  	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>> -	base = virt_to_phys((void *)msi->pages);
>> -
>> -	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
>> -	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
>> -
>> -	/* enable all MSI interrupts */
>> -	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
>> +	rcar_pcie_hw_enable_msi(pcie);
>>  
>>  	return 0;
>>  
>> @@ -1202,6 +1240,37 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>>  	return err;
>>  }
>>  
>> +static int rcar_pcie_resume(struct device *dev)
>> +{
>> +	struct rcar_pcie *pcie = dev_get_drvdata(dev);
>> +	unsigned int data;
>> +	int err;
>> +	int (*hw_init_fn)(struct rcar_pcie *);
> 
> Please sort local variables in reverse xmas tree order.

OK

>> +
>> +	err = rcar_pcie_parse_map_dma_ranges(pcie, dev->of_node);
>> +	if (err)
>> +		return 0;
>> +
>> +	/* Failure to get a link might just be that no cards are inserted */
>> +	hw_init_fn = of_device_get_match_data(dev);
>> +	err = hw_init_fn(pcie);
>> +	if (err) {
>> +		dev_info(dev, "PCIe link down\n");
>> +		return 0;
>> +	}
>> +
>> +	data = rcar_pci_read_reg(pcie, MACSR);
>> +	dev_info(dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
>> +
>> +	/* Enable MSI */
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		rcar_pcie_hw_enable_msi(pcie);
>> +
>> +	rcar_pcie_hw_enable(pcie);
>> +
>> +	return 0;
>> +}
>> +
>>  static int rcar_pcie_resume_noirq(struct device *dev)
>>  {
>>  	struct rcar_pcie *pcie = dev_get_drvdata(dev);
>> @@ -1218,6 +1287,7 @@ static int rcar_pcie_resume_noirq(struct device *dev)
>>  }
>>  
>>  static const struct dev_pm_ops rcar_pcie_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, rcar_pcie_resume)
>>  	.resume_noirq = rcar_pcie_resume_noirq,
>>  };
>>  
>> -- 
>> 2.11.0
>>


-- 
Best regards,
Marek Vasut
