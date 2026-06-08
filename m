Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4553E7152;
	Mon,  8 Jun 2026 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948274; cv=none; b=ZVOD9m8tZvR+yLbEL/ktj7Vq/sB/b/ZQAKL7yOQId4mqLKxtq5EQlNyqayzqJfK5qepau4ooUuIkFJ5ytQ4dl5K41JVdNYrLI/AlGjdhhb/1PMNisgFraJZXZsAQ0gmYWGyl0xLRxyY5XsPPwEzNcqJzm7ha4pnBojBNmgd2q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948274; c=relaxed/simple;
	bh=vZqpmUHMPM9z8XVPka+6VMEsyIkJJOVlY5ksqy1j+YM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N3WQVmYoEOV+hcmZ6tk4HYq6FKlS2QPKE2phzKXdL6ilQ6ySvkvISjmIR5pFbj1O3gO30tUsL52lIYbhw/JwVFrOpccJ7GoDlQZ0qoYyO6VLXtgqolNZS97R+42189yhwm3qWkD1IEuCDlKTJ32FOh8QlMy7TgttdDtE2pPUQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhiioOmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhiioOmD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4271C1F00893;
	Mon,  8 Jun 2026 19:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780948273;
	bh=HWI3lYltOURtuNSadXFdyeN0c201nRTmOqQqLlPE4n8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UhiioOmDjSmHToMkHm2lzlTOH7o986t1N15jQeSCuB9SoaLTZAGmoICWgFr5Uz5uq
	 wHdBJ6T9S6S9LzGYMxVR7iOlp0NTokyVyLLZxPCDtW11U3jMkwSex9xlVL4HZQsyx6
	 T2X/WNCmNC0GOX2K6SjeXslUrYt8PQ7IH4Xe6mXNxq/IDXVQU3TCvE2h6+zMI5Qc+7
	 8O+zNWUghhp2yzDsabJWAgZePs6RxLqrcBi6Lzn3owqdMIeWa+btpH6bGGFeqkcZKO
	 S2dMVM7uGRn2oqzOybEIg4yNEXTKZC3LS4mgywBrxhUECcorrPoLHP9k0YogJD4mrs
	 2z4t/GvW0nfgA==
Date: Mon, 8 Jun 2026 14:51:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v3] PCI: Call local_pci_probe() directly if current CPU
 is in the right node
Message-ID: <20260608195111.GA46568@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607221103.703133-1-longman@redhat.com>

[+cc Thomas, Frederic, Danilo, Tejun, driver-core]

On Sun, Jun 07, 2026 at 06:11:03PM -0400, Waiman Long wrote:
> local_pci_probe() and hence pci_call_probe() can be called
> recursively.

Can we say something about the scenario that results in a recursive
call?  Based on the stack trace and the comment below, I guess two of
the scenarios are:

  - vmd_probe() creates a new hierarchy below the VMD endpoint and
    enumerates it.  The pci_bus_add_device() in vmd_enable_domain()
    calls .probe() for devices below VMD.

  - A PF .probe() calls pci_enable_sriov(), which enables VFs, and the
    pci_bus_add_device() in pci_iov_add_virtfn() calls .probe() for
    new VFs.

Possible commit log text:

  local_pci_probe() and hence pci_call_probe() can be called
  recursively, e.g., when vmd_probe() calls .probe() for devices in
  the new hierarchy below VMD or a PF .probe() enables VFs and calls
  .probe() for them.

> If the recursive calls are done indirectly via workqueue
> kworker, a lockdep recursive warning can be produced.

For non-workqueue experts like me, can we mention the reason why the
warning only affects the workqueue indirect case?

And maybe include a line or two of the actual lockdep warning to help
search engines find this?  The stacktrace is good info, but not
specific to the warning.

> Below is the
> stack trace of the lockdep warning on a 4-socket x86-64 Skylake server.
> 
>   <TASK>
>     :
>   start_flush_work+0x40b/0x9b0
>   __flush_work+0xbd/0x1a0
>   pci_call_probe+0x510/0x700
>   pci_device_probe+0x17c/0x270
>   call_driver_probe+0x68/0x1f0
>   really_probe+0x197/0x7b0
>   __driver_probe_device+0x32d/0x460
>   driver_probe_device+0x49/0x120
>   __device_attach_driver+0x162/0x290
>   bus_for_each_drv+0x109/0x190
>   __device_attach+0x1a2/0x3f0
>   device_initial_probe+0x7d/0xa0
>   pci_bus_add_device+0x93/0xe0
>   pci_bus_add_devices+0x83/0x190
>   vmd_enable_domain+0x11fb/0x1b80
>   vmd_probe+0x34c/0x4b0
>   local_pci_probe+0xdf/0x190
>   local_pci_probe_callback+0x35/0x80
>   process_one_work+0x919/0x1af0
>   worker_thread+0x5a6/0xd10
>     :
>   </TASK>
> 
> The use of work function originally comes from commit 873392ca514f
> ("PCI: work_on_cpu: use in drivers/pci/pci-driver.c") to execute the
> device probing and allocate memory on the right node where the device
> bus is attached to.
> 
> In the case of nested device probing within a work function, the current
> CPU is likely to be in the right node already. So there is no point in
> scheduling another work function in the same or a neigboring CPU and wait
> for its completion. It will be more efficient to call local_pci_probe()
> directly when the current CPU is indeed in the right node. That will
> also avoid the lockdep warning due to nested calls to schedule and
> flush a work function.

Out of scope for this patch, but none of the CPU/node selection is
PCI-specific, and neither is the housekeeping cpuset and RCU stuff.

I think this would be improved if we could move the NUMA affinity and
async probe scheduling up to the driver core.  There was a little
discussion of that here:

  https://lore.kernel.org/linux-pci/20251231165503.GA159243@bhelgaas/

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  drivers/pci/pci-driver.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index e3f59001785a..542b22537852 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -375,6 +375,8 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  {
>  	int error, node, cpu;
>  	struct drv_dev_and_id ddi = { drv, dev, id };
> +	bool node_invalid, cpu_in_node = false;
> +	const struct cpumask *node_cpus;
>  
>  	/*
>  	 * Execute driver initialization on node where the device is
> @@ -383,14 +385,27 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  	 */
>  	node = dev_to_node(&dev->dev);
>  	dev->is_probed = 1;
> +	node_invalid = node < 0 || node >= MAX_NUMNODES || !node_online(node);
> +	node_cpus = node_invalid ? cpu_online_mask : cpumask_of_node(node);
> +
> +	/*
> +	 * If the current task is a wq kworker activated by queue_work_on()
> +	 * below, the kworker is affined to a designated CPU and won't be
> +	 * switched to another one. So the current CPU can be checked to see
> +	 * if it is in the right node.
> +	 */
> +	if (current->flags & PF_WQ_WORKER) {
> +		cpu_in_node = cpumask_test_cpu(get_cpu(), node_cpus);
> +		put_cpu();
> +	}
>  
>  	cpu_hotplug_disable();
>  	/*
>  	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
> -	 * device is probed from work_on_cpu() of the Physical device.
> +	 * device is probed from work_on_cpu() of the Physical device or when
> +	 * the current CPU is in the desired node.

Since we're updating this comment, let's change "Physical device" to
"Physical Function" at the same time to match the spec terminology.

>  	 */
> -	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
> -	    pci_physfn_is_probed(dev)) {
> +	if (node_invalid || cpu_in_node || pci_physfn_is_probed(dev)) {
>  		error = local_pci_probe(&ddi);
>  	} else {
>  		struct pci_probe_arg arg = { .ddi = &ddi };
> @@ -404,8 +419,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  		 * targets.
>  		 */
>  		rcu_read_lock();
> -		cpu = cpumask_any_and(cpumask_of_node(node),
> -				      housekeeping_cpumask(HK_TYPE_DOMAIN));
> +		cpu = cpumask_any_and(node_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
>  
>  		if (cpu < nr_cpu_ids) {
>  			struct workqueue_struct *wq = pci_probe_wq;
> -- 
> 2.54.0
> 
