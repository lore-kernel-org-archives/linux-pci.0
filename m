Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] PCI, ACPI: Don't query OSC support with all possible controls
Date: Sat, 30 Mar 2013 01:36:04 +0100
Message-ID: <2045510.EK2WTuFZxV@vostro.rjw.lan>
In-Reply-To: <1364444938-19801-1-git-send-email-yinghai@kernel.org>
References: <1364444938-19801-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 27, 2013 09:28:58 PM Yinghai Lu wrote:
> Found problem on system that firmware that could handle pci aer.
> Firmware get error reporting after pci injecting error, before os boots.
> But after os boots, firmware can not get report anymore, even pci=noaer
> is passed.
> 
> Root cause: BIOS _OSC has problem with query bit checking.
> It turns out that BIOS vendor is copying example code from ACPI Spec.
> In ACPI Spec 5.0, page 290:
> 
> 	If (Not(And(CDW1,1))) // Query flag clear?
> 	{	// Disable GPEs for features granted native control.
> 		If (And(CTRL,0x01)) // Hot plug control granted?
> 		{
> 			Store(0,HPCE) // clear the hot plug SCI enable bit
> 			Store(1,HPCS) // clear the hot plug SCI status bit
> 		}
> 	...
> 	}
> 
> When Query flag is set, And(CDW1,1) will be 1, Not(1) will return 0xfffffffe.
> So it will get into code path that should be for control set only.
> BIOS acpi code should be changed to "If (LEqual(And(CDW1,1), 0)))"
> 
> Current kernel code is using _OSC query to notify firmware about support
> from OS and then use _OSC to set control bits.
> During query support, current code is using all possible controls.
> So will execute code that should be only for control set stage.
> 
> That will have problem when pci=noaer or aer firmware_first is used.
> As firmware have that control set for os aer already in query support stage,
> but later will not os aer handling.
> 
> We should avoid passing all possible controls, just use osc_control_set
> instead.
> That should workaround BIOS bugs with affected systems on the field
> as more bios vendors are copying sample code from ACPI spec.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: stable@kernel.org
> 
> ---
>  drivers/acpi/pci_root.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/pci_root.c
> +++ linux-2.6/drivers/acpi/pci_root.c
> @@ -201,8 +201,8 @@ static acpi_status acpi_pci_query_osc(st
>  		*control &= OSC_PCI_CONTROL_MASKS;
>  		capbuf[OSC_CONTROL_TYPE] = *control | root->osc_control_set;
>  	} else {
> -		/* Run _OSC query for all possible controls. */
> -		capbuf[OSC_CONTROL_TYPE] = OSC_PCI_CONTROL_MASKS;
> +		/* Run _OSC query only with existing controls. */
> +		capbuf[OSC_CONTROL_TYPE] = root->osc_control_set;

I suppose we can do that, but then why this should be root->osc_control_set and
not just 0?

>  	}
>  
>  	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
> --

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
