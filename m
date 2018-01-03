Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V2] mfd: rtsx: release IRQ during shutdown
To: Sinan Kaya <okaya@codeaurora.org>, lee.jones@linaro.org,
        timur@codeaurora.org
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        bhelgaas@google.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org
References: <1514982766-18012-1-git-send-email-okaya@codeaurora.org>
From: Chris Clayton <chris2553@googlemail.com>
Message-ID: <f0e8857a-47c6-5848-ba24-51652343168b@googlemail.com>
Date: Wed, 3 Jan 2018 16:34:06 +0000
MIME-Version: 1.0
In-Reply-To: <1514982766-18012-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 03/01/18 12:32, Sinan Kaya wrote:
> 'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
> shutdown")' revealed a resource leak in rtsx_pci driver during shutdown.
> 
> Issue shows up as a warning during shutdown as follows:
> 
> remove_proc_entry: removing non-empty directory 'irq/17', leaking at least
> 'rtsx_pci'
> WARNING: CPU: 0 PID: 1578 at fs/proc/generic.c:572
> remove_proc_entry+0x11d/0x130
> Modules linked in <long list but none that are out-of-tree>
> ...
> Call Trace:
> unregister_irq_proc
> free_desc
> irq_free_descs
> mp_unmap_irq
> acpi_unregister_gsi_apic
> acpi_pci_irq_disable
> do_pci_disable_device
> pci_disable_device
> device_shutdown
> kernel_restart
> Sys_reboot
> 
> Even though rtsx_pci driver implements a shutdown callback, it is not
> releasing the interrupt that it registered during probe. This is causing
> the ACPI layer to complain that the shared IRQ is in use while freeing
> IRQ.
> 
> This code releases the IRQ to prevent resource leak and eliminate the
> warning.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198141
> Reported-by: Chris Clayton <chris2553@googlemail.com>
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/mfd/rtsx_pcr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
> index 590fb9a..c3ed885 100644
> --- a/drivers/mfd/rtsx_pcr.c
> +++ b/drivers/mfd/rtsx_pcr.c
> @@ -1543,6 +1543,9 @@ static void rtsx_pci_shutdown(struct pci_dev *pcidev)
>  	rtsx_pci_power_off(pcr, HOST_ENTER_S1);
>  
>  	pci_disable_device(pcidev);
> +	free_irq(pcr->irq, (void *)pcr);
> +	if (pcr->msi_en)
> +		pci_disable_msi(pcr->pci);
>  }
>  
>  #else /* CONFIG_PM */

I've applied v2 of the patch and built and installed the kernel (-rc6). All I can say, is that my system still closes
down without the warning and call trace that the unpatched kernel produces. It's the best I can do by way of a test
because I have no idea what the code added in v2 is supposed to achieve and, because my system shuts down (or reboots)
moments later, there is no opportunity to check. If that constitutes a valid test:

Tested-by: Chris Clayton <chris2553@googlemail.com>

> 
