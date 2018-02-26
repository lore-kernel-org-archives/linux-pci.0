Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53400 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbeBZR02 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Feb 2018 12:26:28 -0500
Date: Mon, 26 Feb 2018 17:26:18 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180226172618.GA26815@e107981-ln.cambridge.arm.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
 <20180208123346.20784-3-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180208123346.20784-3-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 08, 2018 at 01:33:45PM +0100, Niklas Cassel wrote:
> A 64-bit BAR uses the succeeding BAR for the upper bits,
> so we cannot simply call pci_ioremap_bar() on every single BAR.
> 
> Ignore BARs that does not have a valid resource length.
> 
> pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
> pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
> pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR1
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR3
> pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
> pci-endpoint-test 0000:01:00.0: failed to read BAR5
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
> Lorenzo/Bjorn: pci_resource_len() seems to fix my problem,
> but is it the correct function to use here?
> If BAR[x] is a 64-bit BAR, I'm assuming that pci_resource_len() on BAR[x+1]
> will always return 0 (since BAR[x+1] cannot have any prefetchable/type bits
> when BAR[x] is 64-bit).
> 
>  drivers/misc/pci_endpoint_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 320276f42653..3af31bfdcfdd 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -534,6 +534,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	}
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> +		if (pci_resource_len(pdev, bar) == 0)
> +			continue;

Should not it be handled by checking the resource flags as you loop
through the bar counter and incrementing the bar counter (+1) if
IORESOURCE_MEM_64 is detected ?

I would like to get Bjorn's point of view on this since it is definitely
more comprehensive than mine.

Thanks,
Lorenzo

>  		base = pci_ioremap_bar(pdev, bar);
>  		if (!base) {
>  			dev_err(dev, "failed to read BAR%d\n", bar);
> -- 
> 2.14.2
> 
