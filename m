Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch v7 05/18] ACPI: Correct return value of acpi_dev_resource_address_space()
Date: Mon, 27 Oct 2014 23:30:40 +0100
Message-ID: <2575568.AkFDcf4v5G@vostro.rjw.lan>
In-Reply-To: <1414387308-27148-6-git-send-email-jiang.liu@linux.intel.com>
References: <1414387308-27148-1-git-send-email-jiang.liu@linux.intel.com> <1414387308-27148-6-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, October 27, 2014 01:21:35 PM Jiang Liu wrote:
> Change acpi_dev_resource_address_space() to return failure if the
> acpi_resource structure can't be converted to an ACPI address64
> structure, so caller could correctly detect failure.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

ACK

> ---
>  drivers/acpi/resource.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 2ba8f02ced36..782a0d15c25f 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -200,7 +200,7 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
>  
>  	status = acpi_resource_to_address64(ares, &addr);
>  	if (ACPI_FAILURE(status))
> -		return true;
> +		return false;
>  
>  	res->start = addr.minimum;
>  	res->end = addr.maximum;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
