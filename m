Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <546CDB26.9030609@ti.com>
Date: Wed, 19 Nov 2014 13:02:14 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@chromium.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Wolfram Sang <wsa@the-dreams.de>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: keystone: fix error handling of irq_of_parse_and_map
References: <20141114221903.GA38539@dtor-ws>
In-Reply-To: <20141114221903.GA38539@dtor-ws>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/14/2014 05:19 PM, Dmitry Torokhov wrote:
> Return value of irq_of_parse_and_map() is unsigned int, with 0
> indicating failure, so testing for negative result never works.
>
> Signed-off-by: Dmitry Torokhov<dtor@chromium.org>
> ---
>
> Not tested, found by casual code inspection.
>
>   drivers/pci/host/pci-keystone.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 8a27078..f2bd48d 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -197,7 +197,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
>   	 */
>   	for (temp = 0; temp<  max_host_irqs; temp++) {
>   		host_irqs[temp] = irq_of_parse_and_map(*np_temp, temp);
> -		if (host_irqs[temp]<  0)
> +		if (!host_irqs[temp])
>   			break;
>   	}
>   	if (temp) {
Good catch!

Acked-By: Murali Karicheri <m-karicheri2@ti.com>

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
