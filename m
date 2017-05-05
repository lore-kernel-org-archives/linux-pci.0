Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 5 May 2017 10:55:17 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [stable-4.10: PATCH] xen: revert commits 72a9b186292 and
 da72ff5bfcb0
Message-ID: <20170505175517.GF11379@kroah.com>
References: <138b4286-1308-8394-b9e1-0791075949c8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <138b4286-1308-8394-b9e1-0791075949c8@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 05, 2017 at 10:00:36AM +0200, Juergen Gross wrote:
> Revert commit 72a9b186292 ("xen: Remove event channel notification
> through Xen PCI platform device") as the original analysis was wrong
> that all the removed code isn't in use any more. As commit da72ff5bfcb0
> ("partially revert xen: Remove event channel notification through Xen
> PCI platform device") reverted already some parts of it revert this
> commit, too.
> 
> It is still necessary for old Xen versions (< 4.0) and for being able
> to run the Linux kernel as dom0 in a nested Xen environment.
> 
> Upstream commit is 84d582d236dc1f9085e741affc72e9ba061a67c2.
> 
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Julien Grall <julien.grall@arm.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Ross Lagerwall <ross.lagerwall@citrix.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: Anthony Liguori <aliguori@amazon.com>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> Please apply to stable-4.10.y and stable-4.11.y
> ---
>  arch/x86/include/asm/xen/events.h | 11 +++++++++++
>  arch/x86/pci/xen.c                |  2 +-
>  arch/x86/xen/enlighten.c          | 21 +++++++++++++++------
>  arch/x86/xen/smp.c                |  2 ++
>  arch/x86/xen/time.c               |  5 +++++
>  drivers/xen/events/events_base.c  | 26 +++++++++++++++++---------
>  drivers/xen/platform-pci.c        | 13 +++----------
>  include/xen/xen.h                 |  3 ++-
>  8 files changed, 56 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/include/asm/xen/events.h
> b/arch/x86/include/asm/xen/events.h
> index 608a79d5a466..e6911caf5bbf 100644
> --- a/arch/x86/include/asm/xen/events.h
> +++ b/arch/x86/include/asm/xen/events.h
> @@ -20,4 +20,15 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
>  /* No need for a barrier -- XCHG is a barrier on x86. */
>  #define xchg_xen_ulong(ptr, val) xchg((ptr), (val))
>  +extern int xen_have_vector_callback;
> +
> +/*
> + * Events delivered via platform PCI interrupts are always
> + * routed to vcpu 0 and hence cannot be rebound.
> + */
> +static inline bool xen_support_evtchn_rebind(void)
> +{
> +	return (!xen_hvm_domain() || xen_have_vector_callback);
> +}
> +
>  #endif /* _ASM_X86_XEN_EVENTS_H */
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 292ab0364a89..c4b3646bd04c 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -447,7 +447,7 @@ void __init xen_msi_init(void)
>   int __init pci_xen_hvm_init(void)
>  {
> -	if (!xen_feature(XENFEAT_hvm_pirqs))
> +	if (!xen_have_vector_callback || !xen_feature(XENFEAT_hvm_pirqs))
>  		return 0;
>   #ifdef CONFIG_ACPI
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index 51ef95232725..6623867cc0d4 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -137,6 +137,8 @@ struct shared_info xen_dummy_shared_info;
>  void *xen_initial_gdt;
>   RESERVE_BRK(shared_info_page_brk, PAGE_SIZE);
> +__read_mostly int xen_have_vector_callback;
> +EXPORT_SYMBOL_GPL(xen_have_vector_callback);
>   static int xen_cpu_up_prepare(unsigned int cpu);
>  static int xen_cpu_up_online(unsigned int cpu);
> @@ -1508,7 +1510,10 @@ static void __init xen_pvh_early_guest_init(void)
>  	if (!xen_feature(XENFEAT_auto_translated_physmap))
>  		return;
>  -	BUG_ON(!xen_feature(XENFEAT_hvm_callback_vector));
> +	if (!xen_feature(XENFEAT_hvm_callback_vector))
> +		return;
> +
> +	xen_have_vector_callback = 1;
>   	xen_pvh_early_cpu_init(0, false);
>  	xen_pvh_set_cr_flags(0);
> @@ -1847,7 +1852,9 @@ static int xen_cpu_up_prepare(unsigned int cpu)
>  		xen_vcpu_setup(cpu);
>  	}
>  -	if (xen_pv_domain() || xen_feature(XENFEAT_hvm_safe_pvclock))
> +	if (xen_pv_domain() ||
> +	    (xen_have_vector_callback &&
> +	     xen_feature(XENFEAT_hvm_safe_pvclock)))
>  		xen_setup_timer(cpu);
>   	rc = xen_smp_intr_init(cpu);
> @@ -1863,7 +1870,9 @@ static int xen_cpu_dead(unsigned int cpu)
>  {
>  	xen_smp_intr_free(cpu);
>  -	if (xen_pv_domain() || xen_feature(XENFEAT_hvm_safe_pvclock))
> +	if (xen_pv_domain() ||
> +	    (xen_have_vector_callback &&
> +	     xen_feature(XENFEAT_hvm_safe_pvclock)))
>  		xen_teardown_timer(cpu);
>   	return 0;
> @@ -1902,8 +1911,8 @@ static void __init xen_hvm_guest_init(void)
>   	xen_panic_handler_init();
>  -	BUG_ON(!xen_feature(XENFEAT_hvm_callback_vector));
> -
> +	if (xen_feature(XENFEAT_hvm_callback_vector))
> +		xen_have_vector_callback = 1;
>  	xen_hvm_smp_init();
>  	WARN_ON(xen_cpuhp_setup());
>  	xen_unplug_emulated_devices();
> @@ -1941,7 +1950,7 @@ bool xen_hvm_need_lapic(void)
>  		return false;
>  	if (!xen_hvm_domain())
>  		return false;
> -	if (xen_feature(XENFEAT_hvm_pirqs))
> +	if (xen_feature(XENFEAT_hvm_pirqs) && xen_have_vector_callback)
>  		return false;
>  	return true;
>  }
> diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
> index 311acad7dad2..137afbbd0590 100644
> --- a/arch/x86/xen/smp.c
> +++ b/arch/x86/xen/smp.c
> @@ -765,6 +765,8 @@ static void __init xen_hvm_smp_prepare_cpus(unsigned
> int max_cpus)
>   void __init xen_hvm_smp_init(void)
>  {
> +	if (!xen_have_vector_callback)
> +		return;
>  	smp_ops.smp_prepare_cpus = xen_hvm_smp_prepare_cpus;
>  	smp_ops.smp_send_reschedule = xen_smp_send_reschedule;
>  	smp_ops.cpu_die = xen_cpu_die;
> diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> index 1e69956d7852..4535627cf532 100644
> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -432,6 +432,11 @@ static void xen_hvm_setup_cpu_clockevents(void)
>   void __init xen_hvm_init_time_ops(void)
>  {
> +	/* vector callback is needed otherwise we cannot receive interrupts
> +	 * on cpu > 0 and at this point we don't know how many cpus are
> +	 * available */
> +	if (!xen_have_vector_callback)
> +		return;
>  	if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
>  		printk(KERN_INFO "Xen doesn't support pvclock on HVM,"
>  				"disable pv timer\n");
> diff --git a/drivers/xen/events/events_base.c
> b/drivers/xen/events/events_base.c
> index fd8e872d2943..86199f31bc57 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -1312,6 +1312,9 @@ static int rebind_irq_to_cpu(unsigned irq,
> unsigned tcpu)

Your patch is line-wrapped and can not be applied :(

can you fix this up and resend both this, and the 4.9 patch?

thanks,

greg k-h
