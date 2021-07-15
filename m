Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D2C636C8
	for <linux-pci@archiver.kernel.org>; Thu, 15 Jul 2021 22:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC883610C7
	for <linux-pci@archiver.kernel.org>; Thu, 15 Jul 2021 22:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhGOWDN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Jul 2021 18:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhGOWDH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 18:03:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4ADDC60FE7;
        Thu, 15 Jul 2021 22:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386413;
        bh=kj3NB8eAH5vyZkGvBvAiH4DG+lhRbbxNR5j5r/qhffQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4ZJTx2n8l/vzVNArCdFK7VhR4YaIhMnLHgzqXc9oU7DWDl6yYv/Cg2YoTi/XdOcS
         PQxNjzsV9yB6DoMIcvMtcI/t1Uj0jKlNEbverb+2VYYE3oZXrgJa0CWWbVbD+VSVRn
         zzvuH/iu5KUkXoC2nWim05IJcSvU2LO/2xKG6mcg4xqacS/wdhB2cEoWEP1k6xdVEr
         GU0yvEDyTpT3ecMPBpuTNkCpwCVdvw4bAYukckO8wpoOfp084SoBIaugY/IAseRwNC
         C2KXnjZbOch09Z04VW9ZqnVHOhSzuGYg110TcOd2CVQSuU5rLnfkxfVTUvc2ZUK0Xl
         HSyDOaz2SrKhQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/5] PCI/VPD: pci_vpd_size() cleanups
Date:   Thu, 15 Jul 2021 16:59:54 -0500
Message-Id: <20210715215959.2014576-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This is a follow-up to the conversation here:
https://lore.kernel.org/r/1cdda5f1-e1ea-af9f-cfbe-952b7d37e246@gmail.com
about how and whether we should validate the contents of VPD.

My proposal is to basically do minimal validation since the kernel really
doesn't care about the actual *contents* of VPD and mainly provides an
access mechanism (although there a few drivers that get part numbers and
maybe even clocking information from VPD).

I welcome any feedback!

Bjorn Helgaas (5):
  PCI/VPD: Correct diagnostic for VPD read failure
  PCI/VPD: Check Resource tags against those valid for type
  PCI/VPD: Consolidate missing EEPROM checks
  PCI/VPD: Don't check Large Resource types for validity
  PCI/VPD: Allow access to valid parts of VPD if some is invalid

 drivers/pci/vpd.c | 63 +++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

-- 
2.25.1

