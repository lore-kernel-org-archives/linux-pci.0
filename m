Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:35773 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeCUD7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2018 23:59:35 -0400
Date: Wed, 21 Mar 2018 04:59:31 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: kishon@ti.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180321035931.GB28953@axis.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-6-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308133331.19464-6-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Greg,

Lorenzo	is fine with this series
( https://marc.info/?l=linux-kernel&m=152147837619191&w=2 )

However, he wants your ack on this patch before merging.

Could you please have a look at this patch?


Kind regards,
Niklas


On Thu, Mar 08, 2018 at 02:33:30PM +0100, Niklas Cassel wrote:
> A 64-bit BAR consists of a BAR pair, where the second BAR has the
> upper bits, so we cannot simply call pci_ioremap_bar() on every single
> BAR index.
> 
> The second BAR in a BAR pair will not have the IORESOURCE_MEM resource
> flag set. Only call ioremap on BARs that have the IORESOURCE_MEM
> resource flag set.
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
>  drivers/misc/pci_endpoint_test.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 320276f42653..fe8897e64635 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -534,12 +534,14 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	}
>  
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> -		base = pci_ioremap_bar(pdev, bar);
> -		if (!base) {
> -			dev_err(dev, "failed to read BAR%d\n", bar);
> -			WARN_ON(bar == test_reg_bar);
> +		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
> +			base = pci_ioremap_bar(pdev, bar);
> +			if (!base) {
> +				dev_err(dev, "failed to read BAR%d\n", bar);
> +				WARN_ON(bar == test_reg_bar);
> +			}
> +			test->bar[bar] = base;
>  		}
> -		test->bar[bar] = base;
>  	}
>  
>  	test->base = test->bar[test_reg_bar];
> -- 
> 2.14.2
> 
