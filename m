Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:58120 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbdDQGqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2017 02:46:31 -0400
Date: Mon, 17 Apr 2017 08:46:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 17/20] PCI: Use cpu_hotplug_disable() instead of
 get_online_cpus()
Message-ID: <20170417064619.fjpizfsfd65dtear@hirez.programming.kicks-ass.net>
References: <20170415170107.643253702@linutronix.de>
 <20170415171652.675049942@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170415171652.675049942@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 15, 2017 at 07:01:24PM +0200, Thomas Gleixner wrote:
> +++ b/drivers/pci/pci-driver.c
> @@ -320,10 +320,19 @@ static long local_pci_probe(void *_ddi)
>  	return 0;
>  }
>  
> +static bool pci_physfn_is_probed(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_ATS
> +	return dev->physfn->is_probed;
> +#else
> +	return false;
> +#endif
> +}
> +

Should be in the next patch perhaps?
