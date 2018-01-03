Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1514925904-24001-1-git-send-email-okaya@codeaurora.org>
References: <1514925904-24001-1-git-send-email-okaya@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2018 13:06:01 +0100
Message-ID: <CAJZ5v0hYu-1O63omwGNCDUhzt6_TT2vPk7OxSSfJ06h1GWeWxA@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: release IRQ during shutdown
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@codeaurora.org>, chris2553@googlemail.com,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 2, 2018 at 9:45 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> 'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
> shutdown")' revealed a resource leak in rtsx_pci driver during shutdown.
>
> Issue shows up as a warning during the shutdown step as follows:
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
> Tested-by: Chris Clayton <chris2553@googlemail.com>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/mfd/rtsx_pcr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
> index 590fb9a..bd504b6 100644
> --- a/drivers/mfd/rtsx_pcr.c
> +++ b/drivers/mfd/rtsx_pcr.c
> @@ -1543,6 +1543,7 @@ static void rtsx_pci_shutdown(struct pci_dev *pcidev)
>         rtsx_pci_power_off(pcr, HOST_ENTER_S1);
>
>         pci_disable_device(pcidev);
> +       free_irq(pcr->irq, (void *)pcr);

Do you need to disable MSI here too?

>  }
>
>  #else /* CONFIG_PM */
> --
