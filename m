Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38250 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbASSce convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jan 2015 13:32:34 -0500
Date: Mon, 19 Jan 2015 18:32:29 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH 1/3] drivers: of: fix resources freeing in
 of_pci_get_host_bridge_resources()
Message-ID: <20150119183228.GE10762@e106497-lin.cambridge.arm.com>
References: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1420644571-18928-2-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <1420644571-18928-2-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 07, 2015 at 03:29:29PM +0000, Lorenzo Pieralisi wrote:
> In the function of_pci_get_host_bridge_resources() if the parsing of
> ranges fails, previously allocated resources inclusive of bus_range
> are not freed and are not expected to be freed by the function caller
> on error return.
> 
> This patch fixes the issues by adding code that properly frees resources
> and bus_range before exiting the function with an error return value.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/of/of_pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 88471d3..6fbfe99 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -146,6 +146,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  	struct of_pci_range_parser parser;
>  	char range_type[4];
>  	int err;
> +	struct pci_host_bridge_window *window;
>  
>  	if (io_base)
>  		*io_base = (resource_size_t)OF_BAD_ADDR;
> @@ -225,7 +226,10 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
>  conversion_failed:
>  	kfree(res);
>  parse_failed:
> +	list_for_each_entry(window, resources, list)
> +		kfree(window->res);
>  	pci_free_resource_list(resources);
> +	kfree(bus_range);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);

Hi Lorenzo et all,

Here is my personal view and I am happy to hear from others on the desired
behaviour:

When I wrote this function what I had in mind was that it will parse as
much as possible from the device tree and return a list of resources that
could be successfully converted. If the entire list of ranges could not
be converted then an error code will be returned, but the caller still
had the list as constructed up to the error. It was the job of the caller
to free the list in either cases, as stated in the comment.

The historical reason why the function was written that way was because at
some moment after parsing I've had an additional step where arches could
cleanup / veto the list and they could return an error value to signal
their discontent. Also I was (am) not sure how lenient we could be with
the device tree not being sane (at least one host bridge binding lists the
config space as a range, which was accepted as broken).

So, from that point of view, I would NAK this patch, as the function works
as intended. If others find this mode of operation too convoluted, then
the patch should probably make clear that cleanup only needs to be done on
function returning success.

Best regards,

> -- 
> 2.2.1
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

