Return-Path: <SRS0=Jbu+=RI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F421C43381
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C77020661
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 17:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCERdc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:33:32 -0500
Received: from mxpout02.htp-tel.de ([212.59.41.9]:41703 "EHLO
        mxpout02.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfCERdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Mar 2019 12:33:32 -0500
Received: from mxpin02.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout02.htp-tel.de with ESMTPS id x25HX35N026990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 18:33:03 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin02.htp-tel.de with ESMTPS id x25HX2QZ028878
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 5 Mar 2019 18:33:03 +0100 (CET)
Received: from esd-s9.esd.local (10.0.0.190) by esd-s3.esd.local (10.0.0.66)
 with Microsoft SMTP Server id 8.2.176.0; Tue, 5 Mar 2019 18:32:59 +0100
Received: by esd-s9.esd.local (Postfix, from userid 2044)       id AB65B1400CB; Tue,
  5 Mar 2019 18:33:02 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ptalbert@redhat.com>, <lukas@wunner.de>, <fred@fredlawl.com>,
        <andriy.shevchenko@linux.intel.com>, <bhull@redhat.com>,
        <linux-pci@vger.kernel.org>
CC:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
Subject: [PATCH V2 0/1] Proposal of a patch to work around link retrain errata of Pericom PCIe brigdes
Date:   Tue, 5 Mar 2019 18:31:21 +0100
Message-ID: <20190305173122.11875-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (mxpin02.htp-tel.de [172.19.12.5]); Tue, 05 Mar 2019 18:33:03 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch provides a quirk that should work around PCIe link retrain issues
with some Pericom PCIe-to-PCI bridges. It is the second version of the patch
referred to by https://patchwork.kernel.org/patch/10664475/ and is archived
at https://marc.info/?l=linux-pci&m=154110439803920

The original patch was only for the Pericom PI7C9X111SL bridge. This is the
only hardware I can test with.

In the meantime Brett Hull <bhull@redhat.com> brought to my attention that
the PI7C9X110 and PI7C9X130 devices are also affected. I had access to the
errata sheet for the PI7C9X130 PCI bridge and its has the same issue
documented.

Therefore the patch will now handle all three mentioned devices.

I'd like to quote the errata sheet PI7C9X111SLB_errata_rev1.2_102711.pdf

> In Reverse Mode, retrain Link bit is not cleared automatically; this bit
> needs to be cleared manually by configuration write after it is set.
>
> Problem:
> In Reverse mode, after setting Retrain Link (bit 5 of register C0h), this
> bit will stay on and PI7C9x111SL will continuously retrain until this bit
> is cleared by another Configuration Write to register C0h.
>
> Workaround:
> Issue another configuration write to clear Retrain Link bit after setting
> this bit. No delay is required between these two configuration write.

There is no public URL to download these errata sheets. Because Pericom has
been acquired by Diodes Inc. all information has to be downloaded from their
web site. Following the link below one can find a datasheet and there is a
button to request additional documents like the errata sheet for instance.

https://www.diodes.com/products/connectivity-and-timing/pcie-packet-switchbridges/pcie-pci-bridges/part/PI7C9X111SL#tab-details

@Brett Hull: Could you please test on your site and supply also a
	signed-off?

Stefan Mätje (1):
  PCI/ASPM: Work around link retrain errata of Pericom PCIe-to-PCI
    bridges

 drivers/pci/pcie/aspm.c | 49 ++++++++++++++++++++++++++++++++++---------------
 drivers/pci/quirks.c    | 20 ++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 56 insertions(+), 15 deletions(-)

--
2.15.0

