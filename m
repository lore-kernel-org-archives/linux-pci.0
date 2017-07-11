Return-Path: <SRS0=ydXr=6O=intel.com=fengguang.wu@kernel.org>
Return-Path: <SRS0=ydXr=6O=intel.com=fengguang.wu@kernel.org>
Date: Tue, 11 Jul 2017 20:39:16 +0800
From: kbuild test robot <lkp@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: kbuild-all@01.org, helgaas@kernel.org, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v8 2/6] PCI: add resizeable BAR infrastructure v5
Message-ID: <201707112025.lWCyhuil%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
In-Reply-To: <1499698794-1718-3-git-send-email-deathsimple@vodafone.de>
List-ID: <linux-pci.vger.kernel.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

[auto build test WARNING on pci/next]
[also build test WARNING on v4.12 next-20170710]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christian-K-nig/PCI-add-a-define-for-the-PCI-resource-type-mask-v2/20170711-104904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   arch/x86/include/asm/uaccess_32.h:1: warning: no structured comments found
   include/linux/init.h:1: warning: no structured comments found
   include/linux/mod_devicetable.h:687: warning: Excess struct/union/enum/typedef member 'ver_major' description in 'fsl_mc_device_id'
   include/linux/mod_devicetable.h:687: warning: Excess struct/union/enum/typedef member 'ver_minor' description in 'fsl_mc_device_id'
   kernel/sched/core.c:2080: warning: No description found for parameter 'rf'
   kernel/sched/core.c:2080: warning: Excess function parameter 'cookie' description in 'try_to_wake_up_local'
   include/linux/wait.h:555: warning: No description found for parameter 'wq'
   include/linux/wait.h:555: warning: Excess function parameter 'wq_head' description in 'wait_event_interruptible_hrtimeout'
   include/linux/wait.h:759: warning: No description found for parameter 'wq_head'
   include/linux/wait.h:759: warning: Excess function parameter 'wq' description in 'wait_event_killable'
   include/linux/kthread.h:26: warning: Excess function parameter '...' description in 'kthread_create'
   kernel/sys.c:1: warning: no structured comments found
   Error: Cannot open file kernel/rcu/srcu.c
   Error: Cannot open file kernel/rcu/srcu.c
   WARNING: kernel-doc 'scripts/kernel-doc -rst -enable-lineno -export kernel/rcu/srcu.c' failed with return code 2
   include/linux/device.h:968: warning: No description found for parameter 'dma_ops'
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   include/linux/iio/iio.h:603: warning: No description found for parameter 'trig_readonly'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'indio_dev'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'trig'
   include/linux/device.h:969: warning: No description found for parameter 'dma_ops'
   drivers/ata/libata-eh.c:1449: warning: No description found for parameter 'link'
   drivers/ata/libata-eh.c:1449: warning: Excess function parameter 'ap' description in 'ata_eh_done'
   drivers/ata/libata-eh.c:1590: warning: No description found for parameter 'qc'
   drivers/ata/libata-eh.c:1590: warning: Excess function parameter 'dev' description in 'ata_eh_request_sense'
>> drivers/pci/pci.c:2970: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:2970: warning: Excess function parameter 'dev' description in 'pci_rbar_find_pos'
   drivers/pci/pci.c:3004: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:3004: warning: Excess function parameter 'dev' description in 'pci_rbar_get_possible_sizes'
   drivers/pci/pci.c:3026: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:3026: warning: Excess function parameter 'dev' description in 'pci_rbar_get_current_size'
   drivers/pci/pci.c:3049: warning: No description found for parameter 'pdev'
>> drivers/pci/pci.c:3049: warning: Excess function parameter 'dev' description in 'pci_rbar_set_size'
   arch/s390/include/asm/cmb.h:1: warning: no structured comments found
   drivers/scsi/scsi_lib.c:1116: warning: No description found for parameter 'rq'
   drivers/scsi/constants.c:1: warning: no structured comments found
   include/linux/usb/gadget.h:230: warning: No description found for parameter 'claimed'
   include/linux/usb/gadget.h:230: warning: No description found for parameter 'enabled'
   include/linux/usb/gadget.h:412: warning: No description found for parameter 'quirk_altset_not_supp'
   include/linux/usb/gadget.h:412: warning: No description found for parameter 'quirk_stall_not_supp'
   include/linux/usb/gadget.h:412: warning: No description found for parameter 'quirk_zlp_not_supp'
   fs/inode.c:1666: warning: No description found for parameter 'rcu'
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
   include/drm/drm_drv.h:537: warning: No description found for parameter 'set_busid'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'debugfs_init'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_open_object'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_close_object'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'prime_handle_to_fd'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'prime_fd_to_handle'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_export'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_import'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_pin'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_unpin'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_res_obj'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_get_sg_table'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_import_sg_table'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_vmap'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_vunmap'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_mmap'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_vm_ops'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'major'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'minor'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'patchlevel'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'name'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'desc'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'date'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'driver_features'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'ioctls'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'num_ioctls'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'fops'
   include/drm/drm_color_mgmt.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_syncobj.c:341: warning: Excess function parameter 'dev' description in 'drm_syncobj_open'
   drivers/gpu/drm/drm_syncobj.c:366: warning: Excess function parameter 'dev' description in 'drm_syncobj_release'
   include/drm/drm_syncobj.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_syncobj.c:342: warning: Excess function parameter 'dev' description in 'drm_syncobj_open'
   drivers/gpu/drm/drm_syncobj.c:367: warning: Excess function parameter 'dev' description in 'drm_syncobj_release'
   drivers/gpu/host1x/bus.c:50: warning: Excess function parameter 'driver' description in 'host1x_subdev_add'
   include/net/sock.h:479: warning: No description found for parameter 'sk_tsq_flags'
   include/net/sock.h:479: warning: No description found for parameter '__sk_flags_offset'
   include/net/sock.h:479: warning: No description found for parameter 'sk_uid'
   Documentation/doc-guide/sphinx.rst:121: ERROR: Unknown target name: "sphinx c domain".
   kernel/sched/fair.c:7584: WARNING: Inline emphasis start-string without end-string.
   kernel/time/timer.c:1200: ERROR: Unexpected indentation.
   kernel/time/timer.c:1202: ERROR: Unexpected indentation.
   kernel/time/timer.c:1203: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:108: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:111: ERROR: Unexpected indentation.
   include/linux/wait.h:113: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:991: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:323: WARNING: Inline literal start-string without end-string.
   kernel/rcu/tree.c:3187: ERROR: Unexpected indentation.
   kernel/rcu/tree.c:3214: ERROR: Unexpected indentation.
   kernel/rcu/tree.c:3215: WARNING: Bullet list ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:219: ERROR: Unexpected indentation.
   include/linux/iio/iio.h:220: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:226: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/iio/industrialio-core.c:633: ERROR: Unknown target name: "iio_val".
   drivers/iio/industrialio-core.c:640: ERROR: Unknown target name: "iio_val".
   drivers/ata/libata-core.c:5906: ERROR: Unknown target name: "hw".
   drivers/message/fusion/mptbase.c:5051: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1897: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/pci/pci.c:3574: ERROR: Unexpected indentation.
   include/linux/regulator/driver.h:271: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   include/linux/spi/spi.h:373: ERROR: Unexpected indentation.
   drivers/w1/w1_io.c:196: WARNING: Definition list ends without a blank line; unexpected unindent.
   block/bio.c:407: ERROR: Unknown target name: "gfp".
   drivers/gpu/drm/drm_scdc_helper.c:203: ERROR: Unexpected indentation.
   drivers/gpu/drm/drm_scdc_helper.c:204: WARNING: Block quote ends without a blank line; unexpected unindent.
   drivers/gpu/drm/drm_ioctl.c:702: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/gpu/todo.rst:111: ERROR: Unknown target name: "drm_fb".

vim +/pdev +2970 drivers/pci/pci.c

  2958	
  2959	/**
  2960	 * pci_rbar_find_pos - find position of resize ctrl reg for BAR
  2961	 * @dev: PCI device
  2962	 * @bar: BAR to find
  2963	 *
  2964	 * Helper to find the postion of the ctrl register for a BAR.
  2965	 * Returns -ENOTSUPP of resizeable BARs are not supported at all.
  2966	 * Returns -ENOENT if not ctrl register for the BAR could be found.
  2967	 */
  2968	static int pci_rbar_find_pos(struct pci_dev *pdev, int bar)
  2969	{
> 2970		unsigned int pos, nbars;
  2971		unsigned int i;
  2972		u32 ctrl;
  2973	
  2974		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
  2975		if (!pos)
  2976			return -ENOTSUPP;
  2977	
  2978		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  2979		nbars = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
  2980	
  2981		for (i = 0; i < nbars; ++i, pos += 8) {
  2982			int bar_idx;
  2983	
  2984			pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  2985			bar_idx = (ctrl & PCI_REBAR_CTRL_BAR_IDX_MASK) >>
  2986					PCI_REBAR_CTRL_BAR_IDX_SHIFT;
  2987			if (bar_idx == bar)
  2988				return pos;
  2989		}
  2990	
  2991		return -ENOENT;
  2992	}
  2993	
  2994	/**
  2995	 * pci_rbar_get_possible_sizes - get possible sizes for BAR
  2996	 * @dev: PCI device
  2997	 * @bar: BAR to query
  2998	 *
  2999	 * Get the possible sizes of a resizeable BAR as bitmask defined in the spec
  3000	 * (bit 0=1MB, bit 19=512GB). Returns 0 if BAR isn't resizeable.
  3001	 */
  3002	u32 pci_rbar_get_possible_sizes(struct pci_dev *pdev, int bar)
  3003	{
> 3004		u32 cap;
  3005		int pos;
  3006	
  3007		pos = pci_rbar_find_pos(pdev, bar);
  3008		if (pos < 0)
  3009			return 0;
  3010	
  3011		pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
  3012		return (cap & PCI_REBAR_CTRL_SIZES_MASK) >>
  3013			PCI_REBAR_CTRL_SIZES_SHIFT;
  3014	}
  3015	
  3016	/**
  3017	 * pci_rbar_get_current_size - get the current size of a BAR
  3018	 * @dev: PCI device
  3019	 * @bar: BAR to set size to
  3020	 *
  3021	 * Read the size of a BAR from the resizeable BAR config.
  3022	 * Returns size if found or negative error code.
  3023	 */
  3024	int pci_rbar_get_current_size(struct pci_dev *pdev, int bar)
  3025	{
> 3026		u32 ctrl;
  3027		int pos;
  3028	
  3029		pos = pci_rbar_find_pos(pdev, bar);
  3030		if (pos < 0)
  3031			return pos;
  3032	
  3033		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  3034		return (ctrl & PCI_REBAR_CTRL_BAR_SIZE_MASK) >>
  3035			PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
  3036	}
  3037	
  3038	/**
  3039	 * pci_rbar_set_size - set a new size for a BAR
  3040	 * @dev: PCI device
  3041	 * @bar: BAR to set size to
  3042	 * @size: new size as defined in the spec (0=1MB, 19=512GB)
  3043	 *
  3044	 * Set the new size of a BAR as defined in the spec.
  3045	 * Returns zero if resizing was successful, error code otherwise.
  3046	 */
  3047	int pci_rbar_set_size(struct pci_dev *pdev, int bar, int size)
  3048	{
> 3049		u32 ctrl;
  3050		int pos;
  3051	
  3052		pos = pci_rbar_find_pos(pdev, bar);
  3053		if (pos < 0)
  3054			return pos;
  3055	
  3056		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
  3057		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE_MASK;
  3058		ctrl |= size << PCI_REBAR_CTRL_BAR_SIZE_SHIFT;
  3059		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
  3060		return 0;
  3061	}
  3062	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--pWyiEgJYm5f9v55/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--pWyiEgJYm5f9v55/--
