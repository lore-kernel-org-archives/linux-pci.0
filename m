Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:43193 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935408AbcJ0QGx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Oct 2016 12:06:53 -0400
Date: Thu, 27 Oct 2016 18:06:48 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Rick Kerkhof <rick.2889@gmail.com>, linux-acpi@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: Re: Acer Aspire V7-582PG (Haswell, GTX 750M) fails to power off GPU
 via Power Resources
Message-ID: <20161027160648.GF27017@al>
References: <bug-98398-8800@http.bugs.freedesktop.org/>
 <bug-98398-8800-66oU1nuK0R@http.bugs.freedesktop.org/>
 <20161026225641.GA27017@al>
 <20161027081748.GX1476@lahna.fi.intel.com>
 <20161027090604.GB27017@al>
 <CANni8hdMs4pL0m6FrgeyJjE2R2C=6PaHbVbMVoUU+NszJuf9OA@mail.gmail.com>
 <20161027093011.GZ1476@lahna.fi.intel.com>
 <CANni8her35iORgrZOkDzxhfVaOOzObTLG2Ly0kkNZPDTrbyfQQ@mail.gmail.com>
 <20161027095508.GA1476@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161027095508.GA1476@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 27, 2016 at 12:55:08PM +0300, Mika Westerberg wrote:
> On Thu, Oct 27, 2016 at 09:42:28AM +0000, Rick Kerkhof wrote:
> >    No, there are not. Here is the recursive directory listing:
> 
> Are you able to try the following patch and send me dmesg (or attach it
> to that bug)? It should show if the ACPI core even tries to add those
> power resources.

So Rick has tested this patch now on top of 4.8.4 (mainline fails to
boot due to a kbuild issue which I reported elsewhere), but the output
is empty. That seems to indicate that flags.power_resources is unset.

Given that _PS3 exists and is indeed a package with some elements, it
seems that acpi_extract_power_resources is failing. Note that in the
SSDT, the power resource NVP3 was referenced before it was defined,
could that result in this enumeration failure? Relevant SSDT excerpt:

    Scope (\_SB.PCI0.RP05)
    {
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            NVP3
        })
        // ...
    }

    PowerResource (NVP3, 0x00, 0x0000)

Kind regards,
Peter

> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index fcd4ce6f78d5..af9c3e15dd74 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -444,6 +444,9 @@ void acpi_power_add_remove_device(struct acpi_device *adev, bool add)
>  	if (!adev->power.flags.power_resources)
>  		return;
>  
> +	acpi_handle_info(adev->handle, "Adding power resources for %s\n",
> +			 dev_name(&adev->dev));
> +
>  	for (state = ACPI_STATE_D0; state <= ACPI_STATE_D3_HOT; state++)
>  		acpi_power_expose_hide(adev,
>  				       &adev->power.states[state].resources,
