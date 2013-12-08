Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1386476273-2418-1-git-send-email-rui.y.wang@intel.com>
References: <1386476273-2418-1-git-send-email-rui.y.wang@intel.com>
Date: Sun, 8 Dec 2013 13:09:31 +0800
Message-ID: <CABawtvPuanr5wDccf+uw6RssLTrob3dU2mOh58+KgKG0t9q4ew@mail.gmail.com>
Subject: Re: [PATCH] aerdrv: Fix severity usage in aer trace event
From: Ethan Zhao <ethan.kernel@gmail.com>
To: Rui Wang <ruiv.wang@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Lance Ortiz <lance.ortiz@hp.com>,
	Bjorn Helgaas <bhelgaas@google.com>, lance_ortiz@hotmail.com,
	jiang.liu@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
	linux-acpi@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, gong.chen@linux.intel.com,
	m.chehab@samsung.com, Rui Wang <rui.y.wang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rui,
  I like this patch.  thanks your revision.

Ethan

On Sun, Dec 8, 2013 at 12:17 PM, Rui Wang <ruiv.wang@gmail.com> wrote:
> There's inconsistency between dmesg and the trace event output.
> When dmesg says "severity=Corrected", the trace event says
> "severity=Fatal". What happens is that HW_EVENT_ERR_CORRECTED is
> defined in edac.h:
>
> enum hw_event_mc_err_type {
>         HW_EVENT_ERR_CORRECTED,
>         HW_EVENT_ERR_UNCORRECTED,
>         HW_EVENT_ERR_FATAL,
>         HW_EVENT_ERR_INFO,
> };
>
> while aer_print_error() uses aer_error_severity_string[] defined as:
>
> static const char *aer_error_severity_string[] = {
>         "Uncorrected (Non-Fatal)",
>         "Uncorrected (Fatal)",
>         "Corrected"
> };
>
> In this case dmesg is correct because info->severity is assigned in
> aer_isr_one_error() using the definitions in include/linux/ras.h:
>
> Signed-off-by: Rui Wang <rui.y.wang@intel.com>
> ---
>  include/trace/events/ras.h |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/ras.h b/include/trace/events/ras.h
> index 88b8783..1c875ad 100644
> --- a/include/trace/events/ras.h
> +++ b/include/trace/events/ras.h
> @@ -5,7 +5,7 @@
>  #define _TRACE_AER_H
>
>  #include <linux/tracepoint.h>
> -#include <linux/edac.h>
> +#include <linux/aer.h>
>
>
>  /*
> @@ -63,10 +63,10 @@ TRACE_EVENT(aer_event,
>
>         TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
>                 __get_str(dev_name),
> -               __entry->severity == HW_EVENT_ERR_CORRECTED ? "Corrected" :
> -                       __entry->severity == HW_EVENT_ERR_FATAL ?
> -                       "Fatal" : "Uncorrected",
> -               __entry->severity == HW_EVENT_ERR_CORRECTED ?
> +               __entry->severity == AER_CORRECTABLE ? "Corrected" :
> +                       __entry->severity == AER_FATAL ?
> +                       "Fatal" : "Uncorrected, non-fatal",
> +               __entry->severity == AER_CORRECTABLE ?
>                 __print_flags(__entry->status, "|", aer_correctable_errors) :
>                 __print_flags(__entry->status, "|", aer_uncorrectable_errors))
>  );
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
