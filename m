Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 28 Aug 2017 17:04:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Colin King <colin.king@canonical.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: make boolean no_msi static
Message-ID: <20170828150435.GA29822@kroah.com>
References: <20170823094752.26962-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823094752.26962-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 10:47:52AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The boolean no_msi is local to the source and does not need to be in
> global scope, so make it static.
> 
> Cleans up sparse warning:
> symbol 'no_msi' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
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

This doesn't apply to my tree at all :(
