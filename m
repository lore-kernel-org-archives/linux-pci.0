Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Aug 2015 17:44:18 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Spencer Baugh <sbaugh@catern.com>
Cc: Yijing Wang <wangyijing@huawei.com>, Joern Engel <joern@logfs.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Joern Engel <joern@purestorage.com>,
	Spencer Baugh <Spencer.baugh@purestorage.com>
Subject: Re: [PATCH] aer: add cond_resched to aer_isr
Message-ID: <20150803224418.GC11144@google.com>
References: <1437688476-3399-2-git-send-email-sbaugh@catern.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437688476-3399-2-git-send-email-sbaugh@catern.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Spencer & Joern,

On Thu, Jul 23, 2015 at 02:54:32PM -0700, Spencer Baugh wrote:
> From: Joern Engel <joern@logfs.org>
> 
> Multiple nested loops.  I have observed 590ms scheduler latency caused
> by this loop and interrupts.  Interrupts were responsible for 190ms, the
> rest could have been avoided with a cond_resched.

I'm not disagreeing with this patch, but it would be helpful to sketch
the outline of the "multiple nested loop" problem here.  This might be
a hint that we could do even better by rethinking the algorithm reduce
the nesting.

> Signed-off-by: Joern Engel <joern@logfs.org>
> Signed-off-by: Spencer Baugh <sbaugh@catern.com>
> ---
>  drivers/pci/pcie/aer/aerdrv_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 9803e3d..32b1b5c 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -780,8 +780,10 @@ void aer_isr(struct work_struct *work)
>  	struct aer_err_source uninitialized_var(e_src);
>  
>  	mutex_lock(&rpc->rpc_mutex);
> -	while (get_e_source(rpc, &e_src))
> +	while (get_e_source(rpc, &e_src)) {
>  		aer_isr_one_error(p_device, &e_src);
> +		cond_resched();
> +	}
>  	mutex_unlock(&rpc->rpc_mutex);
>  
>  	wake_up(&rpc->wait_release);
> -- 
> 2.5.0.rc3
> 
