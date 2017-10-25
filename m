Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbdJYVJC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Oct 2017 17:09:02 -0400
Date: Wed, 25 Oct 2017 16:09:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [pci:pci/resource 2/4] htmldocs: drivers/pci/pci.c:2979:
 warning: No description found for parameter 'pdev'
Message-ID: <20171025210900.GP21840@bhelgaas-glaptop.roam.corp.google.com>
References: <201710250939.0Us0UWZN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201710250939.0Us0UWZN%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 25, 2017 at 09:29:41AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
> head:   ca6a28653cfce7ad50c241d61409ce99fecca19f
> commit: 23ef8ffd84db01266d5b4dea61319b94ae12364b [2/4] PCI: Add resizable BAR infrastructure
> reproduce: make htmldocs
> 
> All warnings (new ones prefixed by >>):
> 
>    WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
>    kernel/trace/blktrace.c:824: warning: No description found for parameter 'cgid'
>    include/linux/sync_file.h:51: warning: No description found for parameter 'flags'
>    drivers/gpio/gpiolib.c:593: warning: No description found for parameter '16'
>    drivers/gpio/gpiolib.c:593: warning: Excess struct/union/enum/typedef member 'events' description in 'lineevent_state'
> >> drivers/pci/pci.c:2979: warning: No description found for parameter 'pdev'
> >> drivers/pci/pci.c:2979: warning: Excess function parameter 'dev' description in 'pci_rebar_find_pos'

I fixed these up for you, Christian.

>    drivers/pci/pci.c:3012: warning: No description found for parameter 'pdev'
> >> drivers/pci/pci.c:3012: warning: Excess function parameter 'dev' description in 'pci_rebar_get_possible_sizes'
>    drivers/pci/pci.c:3033: warning: No description found for parameter 'pdev'
> >> drivers/pci/pci.c:3033: warning: Excess function parameter 'dev' description in 'pci_rebar_get_current_size'
>    drivers/pci/pci.c:3055: warning: No description found for parameter 'pdev'
> >> drivers/pci/pci.c:3055: warning: Excess function parameter 'dev' description in 'pci_rebar_set_size'
>    include/linux/usb/gadget.h:232: warning: No description found for parameter 'claimed'
>    include/linux/usb/gadget.h:232: warning: No description found for parameter 'enabled'
>    include/linux/usb/gadget.h:414: warning: No description found for parameter 'quirk_altset_not_supp'
>    include/linux/usb/gadget.h:414: warning: No description found for parameter 'quirk_stall_not_supp'
>    include/linux/usb/gadget.h:414: warning: No description found for parameter 'quirk_zlp_not_supp'
>    fs/inode.c:1680: warning: No description found for parameter 'rcu'
>    include/linux/jbd2.h:443: warning: No description found for parameter 'i_transaction'
>    include/linux/jbd2.h:443: warning: No description found for parameter 'i_next_transaction'
>    include/linux/jbd2.h:443: warning: No description found for parameter 'i_list'
>    include/linux/jbd2.h:443: warning: No description found for parameter 'i_vfs_inode'
>    include/linux/jbd2.h:443: warning: No description found for parameter 'i_flags'
>    include/linux/jbd2.h:497: warning: No description found for parameter 'h_rsv_handle'
>    include/linux/jbd2.h:497: warning: No description found for parameter 'h_reserved'
>    include/linux/jbd2.h:497: warning: No description found for parameter 'h_type'
>    include/linux/jbd2.h:497: warning: No description found for parameter 'h_line_no'
>    include/linux/jbd2.h:497: warning: No description found for parameter 'h_start_jiffies'
>    include/linux/jbd2.h:497: warning: No description found for parameter 'h_requested_credits'
>    include/linux/jbd2.h:497: warning: No description found for parameter 'saved_alloc_context'
>    include/linux/jbd2.h:1050: warning: No description found for parameter 'j_chkpt_bhs'
>    include/linux/jbd2.h:1050: warning: No description found for parameter 'j_devname'
>    include/linux/jbd2.h:1050: warning: No description found for parameter 'j_average_commit_time'
>    include/linux/jbd2.h:1050: warning: No description found for parameter 'j_min_batch_time'
>    include/linux/jbd2.h:1050: warning: No description found for parameter 'j_max_batch_time'
>    include/linux/jbd2.h:1050: warning: No description found for parameter 'j_commit_callback'
>    include/linux/jbd2.h:1050: warning: No description found for parameter 'j_failed_commit'
>    include/linux/jbd2.h:1050: warning: No description found for parameter 'j_chksum_driver'
>    include/linux/jbd2.h:1050: warning: No description found for parameter 'j_csum_seed'
>    fs/jbd2/transaction.c:511: warning: No description found for parameter 'type'
>    fs/jbd2/transaction.c:511: warning: No description found for parameter 'line_no'
>    fs/jbd2/transaction.c:641: warning: No description found for parameter 'gfp_mask'
>    include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_pin'
>    include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_unpin'
>    include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_res_obj'
>    include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_get_sg_table'
>    include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_import_sg_table'
>    include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_vmap'
>    include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_vunmap'
>    include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_mmap'
>    include/drm/drm_mode_config.h:771: warning: No description found for parameter 'modifiers_property'
>    include/drm/drm_mode_config.h:771: warning: Excess struct/union/enum/typedef member 'modifiers' description in 'drm_mode_config'
>    include/drm/drm_plane.h:544: warning: No description found for parameter 'modifiers'
>    include/drm/drm_plane.h:544: warning: No description found for parameter 'modifier_count'
>    drivers/gpu/host1x/bus.c:50: warning: No description found for parameter 'driver'
>    Documentation/core-api/kernel-api.rst:354: ERROR: Error in "kernel-doc" directive:
>    unknown option: "external".
> 
> vim +/pdev +2979 drivers/pci/pci.c
> 
>   2967	
>   2968	/**
>   2969	 * pci_rebar_find_pos - find position of resize ctrl reg for BAR
>   2970	 * @dev: PCI device
>   2971	 * @bar: BAR to find
>   2972	 *
>   2973	 * Helper to find the position of the ctrl register for a BAR.
>   2974	 * Returns -ENOTSUPP if resizable BARs are not supported at all.
>   2975	 * Returns -ENOENT if no ctrl register for the BAR could be found.
>   2976	 */
>   2977	static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
>   2978	{
> > 2979		unsigned int pos, nbars, i;
>   2980		u32 ctrl;
>   2981	
>   2982		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
>   2983		if (!pos)
>   2984			return -ENOTSUPP;
>   2985	
>   2986		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>   2987		nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
>   2988			    PCI_REBAR_CTRL_NBAR_SHIFT;
>   2989	
>   2990		for (i = 0; i < nbars; i++, pos += 8) {
>   2991			int bar_idx;
>   2992	
>   2993			pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>   2994			bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
>   2995			if (bar_idx == bar)
>   2996				return pos;
>   2997		}
>   2998	
>   2999		return -ENOENT;
>   3000	}
>   3001	
>   3002	/**
>   3003	 * pci_rebar_get_possible_sizes - get possible sizes for BAR
>   3004	 * @dev: PCI device
>   3005	 * @bar: BAR to query
>   3006	 *
>   3007	 * Get the possible sizes of a resizable BAR as bitmask defined in the spec
>   3008	 * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
>   3009	 */
>   3010	u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>   3011	{
> > 3012		int pos;
>   3013		u32 cap;
>   3014	
>   3015		pos = pci_rebar_find_pos(pdev, bar);
>   3016		if (pos < 0)
>   3017			return 0;
>   3018	
>   3019		pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
>   3020		return (cap & PCI_REBAR_CAP_SIZES) >> 4;
>   3021	}
>   3022	
>   3023	/**
>   3024	 * pci_rebar_get_current_size - get the current size of a BAR
>   3025	 * @dev: PCI device
>   3026	 * @bar: BAR to set size to
>   3027	 *
>   3028	 * Read the size of a BAR from the resizable BAR config.
>   3029	 * Returns size if found or negative error code.
>   3030	 */
>   3031	int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
>   3032	{
> > 3033		int pos;
>   3034		u32 ctrl;
>   3035	
>   3036		pos = pci_rebar_find_pos(pdev, bar);
>   3037		if (pos < 0)
>   3038			return pos;
>   3039	
>   3040		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>   3041		return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> 8;
>   3042	}
>   3043	
>   3044	/**
>   3045	 * pci_rebar_set_size - set a new size for a BAR
>   3046	 * @dev: PCI device
>   3047	 * @bar: BAR to set size to
>   3048	 * @size: new size as defined in the spec (0=1MB, 19=512GB)
>   3049	 *
>   3050	 * Set the new size of a BAR as defined in the spec.
>   3051	 * Returns zero if resizing was successful, error code otherwise.
>   3052	 */
>   3053	int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
>   3054	{
> > 3055		int pos;
>   3056		u32 ctrl;
>   3057	
>   3058		pos = pci_rebar_find_pos(pdev, bar);
>   3059		if (pos < 0)
>   3060			return pos;
>   3061	
>   3062		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>   3063		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
>   3064		ctrl |= size << 8;
>   3065		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
>   3066		return 0;
>   3067	}
>   3068	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
