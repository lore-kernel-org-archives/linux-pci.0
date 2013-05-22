Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <519C45A3.3000005@cn.fujitsu.com>
Date: Wed, 22 May 2013 12:12:19 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Jiang Liu <liuj97@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Doug Thompson <dougthompson@xmission.com>,
	linux-edac@vger.kernel.org
Subject: Re: [RFC PATCH v2, part 2 14/18] PCI, EDAC: use hotplug-safe PCI
 bus iterators to walk PCI buses
References: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com> <1368550322-1045-14-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1368550322-1045-14-git-send-email-jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/15/2013 12:51 AM, Jiang Liu wrote:

> Enhance EDAC drviers to use hotplug-safe iterators to walk PCI buses.
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Doug Thompson <dougthompson@xmission.com>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/edac/i7core_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
> index 0ec3e95..39d5823 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -1296,7 +1296,7 @@ static unsigned i7core_pci_lastbus(void)
>  	int last_bus = 0, bus;
>  	struct pci_bus *b = NULL;
>  
> -	while ((b = pci_find_next_bus(b)) != NULL) {
> +	for_each_pci_root_bus(b)

missing the "{":
+	for_each_pci_root_bus(b) {

>  		bus = b->number;
>  		edac_dbg(0, "Found bus %d\n", bus);
>  		if (bus > last_bus)


