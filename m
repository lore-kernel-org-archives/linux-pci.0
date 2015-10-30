Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1446162376-43419-7-git-send-email-jakeo@microsoft.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
	<1446162376-43419-7-git-send-email-jakeo@microsoft.com>
Date: Fri, 30 Oct 2015 02:44:43 +0200
Message-ID: <CAHp75VfcLVsESDT-KdjobcKVwSWUT=f1i_1PrET47tJ=rB91jA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] drivers:hv: Define the channel type for Hyper-V
 PCI Express pass-through
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: jakeo@microsoft.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kys@microsoft.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	Vitaly Kuznetsov <vkuznets@redhat.com>, tglx@redhat.com,
	haiyangz@microsoft.com, marc.zyngier@arm.com,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 1:46 AM,  <jakeo@microsoft.com> wrote:
> From: Jake Oshins <jakeo@microsoft.com>
>
> This defines the channel type for PCI front-ends in Hyper-V VMs.
>
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
>  include/linux/hyperv.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index ea0a0e3..5587899 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1140,6 +1140,17 @@ u64 hv_do_hypercall(u64 control, void *input, void *output);
>                 }
>
>  /*
> + * PCI Express Pass Through
> + * {44C4F61D-4444-4400-9D52-802E27EDE19F}
> + */
> +
> +#define HV_PCIE_GUID \
> +       .guid = { \
> +                       0x1D, 0xF6, 0xC4, 0x44, 0x44, 0x44, 0x00, 0x44, \
> +                       0x9D, 0x52, 0x80, 0x2E, 0x27, 0xED, 0xE1, 0x9F \
> +               }

What about
#include <linux/uuid.h>

UUID_LE(...)

And you may use uuid_le type instead of custom raw buffer.

> +
> +/*
>   * Common header for Hyper-V ICs
>   */
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
