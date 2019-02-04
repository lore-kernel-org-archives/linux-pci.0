Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04395C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 11:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76E92073D
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 11:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfBDKrP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:9228 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbfBDKrO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:14 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 02:47:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="112232562"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 04 Feb 2019 02:47:11 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Feb 2019 12:47:10 +0200
Date:   Mon, 4 Feb 2019 12:47:10 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20190204104710.GU7875@lahna.fi.intel.com>
References: <PS2P216MB0642603E54D081F0DB349F5280930@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642603E54D081F0DB349F5280930@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Please indicate in the $subject that this is second version of the
patch as explained in:

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

For example here the $subject should look like

  [PATCH v2] PCI: Consider alignment of hot-added bridges...

You can use

  git format-patch --subject-prefix="PATCH v2" ...

to generate such patch.

On Sat, Feb 02, 2019 at 04:25:02PM +0000, Nicholas Johnson wrote:
> New systems with Thunderbolt are starting to use native PCI enumeration.
> Mika Westerberg's patch "PCI: Distribute available resources to hotplug
> capable PCIe downstream ports"
> (https://patchwork.kernel.org/patch/9972155/) adds code to expand
> downstream PCI hotplug bridges to consume all remaining resource space
> in the parent bridge. It is a crucial patch for supporting Thunderbolt
> native enumeration on Linux.
> 
> However, it does not consider bridge alignment in all cases, which rules
> out hot-adding an external graphics processor at the end of a
> Thunderbolt daisy chain. Hot-adding such a device will likely fail to
> work with the existing code. It also might disrupt the operation of
> existing devices or prevent the subsequent hot-plugging of lower aligned
> devices if the kernel frees and reallocates upstream resources to
> attempt assign the resources that failed to assign in the first pass. By
> Intel's ruling, Thunderbolt external graphics processors are generally
> meant to function only as the first and only device in the chain.
> However, there is no technical reason that prevents it from being
> possible if sufficient resources are available, and people are likely to
> attempt such configurations with Thunderbolt devices if they own such
> hardware. Hence, I argue that we should improve the user experience and
> reduce the number of constraints placed on the user by always
> considering resource alignment, which will make such configurations
> possible.
> 
> The other problem with the patch is that it is incompatible with
> resources allocated by "pci=hpmemsize=nnM" due to a check which does not
> allow for dev_res->add_size to be reduced. This check also makes a big
> assumption that the hpmemsize is small but non-zero, and no action has
> been taken to ensure that. In the current state, any bridge smaller than
> hpmemsize will likely fail to size correctly, which will cause major
> issues if the default were to change, or if the user also wants to
> configure non-Thunderbolt hotplug bridges simultaneously. I argue that
> if assumptions and limitations can be removed with no risks and adverse
> effects, then it should be done.
> 
> The former problem is solved by rewriting the
> pci_bus_distribute_available_resources() function with more information
> passed in the arguments, eliminating assumptions about the initial
> bridge alignment. My patch makes no assumptions about the alignment of
> hot-added bridges, allowing for any device to be hot-added, given
> sufficient resources are available.
> 
> The latter problem is solved by removing the check preventing the
> shrinking of dev_res->add_size, which allows for the distribution of
> resources if hpmemsize is non-zero. It can be made to work with zero
> hpmemsize with two-line patches in pbus_size_mem() and pbus_size_io(),
> or by modifying extend_bridge_window() to add a new entry to the
> additional resource list if one does not exist. In theory, and by my
> testing, the removal of this check does not affect the functionality of
> the resource distribution with firmware-allocated resources. But it does
> enable the same functionality when using pci=hpmemsize=nnM, which was
> not possible prior. This may be one piece of the puzzle needed to
> support Thunderbolt add-in cards that support native PCI enumeration,
> without any platform dependencies.
> 
> I have tested this proposed patch extensively. Using Linux-allocated
> resources, it works perfectly. I have two Gigabyte GC-TITAN RIDGE
> Thunderbolt 3 add-in cards in my desktop, and a Dell XPS 9370 with the
> Dell XPS 9380 Thunderbolt NVM40 firmware flashed. My peripherals are
> three HP ZBook Thunderbolt 3 docks, two external graphics enclosures
> with AMD Fiji XT in both, a Promise SANLink3 N1 (AQC107S), and a Dell
> Thunderbolt 3 NVMe SSD. All configurations of these devices worked well,
> and I can no longer make it fail if I try to. My testing with
> firmware-allocated resources is limited due to using computers with
> Alpine Ridge BIOS support. However, I did get manage to test the patch
> with firmware-allocated resources by enabling the Alpine Ridge BIOS
> support and forcing pcie_ports=native, and the results were perfect.
> 
> Mika Westerberg has agreed to test this on an official platform with
> native enumeration firmware support to be sure that it works in this
> situation. It is also appropriate that he reviews these changes as he
> wrote the original code and any changes made to Thunderbolt-critical
> code cannot be allowed to break any of the base requirements for
> Thunderbolt. I would like to thank him for putting up with my emails and
> trying to help where he can, and for the great work he has done on
> Thunderbolt in Linux.
> 
> I have more patches in the pipeline to further improve the Thunderbolt
> experience on Linux on platforms without BIOS support. This is the most
> technical but least user-facing one planned. The most exciting changes
> are yet to come.
> 
> Edits:

These should be put below '---' in the patch as described in

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

> I have made code styling changes as suggested by Mika Westerberg.
> 
> I have been testing Thunderbolt devices with my other host card which
> happens to be in SL0 mode. This means that devices are discovered much
> more quickly. I noticed that multiple devices can be enumerated
> together, rather than each getting enumerated before the next appears.
> It turns out that this can break the allocation, but I have absolutely
> no idea why. I have modified the patch to solve this problem. Before,
> extend_bridge_window() used add_size to change the resource size. Now it
> simply changes the size of the actual resource, and clears the add_size
> to zero if a list entry exists. That solves the issue, and proves that
> the calculated resource sizes are not at fault (the algorithm is sound).
> Hence, I recommend this version with the modification be applied.

You should split that into a separate patch as it is different issue
AFAICT. Furthermore I think it may be good idea to spend more time
investigating and hopefully root causing the problem.
