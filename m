Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANVTcTYJS3eAUA4bHVCrKgz=7rQpJZHCiBcw3JM=j0FbCsgQJw@mail.gmail.com>
References: <20130116235102.16015.77379.stgit@grignak.americas.hpqcorp.net>
	<CANVTcTaP18CiGOSEcX5Ch_wPw9mEhkgokfp+d+ZOMFD+Ce4juA@mail.gmail.com>
	<20131204203837.GA7517@pd.tnic>
	<CANVTcTYJS3eAUA4bHVCrKgz=7rQpJZHCiBcw3JM=j0FbCsgQJw@mail.gmail.com>
Date: Fri, 6 Dec 2013 23:11:07 +0800
Message-ID: <CABawtvPz5sZxhFnQru8Uc6UwF-O8HyGred_RWqBBeT615Qj8sQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] aerdrv: Trace Event for AER
From: Ethan Zhao <ethan.kernel@gmail.com>
To: rui wang <ruiv.wang@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Lance Ortiz <lance.ortiz@hp.com>,
	Bjorn Helgaas <bhelgaas@google.com>, lance_ortiz@hotmail.com,
	jiang.liu@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
	mchehab@redhat.com, linux-acpi@vger.kernel.org,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, gong.chen@intel.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 6, 2013 at 5:06 PM, rui wang <ruiv.wang@gmail.com> wrote:
> On 12/5/13, Borislav Petkov <bp@alien8.de> wrote:
>
>> Yes, the AER tracepoint above should use the AER_* defines and not the
>> HW_EVENT_ERR_* ones which are for memory errors.
>>
>> Wanna send a fix?
>>
>
> Yes. Does it translate into something like this?
>
> From: Rui Wang <rui.y.wang@intel.com>
> Date: Fri, 6 Dec 2013 16:47:46 +0800
> Subject: [PATCH] Fix severity usage in aer trace event
>
> Signed-off-by: Rui Wang <rui.y.wang@intel.com>
> ---
>  include/trace/events/ras.h |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/trace/events/ras.h b/include/trace/events/ras.h
> index 88b8783..e2a17d8 100644
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
> +               __entry->severity == AER_CORRECTABLE ? "Corrected" :
> +                       __entry->severity == AER_FATAL ?
>                         "Fatal" : "Uncorrected",

Why not             "Fatal" : "Non-fatal",   ?  per the PCIe spec,
'Fatal' and 'Non-fatal' are sub-category of "
Uncorrected". But here "Uncorrected" means "Non-fatal".

Thanks,
Ethan

> -               __entry->severity == HW_EVENT_ERR_CORRECTED ?
> +               __entry->severity == AER_CORRECTABLE ?
>                 __print_flags(__entry->status, "|", aer_correctable_errors) :
>                 __print_flags(__entry->status, "|", aer_uncorrectable_errors))
>  );
> --
> 1.7.5.4
>
> Regards,
> Rui
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
