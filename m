Return-Path: <SRS0=Nkm2=NM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE92C0044C
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 19:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B5520820
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 19:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B5520820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esd.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeKBEjG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:39:06 -0400
Received: from mxpout01.htp-tel.de ([212.59.41.8]:40163 "EHLO
        mxpout01.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeKBEjG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Nov 2018 00:39:06 -0400
X-Greylist: delayed 718 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2018 00:39:04 EDT
Received: from mxpin01.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout01.htp-tel.de with ESMTPS id wA1JMjCs021597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Nov 2018 20:22:45 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin01.htp-tel.de with ESMTPS id wA1JMiUC002009
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 1 Nov 2018 20:22:45 +0100 (CET)
Received: from esd-s9.esd.local (10.0.0.190) by esd-s3.esd.local (10.0.0.66)
 with Microsoft SMTP Server id 8.2.176.0; Thu, 1 Nov 2018 20:21:50 +0100
Received: by esd-s9.esd.local (Postfix, from userid 2044)       id 96A0F1400CA; Thu,
  1 Nov 2018 20:22:44 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
Subject: [PATCH 0/1] PCI/ASPM: Proposal to add a fix for an erratum of the PI7C9X111SLB PCI-to-PCIe bridge
Date:   Thu, 1 Nov 2018 20:22:28 +0100
Message-ID: <20181101192229.48352-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (mxpin01.htp-tel.de [172.19.12.4]); Thu, 01 Nov 2018 20:22:45 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The proposed patch fixes an erratum of the PI7C9X111SLB PCI-to-PCIe bridge in reverse mode.
It is somewhat ugly because it introduces hardware dependend code in the function 
pcie_aspm_configure_common_clock() of drivers/pci/pcie/aspm.c that is totally device agnostic
atm. Also because the code which checks for the PI7C9X111SLB bridge and then applies a workaround
is executed for all devices that are candidates for a PCIe link clock reconfiguration. But I have
no idea how to move the code out of this "hotpath".

It would be cool if the fix could be included in the current release.

To quote the errata sheet:

> In Reverse Mode, retrain Link bit is not cleared automatically; this bit
> needs to be cleared manually by configuration write after it is set.
> 
> Problem: 
> In Reverse mode, after setting Retrain Link (bit 5 of register C0h), this bit will stay on
> and PI7C9x111SL will continuously retrain until this bit is cleared by another
> Configuration Write to register C0h.
> 
> Workaround: 
> Issue another configuration write to clear Retrain Link bit after setting this bit. No delay
> is required between these two configuration write.

Regards,
	Stefan

Stefan Mätje (1):
  PCI/ASPM: Add a fix for an erratum of the PI7C9X111SLB PCI-to-PCIe
    bridge

 drivers/pci/pcie/aspm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.15.0

