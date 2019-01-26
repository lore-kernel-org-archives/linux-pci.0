Return-Path: <SRS0=pA/b=QC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E113CC282C5
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 08:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F28218F0
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 08:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOv6YYH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfAZIuK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:50:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54386 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZIuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jan 2019 03:50:10 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so14087523ita.4;
        Sat, 26 Jan 2019 00:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cfq+fuUKT+LW8txwLRhzPOqmIdM7lEMeYSuFVHlydTU=;
        b=GOv6YYH/F7ughP18s/7RiS3QHCzQi8BmLlSyJO9ls/TFwbUk3Dbtzj5EKZnyCwggM+
         pL1X0/ALSLxtwKyuuoTpq9FX9Ak32J4Oqj65P2ivx84s5CAj7+DO9pxRVMi8GKTNPWAg
         d5TRkcgfnZ28Z92Ow5uu/VYHWBdYHdrfnuqpDVXwM5HhHIxgrx4N1C4OL2CnCxth3yEu
         ksSOvqzDTvCHdIlYrCBL8nSnCBBHOodJz1XWvix+AmEcpS5wz+zhfeFm7dG1JKn3A+MD
         WQ75bp6CC7LollT7z1+Va+CfciSu5590i3F+QIxWzwTgF4jVAuDUp5VUkaUWYKEgMn2v
         Y4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cfq+fuUKT+LW8txwLRhzPOqmIdM7lEMeYSuFVHlydTU=;
        b=NTIboOo9vihLuYMOjF9blivjDP7UufQuig3Ro7i+CiOZVwiR5H7R1aIBzty+yB1iUn
         a+8LGeSbrpDDzvBCxMtUFGtThJB/Cip1kpPI7yftnU41bsrAlRQZfyMb+3Oj0ljDF7Im
         z1DdrHoyYppwAMSMqGYazH2CZdcxbTc0+CPl94/Dc+DqgsD58PcG3VYMYmj24Wafuzkr
         8SiLd/9gDSFaFIOJksR+IObCk1ZT/QP//9IBvXFTEB0Tr7szitWpJGdmRAA1UIrjSNj6
         KgMGrGcuazU2NL03z01xt74hNJW2/wjLXtTb+O1VY3Yd9XoqeqHLakoGVcgPN9CqgYMv
         PinQ==
X-Gm-Message-State: AJcUukdHhTF3ECuweOu0xWgfopUlfP+LF+8s6xT9/OO05x4t0IQar5zK
        cN3dJAG7CbpnbhIpxrOeJLo=
X-Google-Smtp-Source: ALg8bN7ILv5QcSk80b73oJUYbo+69dUAm0dLE8LTKwSNPoXBsvcmEsz9eibvedSKPWbNFUsXdAy+oQ==
X-Received: by 2002:a02:8244:: with SMTP id q4mr9010120jag.43.1548492609859;
        Sat, 26 Jan 2019 00:50:09 -0800 (PST)
Received: from m-hyperV (50-47-89-76.evrt.wa.frontiernet.net. [50.47.89.76])
        by smtp.gmail.com with ESMTPSA id l186sm14298299itl.22.2019.01.26.00.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 00:50:09 -0800 (PST)
Date:   Sat, 26 Jan 2019 00:50:07 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: [PATCH v2 0/2] PCI: hv: Refactor hv_irq_unmask() to use hv_vpset and
 cpumask_to_vpset()
Message-ID: <cover.1548489092.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset removes a duplicate definition of VP set (hv_vp_set) and
uses the common definition (hv_vpset) that is used in other places. It
changes the order of the members in struct hv_pcibus_device due to
flexible array in hv_vpset.

It also removes the duplicate implementation of cpumask_to_vpset(), uses
the shared implementation, and exports hv_max_vp_index, which is
required by cpumask_to_vpset().

Maya Nakamura (2):
  PCI: hv: Replace hv_vp_set with hv_vpset
  PCI: hv: Refactor hv_irq_unmask() to use cpumask_to_vpset()

 arch/x86/hyperv/hv_init.c           |  1 +
 drivers/pci/controller/pci-hyperv.c | 59 +++++++++++++----------------
 2 files changed, 28 insertions(+), 32 deletions(-)

-- 
2.17.1

