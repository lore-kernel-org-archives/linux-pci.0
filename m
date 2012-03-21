Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56869 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab2CUDZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 23:25:17 -0400
Received: by pbcun15 with SMTP id un15so483782pbc.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 20:25:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332260463-13924-4-git-send-email-jiang.liu@huawei.com>
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
	<1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
	<1332260463-13924-4-git-send-email-jiang.liu@huawei.com>
Date: Tue, 20 Mar 2012 20:25:17 -0700
Message-ID: <CAE9FiQX9NJ4n09_OWJVf7n579=JWDUi+XF79aMKUFunCXL3PJw@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86,IRQ: Mark unused entries in 'ioapics' array as
 free at startup
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 20, 2012 at 9:20 AM, Jiang Liu <liuj97@gmail.com> wrote:
> Unused entries in ioapics array should be marked as free at startup,
> so they could be used by hot-added IOAPICs.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
>  arch/x86/kernel/apic/io_apic.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 7412eb8..622374f 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -392,6 +392,10 @@ int __init arch_early_irq_init(void)
>                cpumask_set_cpu(0, cfg->domain);
>        }
>
> +       /* Mark all left entries as free for IOAPIC hot-adding. */
> +       for (i = nr_ioapics; i < MAX_IO_APICS; i++)
> +               ioapics[i].mp_config.apicid = 0xff;
> +
>        return 0;
>  }

this one looks like not needed, we did not search that after
nr_ioapics, and just use nr_ioapics if open spot is found.

Yinghai
