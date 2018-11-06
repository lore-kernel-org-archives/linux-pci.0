Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC106C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 21:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AFF2086B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 21:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiadtOAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AFF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeKGHT6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbeKGHT6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 02:19:58 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01222083D;
        Tue,  6 Nov 2018 21:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541541159;
        bh=sqXnFCn3ioqesxmteeh4sHL0GvcXLo+0EFWfnS+hil0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fiadtOAKKS+6X/ZeO0QIfnIR3sk69LhUVBmCngxLTXMyPn5dQqdF8HMLL5Q7nT1kd
         M8y2JdVdTgYH6P6TnICzHdp9dZYP4SdcM8WkKvQvO8e9KdD/TKT3RMzqeXW9Kg1juJ
         HA07WQPwPBspFLdBEzLlXcLNBJ/IoyASvq43//mY=
Subject: [PATCH 2/2] setpci: Add capability names
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Mares <mj@ucw.cz>
Cc:     linux-pci@vger.kernel.org
Date:   Tue, 06 Nov 2018 15:52:38 -0600
Message-ID: <154154115807.78911.16356898000834597828.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <154154102296.78911.760432131801074864.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154154102296.78911.760432131801074864.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Add capability names for all the capabilities known to lspci.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 setpci.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/setpci.c b/setpci.c
index 13b6a6b..0ab2009 100644
--- a/setpci.c
+++ b/setpci.c
@@ -296,6 +296,7 @@ static const struct reg_name pci_reg_names[] = {
   { 0x10011,    0, 0, "CAP_MSIX" },
   { 0x10012,    0, 0, "CAP_SATA" },
   { 0x10013,    0, 0, "CAP_AF" },
+  { 0x10014,    0, 0, "CAP_EA" },
   { 0x20001,	0, 0, "ECAP_AER" },
   { 0x20002,	0, 0, "ECAP_VC" },
   { 0x20003,	0, 0, "ECAP_DSN" },
@@ -304,13 +305,37 @@ static const struct reg_name pci_reg_names[] = {
   { 0x20006,	0, 0, "ECAP_RCILINK" },
   { 0x20007,	0, 0, "ECAP_RCECOLL" },
   { 0x20008,	0, 0, "ECAP_MFVC" },
+  { 0x20009,	0, 0, "ECAP_VC2" },
   { 0x2000a,	0, 0, "ECAP_RBCB" },
   { 0x2000b,	0, 0, "ECAP_VNDR" },
   { 0x2000d,	0, 0, "ECAP_ACS" },
   { 0x2000e,	0, 0, "ECAP_ARI" },
   { 0x2000f,	0, 0, "ECAP_ATS" },
   { 0x20010,	0, 0, "ECAP_SRIOV" },
+  { 0x20011,	0, 0, "ECAP_MRIOV" },
+  { 0x20012,	0, 0, "ECAP_MCAST" },
+  { 0x20013,	0, 0, "ECAP_PRI" },
+  { 0x20015,	0, 0, "ECAP_REBAR" },
+  { 0x20016,	0, 0, "ECAP_DPA" },
+  { 0x20017,	0, 0, "ECAP_TPH" },
+  { 0x20018,	0, 0, "ECAP_LTR" },
+  { 0x20019,	0, 0, "ECAP_SECPCI" },
+  { 0x2001a,	0, 0, "ECAP_PMUX" },
+  { 0x2001b,	0, 0, "ECAP_PASID" },
+  { 0x2001c,	0, 0, "ECAP_LNR" },
   { 0x2001d,	0, 0, "ECAP_DPC" },
+  { 0x2001e,	0, 0, "ECAP_L1PM" },
+  { 0x2001f,	0, 0, "ECAP_PTM" },
+  { 0x20020,	0, 0, "ECAP_M_PCIE" },
+  { 0x20021,	0, 0, "ECAP_FRS" },
+  { 0x20022,	0, 0, "ECAP_RTR" },
+  { 0x20023,	0, 0, "ECAP_DVSEC" },
+  { 0x20024,	0, 0, "ECAP_VF_REBAR" },
+  { 0x20025,	0, 0, "ECAP_DLNK" },
+  { 0x20026,	0, 0, "ECAP_16GT" },
+  { 0x20027,	0, 0, "ECAP_LMR" },
+  { 0x20028,	0, 0, "ECAP_HIER_ID" },
+  { 0x20029,	0, 0, "ECAP_NPEM" },
   {       0,    0, 0, NULL }
 };
 

