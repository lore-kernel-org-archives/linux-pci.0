Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFF8C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9499B21480
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 04:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O5oeZ3mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499B21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeIZKeA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:34:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47003 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeIZKeA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Sep 2018 06:34:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id q12-v6so6554199qkl.13
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2018 21:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Lz8aiHv3tmdpsES4QvVmbMgVGn1T1cbRJZq6UNojIH0=;
        b=O5oeZ3mtzoxRHeRs1F8xtzjGijxtR3/YD3KyATVgZastCdkNKC0DbhME48BcVVQOyN
         5lIZeWlyLPFPe0z4m9KYi8mOamgiHT0sTr8OMhUnLlirEnaEVvkEwWU2m828ceFdKIaM
         YKkUdi+1oFhYyL7sMXM8G/Qxa/Q2GqrRCieyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lz8aiHv3tmdpsES4QvVmbMgVGn1T1cbRJZq6UNojIH0=;
        b=ooqV83fI3ur5NWSgxlZJaB4HM9mKAzp2/4RjxtoYMn8TLRTclSyJvn0zE/5T6Kw3jO
         BYfZB35bBeOwgSKE0uic0/3HyYuGIc3+ykQBCABvnjrsuG2t3E0UaX24JGzJa7z+1tm3
         OgI5pSrSBsgyGMOZUOshMmTyZ5f6AnT9BafQdWxIf2THffI3YGoFK64EeK5pLBjbLGoE
         pTjezf0b9iDK9xvNDPVehg4i3/GR2crLCFgSv9ougtpKItUshy14ixPhwiQ3UBpHPTQ0
         5Z9jMQqNzLhRqTMwMA39fWX+cXRz6oiv+IO8rqn7ctqisoj54zb6qDniNxo+XOguAb2H
         sBeA==
X-Gm-Message-State: ABuFfogzYL4+2lrlpXywz5j9u9kSI4HgQHIdA0ZDUrtyKbwIFCjGxNZG
        cHCGghICtMOIUEc1WfwjdfDpsg==
X-Google-Smtp-Source: ACcGV62w/Ya/JyaAcJUjbEwCG48mG9tDoNtF51wef4DG6onDfppL7d9B9rK7geHj7mfHkLHaaspK/w==
X-Received: by 2002:a37:50c3:: with SMTP id e186-v6mr2992945qkb.91.1537935782989;
        Tue, 25 Sep 2018 21:23:02 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a17-v6sm2375260qkb.62.2018.09.25.21.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 21:23:02 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     lukas@wunner.de, andy.shevchenko@gmail.com,
        Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v4 0/6] mpt3sas: Hot-Plug Surprise removal support on IOC.
Date:   Wed, 26 Sep 2018 09:52:33 +0530
Message-Id: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Posting below set of patches to support PCIe Hot Plug surprise removal,
and few defect fixes.

This is NOT the normal PCIe Hot Plug support, whereby the user informs the
OS that a hot removal is desired, the OS does an orderly shutdown of the
driver on the device, special hot plug circuitry removes power from the
PCIe slot, then the user can remove the device and replace it
(where orderly bring-up of the device is done).

With a true surprise removal (just removing HBA from a slot)
there is a possibility to get all kinds of PCIe transaction errors,
Below patches addresses those issues and remove HBA without bringing
the system down.

For surprise removal detection, driver does a PCI
read of IOC's vendor field in IOC's PCI configuration space.
If the read value is 0xFFFFFFFF this indicates that the device
might have hot removed and the device will be removed from driver.

V1 changes:
In Patch 0001 - unlock mutex, if active reset is in progress.

V2 changes:
Replaced mpt3sas_base_pci_device_is_unplugged with
pci_device_is_present.

V3 Change Set:
Simplified function "mpt3sas_base_pci_device_is_available" and
made inline

V4 Change set:
Reframe split strings in print statement, to avoid
warning from checkpatch.pl.

Suganath Prabu S (6):
  mpt3sas: Introduce      mpt3sas_base_pci_device_is_available
  mpt3sas: Separate out      mpt3sas_wait_for_ioc_to_operational
  mpt3sas: Introdude  _scsih_get_shost_and_ioc.
  mpt3sas: Fix Sync cache command failure during driver      unload.
  mpt3sas: Fix driver modifying NVRAM/persistent data.
  mpt3sas: Bump driver version to 27.100.00.00.

 drivers/scsi/mpt3sas/mpt3sas_base.c      | 133 +++++++++++++++-------
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  11 +-
 drivers/scsi/mpt3sas/mpt3sas_config.c    |  32 +-----
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       |  26 +----
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 189 +++++++++++++++++++++++++++----
 drivers/scsi/mpt3sas/mpt3sas_transport.c |  82 +++-----------
 6 files changed, 296 insertions(+), 177 deletions(-)

-- 
1.8.3.1

