Return-Path: <SRS0=UHpN=77=ti.com=kishon@kernel.org>
Return-Path: <SRS0=UHpN=77=ti.com=kishon@kernel.org>
Subject: Re: [PATCH] misc: pci_endpoint_test: make boolean no_msi static
To: Colin King <colin.king@canonical.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
References: <20170823094752.26962-1-colin.king@canonical.com>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e2f73846-7955-2e99-5fa6-463f96447da8@ti.com>
Date: Tue, 29 Aug 2017 12:01:22 +0530
MIME-Version: 1.0
In-Reply-To: <20170823094752.26962-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wednesday 23 August 2017 03:17 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The boolean no_msi is local to the source and does not need to be in
> global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'no_msi' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Can you pick this one also?
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>


Thanks
Kishon
> ---
>  drivers/misc/pci_endpoint_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 1f64d943794d..deb203026496 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -73,7 +73,7 @@ static DEFINE_IDA(pci_endpoint_test_ida);
>  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
>  					    miscdev)
>  
> -bool no_msi;
> +static bool no_msi;
>  module_param(no_msi, bool, 0444);
>  MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
>  
> 
