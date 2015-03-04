Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Voegtle <tv@lio96.de>, Hudd <hedede.l@gmail.com>,
	Prakash Punnoor <prakash@punnoor.de>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Dave Airlie <airlied@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Len Brown <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Lv Zheng <lv.zheng@intel.com>
Subject: Re: [Bugfix 2/2] x86/PCI/ACPI: Relax ACPI resource descriptor checks to work around BIOS bugs
Date: Wed, 04 Mar 2015 15:26:04 +0100
Message-ID: <3849431.yNgBMZCl9m@vostro.rjw.lan>
In-Reply-To: <1425458832-28777-2-git-send-email-jiang.liu@linux.intel.com>
References: <1425458832-28777-1-git-send-email-jiang.liu@linux.intel.com> <1425458832-28777-2-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 04, 2015 04:47:12 PM Jiang Liu wrote:
> Some BIOSes report incorrect length for ACPI address space descriptors,
> so relax the checks to avoid regressions. This issue has appeared several
> times as:
> 3162b6f0c5e1 ("PNPACPI: truncate _CRS windows with _LEN > _MAX - _MIN + 1")
> d558b483d5a7 ("x86/PCI: truncate _CRS windows with _LEN > _MAX - _MIN + 1")
> f238b414a74a ("PNPACPI: compute Address Space length rather than using _LEN")
> 48728e077480 ("x86/PCI: compute Address Space length rather than using _LEN")
> 
> Please refer to https://bugzilla.kernel.org/show_bug.cgi?id=94221
> for more details and example malformed ACPI resource descriptors.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Tested-by: Dave Airlie <airlied@redhat.com>
> Tested-by: Prakash Punnoor <prakash@punnoor.de>

Queued up for 4.0-rc3, thanks!

Bjorn, please let me know if you have any objections.

> ---
>  drivers/acpi/resource.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index c723668e3e27..5589a6e2a023 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -42,8 +42,10 @@ static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
>  	 * CHECKME: len might be required to check versus a minimum
>  	 * length as well. 1 for io is fine, but for memory it does
>  	 * not make any sense at all.
> +	 * Note: some BIOSes report incorrect length for ACPI address space
> +	 * descriptor, so remove check of 'reslen == len' to avoid regression.
>  	 */
> -	if (len && reslen && reslen == len && start <= end)
> +	if (len && reslen && start <= end)
>  		return true;
>  
>  	pr_debug("ACPI: invalid or unassigned resource %s [%016llx - %016llx] length [%016llx]\n",
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
