Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Jake Oshins <jakeo@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
CC: Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH v2 06/12] drivers:hv: Export do_hypercall()
Date: Tue, 15 Sep 2015 23:27:29 +0000
Message-ID: <BY2PR0301MB165498EE3FC07D57AE99A984A05C0@BY2PR0301MB1654.namprd03.prod.outlook.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
 <1441929670-10058-7-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-7-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: jakeo@microsoft.com [mailto:jakeo@microsoft.com]
> Sent: Thursday, September 10, 2015 5:01 PM
> To: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; linux-pci@vger.kernel.org;
> bhelgaas@google.com; tglx@linutronix.de
> Cc: Jake Oshins <jakeo@microsoft.com>
> Subject: [PATCH v2 06/12] drivers:hv: Export do_hypercall()
> 
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch exposes the function that hv_vmbus.ko uses to make hypercalls.
> This
> is necessary for retargeting an interrupt when it is given a new affinity.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
>  drivers/hv/hv.c        | 3 ++-
>  include/linux/hyperv.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 6341be8..6d01649 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -91,7 +91,7 @@ static int query_hypervisor_info(void)
>  /*
>   * do_hypercall- Invoke the specified hypercall
>   */
> -static u64 do_hypercall(u64 control, void *input, void *output)
> +u64 do_hypercall(u64 control, void *input, void *output)

do_hypercall() is not an appropriate name for a function to be exported. I plan to take the base
vmbus patches through Greg's tree and if it is ok with you, I will change the name of this function.

Regards,

K. Y
