Return-Path: <SRS0=1eKq=YC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6A9C47404
	for <linux-pci@archiver.kernel.org>; Wed,  9 Oct 2019 22:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D172218DE
	for <linux-pci@archiver.kernel.org>; Wed,  9 Oct 2019 22:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570661647;
	bh=sdfemJxxgR9nam3jxP3yXjTQgeUBVv43xAUwHlO8Jxo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Sg0oDrSAcp6P2X+3xgtWwwXgCDrPJC5fpzM9c3uFmppJdaWRO8DzNAaSO845G0sKq
	 vRWuD2+vsaGQJ5taq1VGtC/+8D2m+IbXmBfjbbF55npU9Fpa75iiEepQCl83q39bbu
	 X29udkLxHlhpdjmi1TEM5NgCt/vrrWrIXX7Cqdwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfJIWyH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730999AbfJIWyG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 18:54:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154F720B7C;
        Wed,  9 Oct 2019 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570661646;
        bh=sdfemJxxgR9nam3jxP3yXjTQgeUBVv43xAUwHlO8Jxo=;
        h=From:To:Cc:Subject:Date:From;
        b=NmoDk2HHXhhOGxdgynuutsxQF0YQbg8l1iMhjGAkcFoPvS2O0rg/W4MRdntr8S+9Y
         Q44FGQFM8UDw5I02IsVBviDBenPqo9UwPHIat63AIEE5KnS3cfBulgz+7jMzw/atGF
         0jmOs+fccjzbWF5OceVE+1EoblPyUxkL0g66HcdI=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] PCI/ATS: Clean up unnecessary stubs and exports
Date:   Wed,  9 Oct 2019 17:53:51 -0500
Message-Id: <20191009225354.181018-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Most of the ATS/PRI/PASID interfaces are only used by IOMMU drivers that
can only be built statically, not as modules.  A couple are only used by
the PCI core and don't need to be visible outside at all.

These are intended to be cleanup only, but let me know if they would break
something.

Bjorn Helgaas (3):
  PCI/ATS: Remove unused PRI and PASID stubs
  PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()
  PCI/ATS: Make pci_restore_pri_state(), pci_restore_pasid_state()
    private

 drivers/pci/ats.c       | 14 --------------
 drivers/pci/pci.h       |  4 ++++
 include/linux/pci-ats.h | 15 ---------------
 3 files changed, 4 insertions(+), 29 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog

