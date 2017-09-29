Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbdI2VP2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Sep 2017 17:15:28 -0400
Date: Fri, 29 Sep 2017 16:15:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: bhelgaas@google.com, linuxarm@huawei.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        liudongdong3@huawei.com
Subject: Re: [PATCH v3] PCIe AER: report uncorrectable errors only to the
 functions that logged the errors
Message-ID: <20170929211526.GD31210@bhelgaas-glaptop.roam.corp.google.com>
References: <1506609185-8800-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506609185-8800-1-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 28, 2017 at 03:33:05PM +0100, Gabriele Paoloni wrote:
> Currently if an uncorrectable error is reported by an EP the AER
> driver walks over all the devices connected to the upstream port
> bus and in turns call the report_error_detected() callback.
> If any of the devices connected to the bus does not implement
> dev->driver->err_handler->error_detected() do_recovery() will fail
> leaving all the bus hierarchy devices unrecovered.
> 
> According to section "6.2.2.2.2. Non-Fatal Errors" of the PCIe specs
> << Non-fatal errors are uncorrectable errors which cause a particular
> transaction to be unreliable but the Link is otherwise fully functional.
> Isolating Non-fatal from Fatal errors provides Requester/Receiver logic
> in a device or system management software the opportunity to recover
> from the error without resetting the components on the Link and
> disturbing other transactions in progress. Devices not associated with
> the transaction in error are not impacted by the error.>>
> therefore for non fatal errors the PCIe link should not be considered
> compromised and it makes sense to report the error only to all the
> functions that logged an error.
> 
> This patch implements this new behaviour for non fatal errors.
> Also this patch fixes a bug (filed as in the link below)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197055
> Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Applied to pci/aer for v4.15, thanks!

I rewrote some of the changelog to say "non-fatal" instead of
"uncorrectable", since "uncorrectable" also includes fatal errors,
and you're not changing those.  Take a look and let me know if
I broke anything.

> ---
> Changes from v2:
>    - no functional changes
>    - Added reference in the commit log to the bugzilla ticket
>    - Added reference in the commit log the commit that this patch fixes
>    - Added reference in the commit log to the PCIe specs for Non-fatal
>      error handling rules
>  
> Changes from v1:
>    - now errors are reported only to the fucntions that logged the error
>      instead of all the functions in the same device.
>    - the patch subject has changed to match the new implementation
> ---
>  drivers/pci/pcie/aer/aerdrv_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 890efcc..7448052 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -390,7 +390,14 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>  		 * If the error is reported by an end point, we think this
>  		 * error is related to the upstream link of the end point.
>  		 */
> -		pci_walk_bus(dev->bus, cb, &result_data);
> +		if (state == pci_channel_io_normal)
> +			/*
> +			 * the error is non fatal so the bus is ok, just invoke
> +			 * the callback for the function that logged the error.
> +			 */
> +			cb(dev, &result_data);
> +		else
> +			pci_walk_bus(dev->bus, cb, &result_data);
>  	}
>  
>  	return result_data.result;
> -- 
> 2.7.4
> 
> 
