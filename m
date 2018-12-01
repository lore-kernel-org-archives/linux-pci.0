Return-Path: <SRS0=IfUz=OK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0CDC04EB9
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3722081D
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 16:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvSVFNNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3722081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeLBDUF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:20:05 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36195 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeLBDUF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Dec 2018 22:20:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so7405963oix.3;
        Sat, 01 Dec 2018 08:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LmhTKiqrz4jqaZKIEYW2otUBWhpbwR5cPjehX6hgoeQ=;
        b=YvSVFNNFqvWUM3Rqoufj3d4n8T5XgSTelw5hEgmOUqaZ+vo0U5szISffWPSFhP9Iot
         p7qT3Te3KYKZ4yJE7BZR9vwLfm9c07mDevYh+kIyUSCOgOcGSXa0+qfHzpDDHeagcwjv
         vcOrGSTcGoWzHoXe+gdacoUkZfTwzDiSSzFo5rRmTLIaQTPPWPwRVDpD6UmuqHJdY31N
         21GsGCqXJaalT4AUoRgY5QXeScU9uAhGnLtIcF9fV6LD5rspC4zMdLJSwmZDvVKtqTpm
         sFbbTfjBf0stGisBNVzLUc3E7AnNLMAKUl9R9FJeqShhsI27H+QfI2YGbDzMKsLbRmm9
         2aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LmhTKiqrz4jqaZKIEYW2otUBWhpbwR5cPjehX6hgoeQ=;
        b=sWCYJV2vwgUlVYFPNxxyG0HFaPUPlHFiaLB6g4QEtsJ2fhoh7QSY62M+pmAh5RwFWU
         HOMLOfq4yGOI6EB7pUZMpn8IYBMhSVaUkzvdfXlduc/r8Xfe+vSK1LdTelOYHbm+KM72
         U4bj6nrJfSTTVflsQFcSlb/395DHI0ABMpdAZ9V+6XmTCfequaQgH1ibgIH7VscFLVYD
         TYtkpZYIhdQ5FF1lF4NwcVhFC+yb5gfC9/gL7QBpJKMsT02QXZDbIgmCbBFJb5zmchfN
         QjAxmdPodFnvEZpPV3YNC3CcGPL55iKlbAnBGFA4ivQV0d9NRlpmY7dy6uLcZJcuqY59
         /k2A==
X-Gm-Message-State: AA+aEWa2u+TJbD8VsLjwH6z0n5cZNR8Qd1C3QydbVUp6OsxcaB8j05mB
        5BdScyjpnlMet5w/FvyntBDICPqI
X-Google-Smtp-Source: AFSGD/WTWoi7XCSyiAy64PD8JUAqhOGSThrY8fVsDO+XC0M3PqTwxsxNm9oEggI1bueeteGumCdVHA==
X-Received: by 2002:aca:d944:: with SMTP id q65-v6mr6218854oig.0.1543680434508;
        Sat, 01 Dec 2018 08:07:14 -0800 (PST)
Received: from ycd-dell-ltp ([2600:8802:700:7:7ae4:ff:fe9e:c789])
        by smtp.gmail.com with ESMTPSA id w17sm2925796otk.12.2018.12.01.08.07.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 08:07:14 -0800 (PST)
Date:   Sat, 1 Dec 2018 08:07:11 -0800
From:   Benjamin Young <youngcdev@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pcie: portdrv: Fix Unnecessary space before function pointer
 arguments
Message-ID: <20181201160711.GA21373@ycd-dell-ltp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Made spacing more consistent in the code for function pointer
declarations based on checkpatch.pl

Signed-off-by: Benjamin Young <youngcdev@gmail.com>
---
 drivers/pci/pcie/portdrv.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index e495f04..fbbf00b0 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -71,19 +71,19 @@ static inline void *get_service_data(struct pcie_device *dev)
 
 struct pcie_port_service_driver {
 	const char *name;
-	int (*probe) (struct pcie_device *dev);
-	void (*remove) (struct pcie_device *dev);
-	int (*suspend) (struct pcie_device *dev);
-	int (*resume_noirq) (struct pcie_device *dev);
-	int (*resume) (struct pcie_device *dev);
-	int (*runtime_suspend) (struct pcie_device *dev);
-	int (*runtime_resume) (struct pcie_device *dev);
+	int (*probe)(struct pcie_device *dev);
+	void (*remove)(struct pcie_device *dev);
+	int (*suspend)(struct pcie_device *dev);
+	int (*resume_noirq)(struct pcie_device *dev);
+	int (*resume)(struct pcie_device *dev);
+	int (*runtime_suspend)(struct pcie_device *dev);
+	int (*runtime_resume)(struct pcie_device *dev);
 
 	/* Device driver may resume normal operations */
 	void (*error_resume)(struct pci_dev *dev);
 
 	/* Link Reset Capability - AER service driver specific */
-	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
+	pci_ers_result_t (*reset_link)(struct pci_dev *dev);
 
 	int port_type;  /* Type of the port this driver can handle */
 	u32 service;    /* Port service this device represents */
-- 
2.5.0

