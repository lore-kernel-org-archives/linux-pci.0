Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE7C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87D22081C
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vta/+c5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87D22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeLDPv5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:51:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39221 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLDPv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 10:51:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so7548675pgl.6;
        Tue, 04 Dec 2018 07:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5xSymTNBvPrfVZFxTOq8ZgJdLvjnjnJ8zLIaNWaPasM=;
        b=Vta/+c5SAWB9HMq5TAwytL3TmuiNtSCcXEL8XS1tnEYlExO+vWjpNAEkK7GNCI/Dxi
         Fr2wf2gs6AN+EEggIGsgBFtNLcuVi3IO+hvpDysPByhdMu2f9bLahaFUlc1tyWSTBDr3
         wtjSbchRKRQUYkaMw5yfDcEDhVofzK1gHPXpCkxOcn+7aJ7OYpRHE73A5qZr0EfKN3hQ
         PHziOJsZ8ihr8ucozpC2nkm3cvPio8sdArMEiSj65+etbLrruN9qKpDrJQK5FyvAtRQ1
         iAbalXc9Th38CuiDAWVy+jhcRVrufdkfxA30VpOnwSeUjT+4zWQ3Xdi0ndSqIxhoQPhK
         JeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5xSymTNBvPrfVZFxTOq8ZgJdLvjnjnJ8zLIaNWaPasM=;
        b=aCURnJsgRvqhYN4aCb5MRMseL9Q69h5a5RyeFQtkJMjD8Orz/qcqBvx/Xf+rJo8tUa
         /LmBu1WxeZbiDnKjzPaMDFuCu06HaKq6tgPWvUgrlONIqzoxZu7/uryvAgemIMYBM7ys
         isyqPLoHm7GgGI3XB4vMWUD3qUaFuqyR+IKpjRXkQ/d0p07cIXzzmmhEwbtmwr8HPUU+
         hqU2Qkwf5q7vzNxK8cMEm407xvS7heJK2emG2UhWrHuoy5waATOq4PaXesUgMsdh+r9d
         v/HqKl8kaMyZCABPGcOLelMON48Tmkzp1YapP82QnhJUFt2Ai6KhF9wESvuX2AW/hYsj
         rPwQ==
X-Gm-Message-State: AA+aEWa6NkljWASLb3Q+bn+b03vP/hao2b6VULvtDJ45Dkl6go1Kt5Ni
        2cfrFy26FBn6/igPUjOuOD5y9kHK
X-Google-Smtp-Source: AFSGD/Uth9z46M1J4ophFaKBVYGnnqjTGUchYTWMe4VhOLSPdb5v8BJZn2upuX6OCXrkAot3C3TlLg==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr17242144pgn.112.1543938716265;
        Tue, 04 Dec 2018 07:51:56 -0800 (PST)
Received: from localhost.localdomain ([104.238.160.83])
        by smtp.gmail.com with ESMTPSA id u78sm40653444pfi.2.2018.12.04.07.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 07:51:55 -0800 (PST)
From:   Dou Liyang <douliyangs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     tglx@linutronix.de, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com,
        douliyang1@huawei.com, Dou Liyang <douliyangs@gmail.com>
Subject: [PATCH 0/3] irq/core: Fix and expand the irq affinity descriptor
Date:   Tue,  4 Dec 2018 23:51:19 +0800
Message-Id: <20181204155122.6327-1-douliyangs@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now,  Spreading the interrupt affinity info by a cpumask pointer is not
enough, meets a problem[1] and hard to expand in the future.

Fix it by:

     +-----------------------------------+
     |                                   |
     |     struct cpumask *affinity      |
     |                                   |
     +-----------------------------------+
                       |
    +------------------v-------------------+
    |                                      |
    | struct irq_affinity_desc {           |
    |     struct cpumask   mask;           |
    |     unsigned int     is_managed : 1; |
    | };                                   |
    |                                      |
    +--------------------------------------+

[1]:https://marc.info/?l=linux-kernel&m=153543887027997&w=2

Dou Liyang (3):
  genirq/affinity: Add a new interrupt affinity descriptor
  irq/affinity: Add is_managed into struct irq_affinity_desc
  irq/affinity: Fix a possible breakage

 drivers/pci/msi.c         |  9 ++++-----
 include/linux/interrupt.h | 15 +++++++++++++--
 include/linux/irq.h       |  6 ++++--
 include/linux/irqdomain.h |  6 ++++--
 include/linux/msi.h       |  4 ++--
 kernel/irq/affinity.c     | 38 +++++++++++++++++++++++++-------------
 kernel/irq/devres.c       |  4 ++--
 kernel/irq/irqdesc.c      | 25 +++++++++++++++++--------
 kernel/irq/irqdomain.c    |  4 ++--
 kernel/irq/msi.c          |  7 ++++---
 10 files changed, 77 insertions(+), 41 deletions(-)

-- 
2.17.2

