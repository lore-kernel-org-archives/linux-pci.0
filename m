Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A8C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4C9218FD
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfAaRbv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:31:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:41037 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfAaRbv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 12:31:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 09:31:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="140503477"
Received: from jprestwo.jf.intel.com ([10.54.74.69])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2019 09:31:50 -0800
Message-ID: <75816515f1675f819b993eb96b84becd418ab271.camel@linux.intel.com>
Subject: BCM43602 + PCI passthrough causing freeze
From:   James Prestwood <james.prestwood@linux.intel.com>
To:     linux-pci@vger.kernel.org
Date:   Thu, 31 Jan 2019 09:36:58 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I posted about a month ago on linux-wireless about an Ath9k card that
was causing my host machine to freeze/lock up when doing PCI
passthrough into a VM. This was resolved by adding:

DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034,
quirk_no_bus_reset);

to drivers/pci/quirks.c and rebuilding the host kernel.

Original thread: 
https://marc.info/?l=linux-wireless&m=154689580213002&w=2

I am now trying to get this BCM43602 card working under the same
conditions but again I am seeing the host machine freeze when starting
the VM. I did try adding a similar line for this card, which actually
prevented the machine from freezing, but I am seeing this when starting
the VM:

qemu-system-x86_64: vfio: Cannot reset device 0000:0a:00.0, no
available reset mechanism.

And once inside the VM the device is UNCLAIMED and not usable:

$ lshw -C network

*-network:2 UNCLAIMED
       description: Network controller
       product: BCM43602 802.11ac Wireless LAN SoC
       vendor: Broadcom Limited
       physical id: 6
       bus info: pci@0000:00:06.0
       version: 01
       width: 64 bits
       clock: 33MHz
       capabilities: pm msi pciexpress cap_list
       configuration: latency=0
       resources: memory:fe890000-fe897fff memory:fe400000-fe7fffff

This change was really a shot in the dark as I only have a vague
understanding of what its actually doing. I see other entries in
quirks.c for the Broadcom vendor ID but would rather not go poking
around here without any direction.

Thanks,
James

