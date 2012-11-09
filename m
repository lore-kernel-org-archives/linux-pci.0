Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45847 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab2KIRGt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Nov 2012 12:06:49 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so3987214vcb.19
        for <linux-pci@vger.kernel.org>; Fri, 09 Nov 2012 09:06:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <F9E001219150CB45BEDC82A650F360C9014674B9@G9W0717.americas.hpqcorp.net>
References: <F9E001219150CB45BEDC82A650F360C9014674B9@G9W0717.americas.hpqcorp.net>
Date: Fri, 9 Nov 2012 10:06:48 -0700
Message-ID: <CAL-B5D2ZmtOFQMhF7dG0p8U+ZcrjpQyzcLKvVzwYZ9RF6ckjzA@mail.gmail.com>
Subject: Re: [ PATCH ] PCI-AER: Do not report successful error recovery for
 devices with AER-unaware drivers
From: Myron Stowe <myron.stowe@gmail.com>
To: "Pandarathil, Vijaymohan R" <vijaymohan.pandarathil@hp.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linasvepstas@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding: linasvepstas@gmail.com

On Thu, Nov 8, 2012 at 9:28 PM, Pandarathil, Vijaymohan R
<vijaymohan.pandarathil@hp.com> wrote:
> When an error is detected on a PCIe device which does not have an
> AER-aware driver, prevent AER infrastructure from reporting
> successful error recovery.
>
> This is because the report_error_detected() function that gets
> called in the first phase of recovery process allows forward
> progress even when the driver for the device does not have AER
> capabilities. It seems that all callbacks (in pci_error_handlers
> structure) registered by drivers that gets called during error
> recovery are not mandatory. So the intention of the infrastructure
> design seems to be to allow forward progress even when a specific
> callback has not been registered by a driver. However, if error
> handler structure itself has not been registered, it doesn't make
> sense to allow forward progress.
>
> As a result of the current design, in the case of a single device
> having an AER-unaware driver or in the case of any function in a
> multi-function card having an AER-unaware driver, a successful
> recovery is reported.
>
> Typical scenario this happens is when a PCI device is detached
> from a KVM host and the pci-stub driver on the host claims the
> device. The pci-stub driver does not have error handling capabilities
> but the AER infrastructure still reports that the device recovered
> successfully.
>
> The changes proposed here leaves the device in an unrecovered state
> if the driver for the device or for any function in a multi-function
> card does not have error handler structure registered. This reflects
> the true state of the device and prevents any partial recovery (or no
> recovery at all) reported as successful.
>
> Please also see comments from Linas Vepstas at the following link
> http://www.spinics.net/lists/linux-pci/msg18572.html
>
> Signed-off-by: Linas Vepstas <linasvepstas <at> gmail.com>
> Signed-off-by: Myron Stowe <mstowe <at> redhat.com>
> Signed-off-by: Vijay Mohan Pandarathil <vijaymohan.pandarathil <at> hp.com>

Hay Vijay:

I think Linas may have steered you incorrectly with his "FWIW, I guess
I could add a
Signed-off-by: Linas Vepstas <...>" comment.

>From ./Documentation/SubmittingPatches, "The Signed-off-by: tag
indicates that the
signer was involved in the development of the patch, or that he/she
was in the patch's
delivery path."

I this case I suspect that "reviewed-by" or 'acked-by" would be more
appropriate for
both Linas (unless of course Linas worked with you in developing the patch) and
myslef.

Also, when posting to the list it's considered good etiquette to
include (cc) everyone
cited in the Signed-off, reviewed-by, acked-by, ..., lines (and
possibly the linux-kernel
list - again see ./Documentation/SubmittingPatches).

Myron
>
> ---
>
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 06bad96..030b229 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -215,6 +215,12 @@ static int report_error_detected(struct pci_dev *dev, void *data)
>
>         dev->error_state = result_data->state;
>
> +       if ((!dev->driver || !dev->driver->err_handler) &&
> +               !(dev->hdr_type & PCI_HEADER_TYPE_BRIDGE)) {
> +               dev_info(&dev->dev, "AER: Error detected but no driver has claimed this device or the driver is AER-unaware\n");
> +               result_data->result = PCI_ERS_RESULT_NONE;
> +               return 1;
> +       }
>         if (!dev->driver ||
>                 !dev->driver->err_handler ||
>                 !dev->driver->err_handler->error_detected) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
