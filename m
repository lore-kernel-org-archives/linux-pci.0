Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1172C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A922082F
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfBDP2G (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:28:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:29268 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbfBDP2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:28:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 07:28:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="gz'50?scan'50,208,50";a="123815378"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2019 07:28:01 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gqgAC-0008xj-Gt; Mon, 04 Feb 2019 23:28:00 +0800
Date:   Mon, 4 Feb 2019 23:27:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     kbuild-all@01.org,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <201902042322.W4WIZR8T%fengguang.wu@intel.com>
References: <PS2P216MB0642603E54D081F0DB349F5280930@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642603E54D081F0DB349F5280930@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v5.0-rc4 next-20190204]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Johnson/PCI-Consider-alignment-of-hot-added-bridges-when-distributing-available-resources/20190204-182638
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: i386-randconfig-s0-02041749 (attached as .config)
compiler: gcc-6 (Debian 6.5.0-2) 6.5.0 20181026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/pci.h:31:0,
                    from drivers/pci/setup-bus.c:20:
   drivers/pci/setup-bus.c: In function 'extend_bridge_window':
   drivers/pci/setup-bus.c:1831:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
     pci_dbg(bridge, "bridge window %pR extended by 0x%016llx\n", res,
                     ^
   include/linux/device.h:1380:22: note: in definition of macro 'dev_fmt'
    #define dev_fmt(fmt) fmt
                         ^~~
>> include/linux/pci.h:2362:36: note: in expansion of macro 'dev_dbg'
    #define pci_dbg(pdev, fmt, arg...) dev_dbg(&(pdev)->dev, fmt, ##arg)
                                       ^~~~~~~
>> drivers/pci/setup-bus.c:1831:2: note: in expansion of macro 'pci_dbg'
     pci_dbg(bridge, "bridge window %pR extended by 0x%016llx\n", res,
     ^~~~~~~
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_read
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:__ffs
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u32
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 1 include/linux/list.h:list_empty
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_read
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_read
   Cyclomatic Complexity 1 include/linux/ioport.h:resource_size
   Cyclomatic Complexity 1 include/linux/ioport.h:resource_type
   Cyclomatic Complexity 3 include/linux/slab.h:kmalloc_type
   Cyclomatic Complexity 56 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 67 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 7 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
   Cyclomatic Complexity 1 include/linux/pci.h:pci_is_root_bus
   Cyclomatic Complexity 1 include/linux/pci.h:pci_is_bridge
   Cyclomatic Complexity 1 include/linux/pci.h:pci_is_enabled
   Cyclomatic Complexity 1 arch/x86/include/asm/pci.h:pci_domain_nr
   Cyclomatic Complexity 2 include/linux/acpi.h:acpi_device_handle
   Cyclomatic Complexity 1 drivers/pci/pci.h:pci_has_subordinate
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:reset_resource
   Cyclomatic Complexity 2 drivers/pci/setup-bus.c:pci_fail_res_type_mask
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:pci_realloc_enabled
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:pci_realloc_detect
   Cyclomatic Complexity 7 drivers/pci/setup-bus.c:pci_bridge_check_ranges
   Cyclomatic Complexity 4 drivers/pci/setup-bus.c:res_to_dev_res
   Cyclomatic Complexity 2 drivers/pci/setup-bus.c:get_res_add_size
   Cyclomatic Complexity 2 drivers/pci/setup-bus.c:get_res_add_align
   Cyclomatic Complexity 7 drivers/pci/setup-bus.c:calculate_iosize
   Cyclomatic Complexity 6 drivers/pci/setup-bus.c:calculate_mem_align
   Cyclomatic Complexity 7 drivers/pci/setup-bus.c:calculate_memsize
   Cyclomatic Complexity 17 drivers/pci/setup-bus.c:pci_need_to_release
   Cyclomatic Complexity 12 include/linux/ioport.h:resource_contains
   Cyclomatic Complexity 4 drivers/pci/setup-bus.c:pci_bus_get_depth
   Cyclomatic Complexity 5 drivers/pci/setup-bus.c:extend_bridge_window
   Cyclomatic Complexity 3 arch/x86/include/asm/div64.h:div_u64_rem
   Cyclomatic Complexity 1 include/linux/math64.h:div_u64
   Cyclomatic Complexity 3 drivers/pci/setup-bus.c:pci_setup_bridge_mmio
   Cyclomatic Complexity 5 drivers/pci/setup-bus.c:pci_setup_bridge_mmio_pref
   Cyclomatic Complexity 5 drivers/pci/setup-bus.c:pci_setup_bridge_io
   Cyclomatic Complexity 7 drivers/pci/setup-bus.c:__pci_setup_bridge
   Cyclomatic Complexity 10 drivers/pci/setup-bus.c:pci_claim_device_resources
   Cyclomatic Complexity 4 drivers/pci/setup-bus.c:pci_bus_allocate_dev_resources
   Cyclomatic Complexity 2 include/linux/list.h:__list_add
   Cyclomatic Complexity 1 include/linux/list.h:list_add
   Cyclomatic Complexity 3 drivers/pci/setup-bus.c:add_to_list
   Cyclomatic Complexity 23 drivers/pci/setup-bus.c:pci_bus_size_cardbus
   Cyclomatic Complexity 1 include/linux/list.h:list_add_tail
   Cyclomatic Complexity 22 drivers/pci/setup-bus.c:find_free_bus_resource
   Cyclomatic Complexity 14 drivers/pci/setup-bus.c:pci_bus_dump_res
   Cyclomatic Complexity 4 drivers/pci/setup-bus.c:pci_bus_dump_resources
   Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
   Cyclomatic Complexity 1 include/linux/list.h:list_move_tail
   Cyclomatic Complexity 1 include/linux/list.h:list_del
   Cyclomatic Complexity 4 drivers/pci/setup-bus.c:remove_from_list
   Cyclomatic Complexity 2 drivers/pci/setup-bus.c:free_list
   Cyclomatic Complexity 15 drivers/pci/setup-bus.c:assign_requested_resources_sorted
   Cyclomatic Complexity 12 drivers/pci/setup-bus.c:reassign_resources_sorted
   Cyclomatic Complexity 8 drivers/pci/setup-bus.c:assign_fixed_resource_on_bus
   Cyclomatic Complexity 15 drivers/pci/setup-bus.c:pdev_assign_fixed_resources
   Cyclomatic Complexity 20 drivers/pci/setup-bus.c:pci_bridge_release_resources
   Cyclomatic Complexity 13 drivers/pci/setup-bus.c:pci_bus_release_bridge_resources
   Cyclomatic Complexity 9 drivers/pci/setup-bus.c:pci_setup_cardbus
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:pcibios_setup_bridge
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:pci_setup_bridge
   Cyclomatic Complexity 11 drivers/pci/setup-bus.c:pci_claim_bridge_resource
   Cyclomatic Complexity 10 drivers/pci/setup-bus.c:pci_claim_bridge_resources
   Cyclomatic Complexity 4 drivers/pci/setup-bus.c:pci_bus_allocate_resources
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:pcibios_window_alignment
   Cyclomatic Complexity 7 drivers/pci/setup-bus.c:window_alignment
   Cyclomatic Complexity 5 drivers/pci/setup-bus.c:pci_cardbus_resource_alignment
   Cyclomatic Complexity 5 drivers/pci/pci.h:pci_resource_alignment
   Cyclomatic Complexity 34 drivers/pci/setup-bus.c:pbus_size_io
   Cyclomatic Complexity 55 drivers/pci/setup-bus.c:pbus_size_mem
   Cyclomatic Complexity 18 drivers/pci/setup-bus.c:pdev_sort_resources
   Cyclomatic Complexity 7 drivers/pci/setup-bus.c:__dev_sort_resources
   Cyclomatic Complexity 26 drivers/pci/setup-bus.c:__assign_resources_sorted
   Cyclomatic Complexity 2 drivers/pci/setup-bus.c:pbus_assign_resources_sorted
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:pdev_assign_resources_sorted
   Cyclomatic Complexity 61 drivers/pci/setup-bus.c:pci_bus_distribute_available_resources
   Cyclomatic Complexity 3 drivers/pci/setup-bus.c:pci_bridge_distribute_available_resources
   Cyclomatic Complexity 22 drivers/pci/setup-bus.c:__pci_bus_size_bridges
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:pci_bus_size_bridges
   Cyclomatic Complexity 7 drivers/pci/setup-bus.c:__pci_bus_assign_resources
   Cyclomatic Complexity 5 drivers/pci/setup-bus.c:__pci_bridge_assign_resources
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:pci_bus_assign_resources
   Cyclomatic Complexity 1 drivers/pci/setup-bus.c:pci_bus_claim_resources
   Cyclomatic Complexity 3 drivers/pci/setup-bus.c:pci_realloc_get_opt
   Cyclomatic Complexity 19 drivers/pci/setup-bus.c:pci_assign_unassigned_root_bus_resources
   Cyclomatic Complexity 5 drivers/pci/setup-bus.c:pci_assign_unassigned_resources
   Cyclomatic Complexity 10 drivers/pci/setup-bus.c:pci_assign_unassigned_bridge_resources
   Cyclomatic Complexity 21 drivers/pci/setup-bus.c:pci_reassign_bridge_resources
   Cyclomatic Complexity 4 drivers/pci/setup-bus.c:pci_assign_unassigned_bus_resources
--
   In file included from include/linux/pci.h:31:0,
                    from drivers//pci/setup-bus.c:20:
   drivers//pci/setup-bus.c: In function 'extend_bridge_window':
   drivers//pci/setup-bus.c:1831:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
     pci_dbg(bridge, "bridge window %pR extended by 0x%016llx\n", res,
                     ^
   include/linux/device.h:1380:22: note: in definition of macro 'dev_fmt'
    #define dev_fmt(fmt) fmt
                         ^~~
>> include/linux/pci.h:2362:36: note: in expansion of macro 'dev_dbg'
    #define pci_dbg(pdev, fmt, arg...) dev_dbg(&(pdev)->dev, fmt, ##arg)
                                       ^~~~~~~
   drivers//pci/setup-bus.c:1831:2: note: in expansion of macro 'pci_dbg'
     pci_dbg(bridge, "bridge window %pR extended by 0x%016llx\n", res,
     ^~~~~~~
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_read
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:__ffs
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u32
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 1 include/linux/list.h:list_empty
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:arch_atomic_read
   Cyclomatic Complexity 1 include/asm-generic/atomic-instrumented.h:atomic_read
   Cyclomatic Complexity 1 include/linux/ioport.h:resource_size
   Cyclomatic Complexity 1 include/linux/ioport.h:resource_type
   Cyclomatic Complexity 3 include/linux/slab.h:kmalloc_type
   Cyclomatic Complexity 56 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 67 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 7 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
   Cyclomatic Complexity 1 include/linux/pci.h:pci_is_root_bus
   Cyclomatic Complexity 1 include/linux/pci.h:pci_is_bridge
   Cyclomatic Complexity 1 include/linux/pci.h:pci_is_enabled
   Cyclomatic Complexity 1 arch/x86/include/asm/pci.h:pci_domain_nr
   Cyclomatic Complexity 2 include/linux/acpi.h:acpi_device_handle
   Cyclomatic Complexity 1 drivers//pci/pci.h:pci_has_subordinate
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:reset_resource
   Cyclomatic Complexity 2 drivers//pci/setup-bus.c:pci_fail_res_type_mask
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:pci_realloc_enabled
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:pci_realloc_detect
   Cyclomatic Complexity 7 drivers//pci/setup-bus.c:pci_bridge_check_ranges
   Cyclomatic Complexity 4 drivers//pci/setup-bus.c:res_to_dev_res
   Cyclomatic Complexity 2 drivers//pci/setup-bus.c:get_res_add_size
   Cyclomatic Complexity 2 drivers//pci/setup-bus.c:get_res_add_align
   Cyclomatic Complexity 7 drivers//pci/setup-bus.c:calculate_iosize
   Cyclomatic Complexity 6 drivers//pci/setup-bus.c:calculate_mem_align
   Cyclomatic Complexity 7 drivers//pci/setup-bus.c:calculate_memsize
   Cyclomatic Complexity 17 drivers//pci/setup-bus.c:pci_need_to_release
   Cyclomatic Complexity 12 include/linux/ioport.h:resource_contains
   Cyclomatic Complexity 4 drivers//pci/setup-bus.c:pci_bus_get_depth
   Cyclomatic Complexity 5 drivers//pci/setup-bus.c:extend_bridge_window
   Cyclomatic Complexity 3 arch/x86/include/asm/div64.h:div_u64_rem
   Cyclomatic Complexity 1 include/linux/math64.h:div_u64
   Cyclomatic Complexity 3 drivers//pci/setup-bus.c:pci_setup_bridge_mmio
   Cyclomatic Complexity 5 drivers//pci/setup-bus.c:pci_setup_bridge_mmio_pref
   Cyclomatic Complexity 5 drivers//pci/setup-bus.c:pci_setup_bridge_io
   Cyclomatic Complexity 7 drivers//pci/setup-bus.c:__pci_setup_bridge
   Cyclomatic Complexity 10 drivers//pci/setup-bus.c:pci_claim_device_resources
   Cyclomatic Complexity 4 drivers//pci/setup-bus.c:pci_bus_allocate_dev_resources
   Cyclomatic Complexity 2 include/linux/list.h:__list_add
   Cyclomatic Complexity 1 include/linux/list.h:list_add
   Cyclomatic Complexity 3 drivers//pci/setup-bus.c:add_to_list
   Cyclomatic Complexity 23 drivers//pci/setup-bus.c:pci_bus_size_cardbus
   Cyclomatic Complexity 1 include/linux/list.h:list_add_tail
   Cyclomatic Complexity 22 drivers//pci/setup-bus.c:find_free_bus_resource
   Cyclomatic Complexity 14 drivers//pci/setup-bus.c:pci_bus_dump_res
   Cyclomatic Complexity 4 drivers//pci/setup-bus.c:pci_bus_dump_resources
   Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
   Cyclomatic Complexity 1 include/linux/list.h:list_move_tail
   Cyclomatic Complexity 1 include/linux/list.h:list_del
   Cyclomatic Complexity 4 drivers//pci/setup-bus.c:remove_from_list
   Cyclomatic Complexity 2 drivers//pci/setup-bus.c:free_list
   Cyclomatic Complexity 15 drivers//pci/setup-bus.c:assign_requested_resources_sorted
   Cyclomatic Complexity 12 drivers//pci/setup-bus.c:reassign_resources_sorted
   Cyclomatic Complexity 8 drivers//pci/setup-bus.c:assign_fixed_resource_on_bus
   Cyclomatic Complexity 15 drivers//pci/setup-bus.c:pdev_assign_fixed_resources
   Cyclomatic Complexity 20 drivers//pci/setup-bus.c:pci_bridge_release_resources
   Cyclomatic Complexity 13 drivers//pci/setup-bus.c:pci_bus_release_bridge_resources
   Cyclomatic Complexity 9 drivers//pci/setup-bus.c:pci_setup_cardbus
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:pcibios_setup_bridge
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:pci_setup_bridge
   Cyclomatic Complexity 11 drivers//pci/setup-bus.c:pci_claim_bridge_resource
   Cyclomatic Complexity 10 drivers//pci/setup-bus.c:pci_claim_bridge_resources
   Cyclomatic Complexity 4 drivers//pci/setup-bus.c:pci_bus_allocate_resources
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:pcibios_window_alignment
   Cyclomatic Complexity 7 drivers//pci/setup-bus.c:window_alignment
   Cyclomatic Complexity 5 drivers//pci/setup-bus.c:pci_cardbus_resource_alignment
   Cyclomatic Complexity 5 drivers//pci/pci.h:pci_resource_alignment
   Cyclomatic Complexity 34 drivers//pci/setup-bus.c:pbus_size_io
   Cyclomatic Complexity 55 drivers//pci/setup-bus.c:pbus_size_mem
   Cyclomatic Complexity 18 drivers//pci/setup-bus.c:pdev_sort_resources
   Cyclomatic Complexity 7 drivers//pci/setup-bus.c:__dev_sort_resources
   Cyclomatic Complexity 26 drivers//pci/setup-bus.c:__assign_resources_sorted
   Cyclomatic Complexity 2 drivers//pci/setup-bus.c:pbus_assign_resources_sorted
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:pdev_assign_resources_sorted
   Cyclomatic Complexity 61 drivers//pci/setup-bus.c:pci_bus_distribute_available_resources
   Cyclomatic Complexity 3 drivers//pci/setup-bus.c:pci_bridge_distribute_available_resources
   Cyclomatic Complexity 22 drivers//pci/setup-bus.c:__pci_bus_size_bridges
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:pci_bus_size_bridges
   Cyclomatic Complexity 7 drivers//pci/setup-bus.c:__pci_bus_assign_resources
   Cyclomatic Complexity 5 drivers//pci/setup-bus.c:__pci_bridge_assign_resources
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:pci_bus_assign_resources
   Cyclomatic Complexity 1 drivers//pci/setup-bus.c:pci_bus_claim_resources
   Cyclomatic Complexity 3 drivers//pci/setup-bus.c:pci_realloc_get_opt
   Cyclomatic Complexity 19 drivers//pci/setup-bus.c:pci_assign_unassigned_root_bus_resources
   Cyclomatic Complexity 5 drivers//pci/setup-bus.c:pci_assign_unassigned_resources
   Cyclomatic Complexity 10 drivers//pci/setup-bus.c:pci_assign_unassigned_bridge_resources

vim +/pci_dbg +1831 drivers/pci/setup-bus.c

  1816	
  1817	static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
  1818				struct list_head *add_list, resource_size_t available)
  1819	{
  1820		struct pci_dev_resource *dev_res;
  1821	
  1822		if (res->parent)
  1823			return;
  1824	
  1825		/*
  1826		 * Hot-adding multiple Thunderbolt devices in SL0 might result in
  1827		 * multiple devices being enumerated together. This can break the
  1828		 * resource allocation if the resource sizes are specified with
  1829		 * add_size instead of simply changing the resource size.
  1830		*/
> 1831		pci_dbg(bridge, "bridge window %pR extended by 0x%016llx\n", res,
  1832			available - resource_size(res));
  1833		res->end = res->start + available - 1;
  1834	
  1835		/*
  1836		 * If a list entry exists, we need to remove any additional size
  1837		 * requested because that could interfere with the alignment and
  1838		 * sizing done when distributing resources, causing resources to
  1839		 * fail to allocate later on.
  1840		 */
  1841		dev_res = res_to_dev_res(add_list, res);
  1842		if (!dev_res)
  1843			return;
  1844	
  1845		dev_res->add_size = 0;
  1846	}
  1847	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--UugvWAfsgieZRqgk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/wdo+Bji5K4BAA==

--UugvWAfsgieZRqgk--
