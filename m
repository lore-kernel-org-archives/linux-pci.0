Return-Path: <SRS0=a/OH=RK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AB1C43381
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 21:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C053D20851
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 21:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7y6Rbh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCGVir (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:38:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33489 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGViq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2019 16:38:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id q24so15585515otk.0;
        Thu, 07 Mar 2019 13:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=275DqyDJ75q090yQcnZc8/uC8L31weVnBHUg5MKeeaM=;
        b=q7y6Rbh45qBMt2XCIUU21iI7AYv+Y//5UQlqwoIwDg+Y7v2GQaTzMk+6jIwxb+IGPj
         Ya07JoD65+w//700MAVVr9W+ozuFS6TiNnauBRMGyFEZcP/AAOBytVmmR/fsKd8OfPB/
         qAr/dl2BDdGetuQiPOEbhGXWt7IkP4RHAWClZI0vTZNHeWE+XCwiu6oBw7KfRTWBpZBr
         ZGGx+mEKDqYPbsw8FQEJQAqEBmTw0SjLnt24uTm5dW51hVcBvz5mEPZ6CGyv3cgCkwWR
         8+S9mYOtLJIX8h+mhQNKR26EfL3fl54th9eoXWHlmv4a0jiVEH/ufyUY0giV1DGPuxdb
         f+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=275DqyDJ75q090yQcnZc8/uC8L31weVnBHUg5MKeeaM=;
        b=Inxe0Sd79SH6hhOrbpq7lLihJ3gsA+4VKgqwjRrFH5BD4qhLus9caJ3yZgKFt8QFVq
         n3BoNcfc1Vmq89TcaCJL73P8aqo6z50+8IjKAJJR53iOffTIOPTr1+2fhlW5QniySCEV
         Z7bYn2hE/S5HMcfM1gybruUCzW6NSCaL1NsRU9bknuNbHgD6rSstwQeJVdDNxyM1BHfV
         C+dOBzSLy7jKM8UnGAzBoxIHXLfnQzNesQ1/U7m3e3qn04MxzP0XXQ9oY+gDFmIL1VuO
         g7bxxThrJw2rbuhVjBtyb0NMvno+p0GrE4nDzgpJ26mudBsy2EJB2IQtfYC78z3drwg2
         pbdg==
X-Gm-Message-State: APjAAAU/ZcrSRvpATbAvW5cFDrEZSGRJ/XNrpP9NG472Ul/IwhLROUGK
        Er45/HriCix8QHdv6xhexYc=
X-Google-Smtp-Source: APXvYqwir5zE5jpoTG93x5YY4GGSDaNebAiAsa3Olk/0pIiqfb6JkfhBGsifFRTa8cCh7kKVBSvTsA==
X-Received: by 2002:a05:6830:1197:: with SMTP id u23mr9129644otq.254.1551994725657;
        Thu, 07 Mar 2019 13:38:45 -0800 (PST)
Received: from nuclearis2-1.lan ([2601:2c1:8501:182d::cdd])
        by smtp.gmail.com with ESMTPSA id p188sm2352205oia.58.2019.03.07.13.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 13:38:45 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v1 0/3] PCI: ACPI: Implement support for _HPX Type 3 tables
Date:   Thu,  7 Mar 2019 15:38:24 -0600
Message-Id: <20190307213834.5914-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Every decade or so, give or take a decade, our ACPI overlords realize
that the table they so generously gifted us is not really that useful.
Not to be outdone, they make a betterer version of it, which seems
like a good idea at the time. This is the story of the _HPX3 (well,
most of ACPI really).

Previous _HPX versions had a fixed number of fields, and could only
describe a very narrow set of useless register settings. _HPX3 extends
that to an arbitrary number of entries, that can cover the entire PCI
config space, and will be The Last _HPX Table Ever (TM). For the
sadomasochistic, the new ACPI 6.3 spec is here [1].

For our purposes, we had to re-organize code a bit, and the first two
patches in the series do this, albeit with minimal noise.
The last patch is the actual HPX3 stuff. In case you wonder why the
ACPI enums don't match the PCI device types... nobody really thought
of it or caught it at the spec writing stage.

In _HPX3 there's also the notion of vendor-specific extensions, and
VSEC/DVSEC. They are not implemented here because there's no hardware
to test that code path.

[1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf

RESEND because the first time 'git send-email' experienced an ID:10T error
originating between my keyboard and my chair. As a result of that error, it
did not send the cover letter to public mailing lists.

Alexandru Gagniuc (3):
  PCI / ACPI: Do not export pci_get_hp_params()
  PCI / ACPI: Remove the need for 'struct hotplug_params'
  PCI / ACPI: Implement Type 3 _HPX record

 drivers/pci/pci-acpi.c      | 172 +++++++++++++++++++++++++-----------
 drivers/pci/probe.c         | 130 ++++++++++++++++++++++++---
 include/linux/pci_hotplug.h |  74 +++++++++++++---
 3 files changed, 305 insertions(+), 71 deletions(-)

-- 
2.19.2

