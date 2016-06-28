Return-Path: <cov@codeaurora.org>
Return-Path: <cov@codeaurora.org>
Subject: Re: [RFC PATCH v4 3/5] PCI: Check platform specific ECAM quirks
To: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org, arnd@arndb.de,
 will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
 hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
 jchandra@broadcom.com
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
 <1467100442-28078-4-git-send-email-tn@semihalf.com>
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com,
 ddaney@caviumnetworks.com, wangyijing@huawei.com, msalter@redhat.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org,
 dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com,
 gabriele.paoloni@huawei.com, jhugo@codeaurora.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
From: Christopher Covington <cov@codeaurora.org>
Message-ID: <577275EA.7010002@codeaurora.org>
Date: Tue, 28 Jun 2016 09:04:42 -0400
MIME-Version: 1.0
In-Reply-To: <1467100442-28078-4-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

On 06/28/2016 03:54 AM, Tomasz Nowicki wrote:

> diff --git a/drivers/pci/host/mcfg-quirks.c b/drivers/pci/host/mcfg-quirks.c
> new file mode 100644
> index 0000000..fb2b184
> --- /dev/null
> +++ b/drivers/pci/host/mcfg-quirks.c
> @@ -0,0 +1,88 @@

> +static bool pci_mcfg_fixup_match(struct pci_cfg_fixup *f,
> +				 struct acpi_table_header *mcfg_header)
> +{
> +	int olen = min_t(u8, strlen(f->oem_id), ACPI_OEM_ID_SIZE);
> +	int tlen = min_t(u8, strlen(f->oem_table_id), ACPI_OEM_TABLE_ID_SIZE);
> +
> +	return (!strncmp(f->oem_id, mcfg_header->oem_id, olen) &&
> +		!strncmp(f->oem_table_id, mcfg_header->oem_table_id, tlen) &&
> +		f->oem_revision == mcfg_header->oem_revision);
> +}

Ard's comments on v3 included:

"... exact OEM table/rev id matches ..."
"... substring match ... out of the question ..."

I originally advocated the substring match approach because
space-padding the input strings was unfamiliar. But given that some
vendors have a "PLAT    " then "PLAT2   " naming scheme, where the
former needs quirks and the latter (hopefully) doesn't, I agree with Ard
and think space-padded inputs is the better way to go. Sorry for the
lack of foresight.

(I'm happy to rip it out, test, and communicate the delta however you'd
prefer--just let me know.)

Regards,
Cov

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
