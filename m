Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752FEC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC0B20880
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 20:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr7U0qcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC0B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeIZCjw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeIZCjw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 22:39:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 594192083A;
        Tue, 25 Sep 2018 20:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537907432;
        bh=m5aoXcMI+ItRd5eZ+uRGwkf8uchTaM5FhNxDPO4aJ7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tr7U0qcA0DPQWI2YXrbwTbA7jq3c/3HTHSmj1glAkk+Sx2YHG6nCpM0XSsCzriTYM
         J8CVm38urnq6+9bluiNq2ghE3AW74v1UcBf2PH2yeaC8CqUi+U5z8FJf0xiOielgA/
         6SAizFfvwpdGI4okRLU38cmaEyoQgZAxHYD9mQWw=
Date:   Tue, 25 Sep 2018 15:30:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     xiangxia.m.yue@gmail.com
Cc:     hch@lst.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: msi: return error code instead of only warn
Message-ID: <20180925203031.GA80129@bhelgaas-glaptop.roam.corp.google.com>
References: <1537797641-6868-1-git-send-email-xiangxia.m.yue@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537797641-6868-1-git-send-email-xiangxia.m.yue@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 24, 2018 at 07:00:41AM -0700, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> The drivers may enable the msi/msix more than once.
> Actually, this is the driver bug. But the bug may panic
> the kernel and should be fixed. We can return the error
> code instead of WARN_ON, to tell the drivers that the
> msi/msix is already enabled.
> 
> When enable them again, the call tree is shown on kernel
> 3.10.0, but linux upstream in the same way.
> 
> Call Trace:
> 	dump_stack+0x19/0x1b
> 	warn_slowpath_common+0x70/0xb0
> 	warn_slowpath_null+0x1a/0x20
> 	pci_enable_msix+0x3c9/0x3e0
> 	igbuio_pci_open+0x72/0x300 [igb_uio]
> 	uio_open+0xcc/0x120 [uio]
> 	chrdev_open+0xa1/0x1e0
> 	[...]
> 	do_sys_open+0xf3/0x1f0
> 	SyS_open+0x1e/0x20
> 	system_call_fastpath+0x16/0x1b
> 	------------[ cut here ]------------
> 	WARNING: at fs/sysfs/dir.c:526 sysfs_add_one+0xa5/0xd0()
> 	sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:03.0/0000:01:00.1/msi_irqs'
> 
> Call Trace:
> 	dump_stack+0x19/0x1b
> 	warn_slowpath_common+0x70/0xb0
> 	warn_slowpath_fmt+0x5c/0x80
> 	sysfs_add_one+0xa5/0xd0
> 	create_dir+0x7c/0xe0
> 	sysfs_create_subdir+0x1c/0x20
> 	internal_create_group+0x6d/0x290
> 	sysfs_create_groups+0x4a/0xa0
> 	populate_msi_sysfs+0x1cd/0x210
> 	pci_enable_msix+0x31c/0x3e0
> 	igbuio_pci_open+0x72/0x300 [igb_uio]
> 	uio_open+0xcc/0x120 [uio]
> 	chrdev_open+0xa1/0x1e0
> 	[...]
> 	do_sys_open+0xf3/0x1f0
> 	SyS_open+0x1e/0x20
> 	system_call_fastpath+0x16/0x1b
> 	---[ end trace 11042e2848880209 ]---
> 	Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ffffffffa056b4fa
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>

I cleaned up whitespace (extra spaces after "return") and !! (as Christoph
mentioned) and applied the patch below to pci/msi for v4.20, thanks!


commit 4c1ef72e9b71a19fb405ebfcd37c0a5e16fa44ca
Author: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Mon Sep 24 07:00:41 2018 -0700

    PCI/MSI: Warn and return error if driver enables MSI/MSI-X twice
    
    It is a serious driver defect to enable MSI or MSI-X more than once.  Doing
    so may panic the kernel as in the stack trace below:
    
      Call Trace:
        sysfs_add_one+0xa5/0xd0
        create_dir+0x7c/0xe0
        sysfs_create_subdir+0x1c/0x20
        internal_create_group+0x6d/0x290
        sysfs_create_groups+0x4a/0xa0
        populate_msi_sysfs+0x1cd/0x210
        pci_enable_msix+0x31c/0x3e0
        igbuio_pci_open+0x72/0x300 [igb_uio]
        uio_open+0xcc/0x120 [uio]
        chrdev_open+0xa1/0x1e0
        [...]
        do_sys_open+0xf3/0x1f0
        SyS_open+0x1e/0x20
        system_call_fastpath+0x16/0x1b
        ---[ end trace 11042e2848880209 ]---
        Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ffffffffa056b4fa
    
    We want to keep the WARN_ON() and stack trace so the driver can be fixed,
    but we can avoid the kernel panic by returning an error.  We may still get
    warnings like this:
    
      Call Trace:
        pci_enable_msix+0x3c9/0x3e0
        igbuio_pci_open+0x72/0x300 [igb_uio]
        uio_open+0xcc/0x120 [uio]
        chrdev_open+0xa1/0x1e0
        [...]
        do_sys_open+0xf3/0x1f0
        SyS_open+0x1e/0x20
        system_call_fastpath+0x16/0x1b
        ------------[ cut here ]------------
        WARNING: at fs/sysfs/dir.c:526 sysfs_add_one+0xa5/0xd0()
        sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:03.0/0000:01:00.1/msi_irqs'
    
    Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
    [bhelgaas: changelog, fix patch whitespace, remove !!]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f2ef896464b3..af24ed50a245 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -958,7 +958,6 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 			}
 		}
 	}
-	WARN_ON(!!dev->msix_enabled);
 
 	/* Check whether driver already requested for MSI irq */
 	if (dev->msi_enabled) {
@@ -1028,8 +1027,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (!pci_msi_supported(dev, minvec))
 		return -EINVAL;
 
-	WARN_ON(!!dev->msi_enabled);
-
 	/* Check whether driver already requested MSI-X irqs */
 	if (dev->msix_enabled) {
 		pci_info(dev, "can't enable MSI (MSI-X already enabled)\n");
@@ -1039,6 +1036,9 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	if (WARN_ON_ONCE(dev->msi_enabled))
+		return -EINVAL;
+
 	nvec = pci_msi_vec_count(dev);
 	if (nvec < 0)
 		return nvec;
@@ -1087,6 +1087,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
+	if (WARN_ON_ONCE(dev->msix_enabled))
+		return -EINVAL;
+
 	for (;;) {
 		if (affd) {
 			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
