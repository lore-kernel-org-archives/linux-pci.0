Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D496EC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 07:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01AE2147A
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 07:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koojRhdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfA2HPk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:15:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34901 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfA2HPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2019 02:15:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so8963440plo.2;
        Mon, 28 Jan 2019 23:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cfq+fuUKT+LW8txwLRhzPOqmIdM7lEMeYSuFVHlydTU=;
        b=koojRhdIWZwE1WEZrB7d8r209R5cNDErbZdiDgZVv2s3YX3Utn3zAqL3qHPHXiGp+l
         0xn4A/R4kd/g4saIAW0qsreWPcEEU6HVpzfDT4sYCoipZesgYFLH5ydFDpMR+fKvqzC1
         HzARozgRDH7pjtq/GoSa7+CwNV7EWYgN0u2+Ni9G7YXyp/CXFIxvvlwLmynXFaax13Zh
         B1aI5BCo2PFaaXQPoePbt35GKL7pEJiwCk218ZgNK+p6waZg1Oulzp5NGLueDKXEJnK0
         UuhtYBbwZRvRI48cYjX52/l/a5z/VlRxoK4Ov0NHGXh29cCf97hnx+uy9fv/N8OtjF0i
         Rmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cfq+fuUKT+LW8txwLRhzPOqmIdM7lEMeYSuFVHlydTU=;
        b=UhGTnPfeaWcmN7D+QQPFba03B87zzrE0HrcuvHN+zf0zS1dcN8fAcSWI/ny1ZRbvoL
         6shPUyWlIBTiXjgLl22hdQJyTw+JN4ecEnWc6JTNJnWYSW6TbhaeALhFlZFRl1J+UAi2
         yHCQKXCEqvduaxWdCrrzBtw/VPG1KX4vkI8Ox2UHjVQDCNUGylS7iFdk/wD2Uw7gms3V
         kDkcvhoEoK7QHqeXi2EeqIqqUD/ot4hWTs+TKrBMLsAspKENEBdYSa9yvMJLhQm3W6eK
         7DCL4X9gkGQCi5n//E5YWuyB/bWr3P/iaMGoptHGe730nZ4STztJiddIF5uAVsOmHkDw
         7nXA==
X-Gm-Message-State: AJcUukdFuz+bmZVd2Z5ZZXAtIcL2iXPRW/vBZPYho5gj37K694yuqm6e
        f2Gh7StVXoXMRnnYQz6/+pY=
X-Google-Smtp-Source: ALg8bN6gWG09QX8woidrd14LPH5168H4vT+MYGbTGtLErHl+TGAfDUhnypOhaUdjujVvliPdlwrymg==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr24110748plz.174.1548746139306;
        Mon, 28 Jan 2019 23:15:39 -0800 (PST)
Received: from m-hyperV (50-47-88-57.evrt.wa.frontiernet.net. [50.47.88.57])
        by smtp.gmail.com with ESMTPSA id v12sm39757527pgg.41.2019.01.28.23.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 23:15:38 -0800 (PST)
Date:   Mon, 28 Jan 2019 23:15:37 -0800
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, haiyangz@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: [PATCH v3 0/2] PCI: hv: Refactor hv_irq_unmask() to use hv_vpset and
 cpumask_to_vpset()
Message-ID: <cover.1548745212.git.m.maya.nakamura@gmail.com>
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

