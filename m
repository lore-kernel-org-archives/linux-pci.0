Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D53C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005FC2087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuEkJW31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfDON7I (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:59:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40441 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfDON7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 09:59:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id q66so660690ljq.7
        for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2019 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Q4ugAoDO17MT2mmfTySVpH5yxtA1dZ4+ttIrvtNTygo=;
        b=OuEkJW31C8uY8Z8dDq7rm4QTKgV0lf+0/JJSWB/L4LOI7lBCSCvRZxAmmziDso/0dU
         nDyzm/FiZne/btHqzc9YNMaE3qWdW91ZTXB0E5STqQqxyfHiHcl70MpmC+ceHB+fDm9n
         tGAhKS1NjeRKXAIgtsJiQumS2ZfALZzzgyfF8nlVoQIM/bp7vVmbcsHbpwRTd5IhPTFo
         FS+Dcb/MM1yMxDN34aUoTybRW34z67gHhhwrp+wP8cSLXMitTMFBbkVNqlvcLrQ1by9Z
         3SULrhjJ0mGUTFyIA1OcuGwyj7vePFDBpu+FrTJWP6dN7FWJ+TJr7pnU27Y4w8vmDbez
         7L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q4ugAoDO17MT2mmfTySVpH5yxtA1dZ4+ttIrvtNTygo=;
        b=pV410VErzn1H3CF0sum9avU9EattwE8GTslADPxwc6GwwNs7W+jXk7FRz30UyrC0cH
         tTnD0T2Xj6NeqTpFwG3RD8/vI/kGsn6xxv1ujur2EXFJ7y5SOPnQ6Vwcnvxfz+yNBg+P
         fuHU5BJetSTnN3sQG7ZOoM8abhrcBOLzSsqKn/2HPM1ma4mIQgjI4moaMGwO+rDRRUYI
         G2I4K3S8gyj2XUuLssvco5tMBWtqWE/+gPHQyZIkBWz/H+WTEpnoZ9yof3PpHsj76eVi
         eyChtuu6mC0WE06b0zPbfpK1btpzR6OnHH6YxCaWDE5z5zMP/hQYNlZLQq4/qzEOMTDF
         4OmQ==
X-Gm-Message-State: APjAAAUGfG0nIGVI2Utg768RIaumYOm8BozxL3bIkLEQr6bSdUp5nEX0
        6xaY506lp0F07Kqmp/PlKlyUUjDpQgOXmPLz
X-Google-Smtp-Source: APXvYqwHlXmzeQgJHtdyMK2KdGoW7MrPXZuIGcbFNJshcwnhZmWqsJs7+nsPKz67uIKEkNJqHmdMDg==
X-Received: by 2002:a2e:9585:: with SMTP id w5mr1781647ljh.132.1555336745708;
        Mon, 15 Apr 2019 06:59:05 -0700 (PDT)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id n12sm2961779lfk.60.2019.04.15.06.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 06:59:04 -0700 (PDT)
Date:   Mon, 15 Apr 2019 16:59:03 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux@yadro.com
Subject: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Message-ID: <20190415135903.wiyw34faiezdnbbs@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PLX switches have an issue that their internal registers become inaccessible
when runtime PM is enabled. Therefore PLX service tools can't communicate
with the hardware. A kernel option "pcie_port_pm=off" can be used as a
workaround. But it affects all the devices.
So this solution is to add PLX switch devices to the quirk list for
disabling runtime PM only for them.
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a59ad09..8ea99aa 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2923,6 +2923,17 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)
 	dev->is_hotplug_bridge = 1;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
+/*
+ * Disable runtime PM for PLX Draco (1,2), Capella (1,2) series PCIe switches
+ * to prevent service tools from failing to access hardware registers.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8712, quirk_hotplug_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8733, quirk_hotplug_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8734, quirk_hotplug_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8780, quirk_hotplug_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x8796, quirk_hotplug_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x9781, quirk_hotplug_bridge);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x9797, quirk_hotplug_bridge);
 
 /*
  * This is a quirk for the Ricoh MMC controller found as a part of some
-- 
2.7.4
