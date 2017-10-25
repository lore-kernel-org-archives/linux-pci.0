Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:18583 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751861AbdJYBa3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Oct 2017 21:30:29 -0400
Date: Wed, 25 Oct 2017 09:29:41 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [pci:pci/resource 2/4] htmldocs: drivers/pci/pci.c:2979: warning: No
 description found for parameter 'pdev'
Message-ID: <201710250939.0Us0UWZN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/resource
head:   ca6a28653cfce7ad50c241d61409ce99fecca19f
commit: 23ef8ffd84db01266d5b4dea61319b94ae12364b [2/4] PCI: Add resizable BAR infrastructure
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   kernel/trace/blktrace.c:824: warning: No description found for parameter 'cgid'
   include/linux/sync_file.h:51: warning: No description found for parameter 'flags'
   drivers/gpio/gpiolib.c:593: warning: No description found for parameter '16'
   drivers/gpio/gpiolib.c:593: warning: Excess struct/union/enum/typedef member 'events' description in 'lineevent_state'
>> drivers/pci/pci.c:2979: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:2979: warning: Excess function parameter 'dev' description in 'pci_rebar_find_pos'
   drivers/pci/pci.c:3012: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:3012: warning: Excess function parameter 'dev' description in 'pci_rebar_get_possible_sizes'
   drivers/pci/pci.c:3033: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:3033: warning: Excess function parameter 'dev' description in 'pci_rebar_get_current_size'
   drivers/pci/pci.c:3055: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:3055: warning: Excess function parameter 'dev' description in 'pci_rebar_set_size'
   include/linux/usb/gadget.h:232: warning: No description found for parameter 'claimed'
   include/linux/usb/gadget.h:232: warning: No description found for parameter 'enabled'
   include/linux/usb/gadget.h:414: warning: No description found for parameter 'quirk_altset_not_supp'
   include/linux/usb/gadget.h:414: warning: No description found for parameter 'quirk_stall_not_supp'
   include/linux/usb/gadget.h:414: warning: No description found for parameter 'quirk_zlp_not_supp'
   fs/inode.c:1680: warning: No description found for parameter 'rcu'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_transaction'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_next_transaction'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_list'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_vfs_inode'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_flags'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_rsv_handle'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_reserved'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_type'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_line_no'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_start_jiffies'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_requested_credits'
   include/linux/jbd2.h:497: warning: No description found for parameter 'saved_alloc_context'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_chkpt_bhs'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_devname'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_average_commit_time'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_min_batch_time'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_max_batch_time'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_commit_callback'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_failed_commit'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_chksum_driver'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_csum_seed'
   fs/jbd2/transaction.c:511: warning: No description found for parameter 'type'
   fs/jbd2/transaction.c:511: warning: No description found for parameter 'line_no'
   fs/jbd2/transaction.c:641: warning: No description found for parameter 'gfp_mask'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_pin'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_unpin'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_res_obj'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_get_sg_table'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_import_sg_table'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_vmap'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_vunmap'
   include/drm/drm_drv.h:594: warning: No description found for parameter 'gem_prime_mmap'
   include/drm/drm_mode_config.h:771: warning: No description found for parameter 'modifiers_property'
   include/drm/drm_mode_config.h:771: warning: Excess struct/union/enum/typedef member 'modifiers' description in 'drm_mode_config'
   include/drm/drm_plane.h:544: warning: No description found for parameter 'modifiers'
   include/drm/drm_plane.h:544: warning: No description found for parameter 'modifier_count'
   drivers/gpu/host1x/bus.c:50: warning: No description found for parameter 'driver'
   Documentation/core-api/kernel-api.rst:354: ERROR: Error in "kernel-doc" directive:
   unknown option: "external".

vim +/pdev +2979 drivers/pci/pci.c

  2967	
  2968	/**
  2969	 * pci_rebar_find_pos - find position of resize ctrl reg for BAR
  2970	 * @dev: PCI device
  2971	 * @bar: BAR to find
  2972	 *
  2973	 * Helper to find the position of the ctrl register for a BAR.
  2974	 * Returns -ENOTSUPP if resizable BARs are not supported at all.
  2975	 * Returns -ENOENT if no ctrl register for the BAR could be found.
  2976	 */
  2977	static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
  2978	{
> 2979		unsigned int pos, nbars, i;
  2980		u32 ctrl;
  2981	
  2982		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
  2983		if (!pos)
  2984			return -ENOTSUPP;
  2985	
  2986		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  2987		nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >>
  2988			    PCI_REBAR_CTRL_NBAR_SHIFT;
  2989	
  2990		for (i = 0; i < nbars; i++, pos += 8) {
  2991			int bar_idx;
  2992	
  2993			pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  2994			bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
  2995			if (bar_idx == bar)
  2996				return pos;
  2997		}
  2998	
  2999		return -ENOENT;
  3000	}
  3001	
  3002	/**
  3003	 * pci_rebar_get_possible_sizes - get possible sizes for BAR
  3004	 * @dev: PCI device
  3005	 * @bar: BAR to query
  3006	 *
  3007	 * Get the possible sizes of a resizable BAR as bitmask defined in the spec
  3008	 * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizable.
  3009	 */
  3010	u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
  3011	{
> 3012		int pos;
  3013		u32 cap;
  3014	
  3015		pos = pci_rebar_find_pos(pdev, bar);
  3016		if (pos < 0)
  3017			return 0;
  3018	
  3019		pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
  3020		return (cap & PCI_REBAR_CAP_SIZES) >> 4;
  3021	}
  3022	
  3023	/**
  3024	 * pci_rebar_get_current_size - get the current size of a BAR
  3025	 * @dev: PCI device
  3026	 * @bar: BAR to set size to
  3027	 *
  3028	 * Read the size of a BAR from the resizable BAR config.
  3029	 * Returns size if found or negative error code.
  3030	 */
  3031	int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
  3032	{
> 3033		int pos;
  3034		u32 ctrl;
  3035	
  3036		pos = pci_rebar_find_pos(pdev, bar);
  3037		if (pos < 0)
  3038			return pos;
  3039	
  3040		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  3041		return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> 8;
  3042	}
  3043	
  3044	/**
  3045	 * pci_rebar_set_size - set a new size for a BAR
  3046	 * @dev: PCI device
  3047	 * @bar: BAR to set size to
  3048	 * @size: new size as defined in the spec (0=1MB, 19=512GB)
  3049	 *
  3050	 * Set the new size of a BAR as defined in the spec.
  3051	 * Returns zero if resizing was successful, error code otherwise.
  3052	 */
  3053	int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
  3054	{
> 3055		int pos;
  3056		u32 ctrl;
  3057	
  3058		pos = pci_rebar_find_pos(pdev, bar);
  3059		if (pos < 0)
  3060			return pos;
  3061	
  3062		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  3063		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
  3064		ctrl |= size << 8;
  3065		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
  3066		return 0;
  3067	}
  3068	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICODm71kAAy5jb25maWcAjFxbc9s4sn6fX8GaOQ8zD0l8i8dTp/wAgaCIMW8hQEn2C0uR
mUQVW/LqMpP8+9MNkOKtoT1btbsxunHvy9eNpn775TePHQ/b1+VhvVq+vPz0vlabarc8VM/e
l/VL9b+en3pJqj3hS/0emKP15vjjw/r67ta7eX958/7i3W517T1Uu0314vHt5sv66xG6r7eb
X34Ddp4mgZyWtzcTqb313ttsD96+OvxSty/ubsvrq/ufnb/bP2SidF5wLdOk9AVPfZG3xLTQ
WaHLIM1jpu9/rV6+XF+9w2X92nCwnIfQL7B/3v+63K2+ffhxd/thZVa5N5son6sv9u9Tvyjl
D77ISlVkWZrrdkqlGX/QOeNiTIvjov3DzBzHLCvzxC9h56qMZXJ/d47OFveXtzQDT+OM6f86
To+tN1wihF+qaenHrIxEMtVhu9apSEQueSkVQ/qYEM6FnIZ6uDv2WIZsJsqMl4HPW2o+VyIu
FzycMt8vWTRNc6nDeDwuZ5Gc5EwLuKOIPQ7GD5kqeVaUOdAWFI3xUJSRTOAu5JNoOcyilNBF
VmYiN2OwXHT2ZQ6jIYl4An8FMle65GGRPDj4MjYVNJtdkZyIPGFGUrNUKTmJxIBFFSoTcEsO
8pwlugwLmCWL4a5CWDPFYQ6PRYZTR5PRHEYqVZlmWsZwLD7oEJyRTKYuTl9MiqnZHotA8Hua
CJpZRuzpsZwqV/ciy9OJ6JADuSgFy6NH+LuMRefes6lmsG8QwJmI1P1V037SULhNBZr84WX9
+cPr9vn4Uu0//E+RsFigFAimxIf3A1WV+adynuad65gUMvJh86IUCzuf6umpDkEY8FiCFP6n
1ExhZ2OqpsbwvaB5Or5BSzNinj6IpITtqDjrGiepS5HM4EBw5bHU99enPfEcbtkopISb/vXX
1hDWbaUWirKHcAUsmolcgST1+nUJJSt0SnQ2ov8Agiiicvoks4FS1JQJUK5oUvTUNQBdyuLJ
1SN1EW5aQn9Npz11F9TdzpABl3WOvng63zs9T74hjhKEkhURaGSqNErg/a+/b7ab6o/OjahH
NZMZJ8e29w/in+aPJdPgN0KSLwhZ4keCpBVKgIF0XbNRQ1aAU4Z1gGhEjRSDSnj74+f9z/2h
em2l+GTmQWOMzhIeAEgqTOcdGYcWcLAc7IjVm54hURnLlUCmto2j81RpAX3AYGke+unQ9HRZ
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
6v9/cedutQphAAA=

--+HP7ph2BbKc20aGI--
