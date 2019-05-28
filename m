Return-Path: <SRS0=lVEW=T4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8531EC04AB3
	for <linux-pci@archiver.kernel.org>; Tue, 28 May 2019 01:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4450F208C3
	for <linux-pci@archiver.kernel.org>; Tue, 28 May 2019 01:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="fq9dYa7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfE1ByR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 27 May 2019 21:54:17 -0400
Received: from alpha.anastas.io ([104.248.188.109]:59707 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfE1ByR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2019 21:54:17 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 3463D7F8BF;
        Mon, 27 May 2019 20:54:16 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1559008457; bh=tpEsBHAskNTnW0j20OuJzsmsrKEuGoeRDaQ9ZdKXp/w=;
        h=From:To:Cc:Subject:Date:From;
        b=fq9dYa7k3w1qHhjjNrXEPO8ZdlXOywirbS07vJHK1h62LmGCzS6ixZdpGfH3eNp1E
         ggYjWoJKhajFsLBGLNc35lFBGVyulfwQEXNmNddElEY+ZBzae+eAlJZ4atku5H2smB
         QvhZ5EGwQ21IyGssQGMcviHcJ/SGc0vl4Z7ynhEhAhB1pyH0vSC9+UoJF3Z4X/kwOu
         hIjKwZFDPUj++VAgfpjhXvRqknfAfuefv5eV1bD74WaeqGRgikxvyWkR+nMCRJeY6c
         jMP8KSFpYNUVcTvG66I4xPgRQOuQ1sXeYjgwbt8eKBM6PAOF6ZP5P9bxHn8xsEUmMd
         imioSVa6mUW9g==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, sbobroff@linux.ibm.com,
        xyjxie@linux.vnet.ibm.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Allow custom PCI resource alignment on pseries
Date:   Mon, 27 May 2019 20:54:09 -0500
Message-Id: <20190528015412.30521-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes from v1 to v2:
  - Fix function declaration warnings caught by sparse

Hello all,

This patch set implements support for user-specified PCI resource
alignment on the pseries platform for hotplugged PCI devices.
Currently on pseries, PCI resource alignments specified with the
pci=resource_alignment commandline argument are ignored, since
the firmware is in charge of managing the PCI resources. In the
case of hotplugged devices, though, the kernel is in charge of 
configuring the resources and should obey alignment requirements.

The current behavior of ignoring the alignment for hotplugged devices
results in sub-page BARs landing between page boundaries and
becoming un-mappable from userspace via the VFIO framework.
This issue was observed on a pseries KVM guest with hotplugged
ivshmem devices.
 
With these changes, users can specify an appropriate
pci=resource_alignment argument on boot for devices they wish to use 
with VFIO.

In the future, this could be extended to provide page-aligned
resources by default for hotplugged devices, similar to what is done
on powernv by commit 382746376993 ("powerpc/powernv: Override
pcibios_default_alignment() to force PCI devices to be page aligned").

Feedback is appreciated.

Thanks,
Shawn

Shawn Anastasio (3):
  PCI: Introduce pcibios_ignore_alignment_request
  powerpc/64: Enable pcibios_after_init hook on ppc64
  powerpc/pseries: Allow user-specified PCI resource alignment after
    init

 arch/powerpc/include/asm/machdep.h     |  6 ++++--
 arch/powerpc/kernel/pci-common.c       |  9 +++++++++
 arch/powerpc/kernel/pci_64.c           |  4 ++++
 arch/powerpc/platforms/pseries/setup.c | 22 ++++++++++++++++++++++
 drivers/pci/pci.c                      |  9 +++++++--
 include/linux/pci.h                    |  1 +
 6 files changed, 47 insertions(+), 4 deletions(-)

-- 
2.20.1

