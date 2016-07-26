Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 26 Jul 2016 15:21:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rui Wang <rui.y.wang@intel.com>
Cc: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/ioapic: Fix setup_res() failing to get resource
Message-ID: <20160726202134.GE15037@localhost>
References: <1469549597-19253-1-git-send-email-rui.y.wang@intel.com>
 <1469549597-19253-3-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469549597-19253-3-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 27, 2016 at 12:13:15AM +0800, Rui Wang wrote:
> setup_res() doesn't actually get any resoure because it mistakenly

s/resoure/resource/

> checks the return value of acpi_dev_filter_resource_type(), which
> returns 0 on success, and 1 on failure. Fix it by taking the return
> value of non-zero as failing to match the specified resource type.
> 
> Signed-off-by: Rui Wang <rui.y.wang@intel.com>
> ---
>  drivers/acpi/ioapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
> index 0f272e2..daf4a40 100644
> --- a/drivers/acpi/ioapic.c
> +++ b/drivers/acpi/ioapic.c
> @@ -46,7 +46,7 @@ static acpi_status setup_res(struct acpi_resource *acpi_res, void *data)
>  	struct resource_win win;
>  
>  	res->flags = 0;
> -	if (acpi_dev_filter_resource_type(acpi_res, IORESOURCE_MEM) == 0)
> +	if (acpi_dev_filter_resource_type(acpi_res, IORESOURCE_MEM))
>  		return AE_OK;
>  
>  	if (!acpi_dev_resource_memory(acpi_res, res)) {
> -- 
> 1.8.3.1
> 
