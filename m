Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D986C00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234F22089F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1b0JEs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234F22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJCM0d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39421 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCM0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2018 08:26:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so2872861plp.6;
        Tue, 02 Oct 2018 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=zSFnQe3osAhSI/yCScn4VpMhcXnR9g7aaMBXVQdp4bM=;
        b=l1b0JEs6srj1RsDS4bSQIh1ayBpuE69qoqcMVgviT9a4CBdFGILy3EORYCtDV1ZXpA
         ddYC5odsDxiIOhOOLB+oMkGKHr0+SVihpETc7BiNVNUYjbUBiWpvkaJ3lZdpCSj9Crzz
         qDXOWViaMcNE/i9s8a+VZXYqFFy5T9dXw7MYEh5ap3c+/sDLRAVQ0nM1EZFRFmn7L5EU
         xVKfmpyCA3uWR+uBURbM2K7iUjt906h8c25rWY/Muw0auUCyTh/Oo26ECsa53qvRs08D
         eFuITRp4S6G6o4MYjQ2f76R+ZYsbqZLx0TOFcK+58JAPynQKtDPSNdbk3epO3WDUa40M
         Ezjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=zSFnQe3osAhSI/yCScn4VpMhcXnR9g7aaMBXVQdp4bM=;
        b=BcTgZdce5hQ6p/Lol2ZuQEq5LGqS36JwjhOFveFurdy+th0SHSjTglZ5lnygcTDDNA
         QP9HqX/uUQsrWvXkZ2VdRZMyA/yK/YlBOOIzVn6ykMgY3RVtzaJFdR3rkOc4p9IKWjMB
         TPgu760ETMXOYs+gfWko2fzON9WlRU0Udg1/usHinZPJZNr3/MZvTQwWVA1OSx8KZfST
         M5LH8sR1GGnvIW0/WW57YOU235sWSZ8zLBYVaE67AV5aLqSEcg2lDnvfksZ6ABe9NqMG
         UZet8VyinU0TlspyXphFAmXAgNaBL/94BkZJYFS6hP8Gw2oBDrx990K/d7kN8ppcytS2
         0BZw==
X-Gm-Message-State: ABuFfoj5OfAA6FYw5SgWu5kXOpbeV6N9Vb/I3ktyeY7F1s7s+QlPlflp
        bLzQW2JxQwQQfFdkjRuFR7+flQDEYac=
X-Google-Smtp-Source: ACcGV60DM6w+lxkhXNWo48Xsut1TnV2qSCplosRn4OgBkndHSXGOvfQne4ZBM9FT3MBIZR3WN1yBHQ==
X-Received: by 2002:a17:902:6689:: with SMTP id e9-v6mr19898972plk.115.1538545183362;
        Tue, 02 Oct 2018 22:39:43 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id h4-v6sm570978pfe.49.2018.10.02.22.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:39:42 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id C82EA1643D0; Tue,  2 Oct 2018 22:39:41 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 01/16] x86/PCI: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:47 -0700
Message-Id: <20181003053902.6910-2-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <linux-pci@vger.kernel.org>
---
 arch/x86/pci/i386.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index ed4ac215305d..24bb58a007de 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -59,7 +59,7 @@ static struct pcibios_fwaddrmap *pcibios_fwaddrmap_lookup(struct pci_dev *dev)
 {
 	struct pcibios_fwaddrmap *map;
 
-	WARN_ON_SMP(!spin_is_locked(&pcibios_fwaddrmap_lock));
+	lockdep_assert_held(&pcibios_fwaddrmap_lock);
 
 	list_for_each_entry(map, &pcibios_fwaddrmappings, list)
 		if (map->dev == dev)
-- 
2.19.0

