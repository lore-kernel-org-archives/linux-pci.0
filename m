Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 4 Dec 2012 10:22:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Lance Ortiz <lance.ortiz@hp.com>
Cc: bhelgaas@google.com, lance_ortiz@hotmail.com, jiang.liu@huawei.com,
	tony.luck@intel.com, rostedt@goodmis.org, mchehab@redhat.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] aerdrv: Trace Event for AER
Message-ID: <20121204092204.GF4369@liondog.tnic>
References: <20121203212047.24373.8646.stgit@grignak.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20121203212047.24373.8646.stgit@grignak.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 03, 2012 at 02:20:48PM -0700, Lance Ortiz wrote:
> This header file will define a new trace event that will be triggered when
> a AER event occurs.  The following data will be provided to the trace
> event.
> 
> char * dev_name - The name of the slot where the device resides
>                   ([domain:]bus:device.function).
> 
> u32 status - Either the correctable or uncorrectable register
>              indicating what error or errors have been see.
> 
> u8 severity - error severity 0:NONFATAL 1:FATAL 2:CORRECTED
> 
> The trace event will also provide a trace string that may look like:
> 
> "0000:05:00.0 PCIe Bus Error:severity=Uncorrected (Non-Fatal), Poisoned
> TLP"
> 
> v1-v2 Move header from include/ras/aer_event.h to
> include/trace/events/ras.h
> v3-v4 Cleaned up comments and commit header
> v4-v5 More cleanup remove () from if statement in print.
>       Renamed string define to be more specific.
> Signed-off-by: Lance Ortiz <lance.ortiz@hp.com>
> ---
> 
>  include/trace/events/ras.h |   78 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 78 insertions(+), 0 deletions(-)
>  create mode 100644 include/trace/events/ras.h
> 
> diff --git a/include/trace/events/ras.h b/include/trace/events/ras.h
> new file mode 100644
> index 0000000..e6f123e
> --- /dev/null
> +++ b/include/trace/events/ras.h
> @@ -0,0 +1,78 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM aer_event
> +#define TRACE_INCLUDE_FILE ras

Whoops, I somehow missed that the last time:

TRACE_SYSTEM should be "ras" and then you don't need to define
TRACE_INCLUDE_FILE at all.

Thanks.

-- 
Regards/Gruss,
    Boris.
