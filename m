Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E024C07E85
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 06:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A253622360
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 06:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb2nK2o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A253622360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeKNQWD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbeKNQWD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Nov 2018 11:22:03 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08DC6214F1;
        Wed, 14 Nov 2018 06:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542176415;
        bh=uu1cGRk+WUtJ0eZ77ISi0awUGGDn1+jv1aQvMWj+rt8=;
        h=Date:From:To:Cc:Subject:From;
        b=Fb2nK2o2fQ6tDzUYo1CgZEPzeq84yJEQDURJ86JSS1+PD/iauY0PHGCt5qbUvs/n3
         23XiSGi0agS7sYkoIDpQrs3PBOU6nio/HHwLSq9fccsELzRJAEjCTMBXGczoyFk32t
         BeL4jt8Q7oukH0BvVjS7lLmTyb8ENUQyG46WSItQ=
Date:   Wed, 14 Nov 2018 00:20:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [GIT PULL] PCI fixes for v4.20
Message-ID: <20181114062010.GA189193@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Revert a _PXM change that causes silent early boot failure on some AMD
    ThreadRipper systems (Bjorn Helgaas)


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-1

for you to fetch changes up to 0d76bcc960e6057750fcf556b65da13f8bbdfd2b:

  Revert "ACPI/PCI: Pay attention to device-specific _PXM node values" (2018-11-13 08:38:17 -0600)

----------------------------------------------------------------
pci-v4.20-fixes-1

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "ACPI/PCI: Pay attention to device-specific _PXM node values"

 drivers/pci/pci-acpi.c | 5 -----
 1 file changed, 5 deletions(-)
