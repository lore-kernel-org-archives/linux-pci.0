Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61167C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 17:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E5920823
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 17:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHvJtvyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfCZRXx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:23:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38803 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZRXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2019 13:23:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id e80so12239220ote.5;
        Tue, 26 Mar 2019 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POhWQIt+7MKKaB0xpr8RCC2Gi7vnEhrJDayyqfFtsbU=;
        b=JHvJtvyJPNSo+HDI3O7LUbgFSAoKWqiK3xAPrdEDOHPmAjIxTX8HdIgpu5kRLeTYmG
         D2ic5C23vN3pW7Bv3LMc1JMFV48cFhW850dIIrA+t8tO3t0Rh2MJ7D6EnJHRWz52o2M6
         HrOC9eDL5XDADZCU+UX42MHeImCYJMqWbzTCR5P1ZT71eLBmRfrFX+iCW2kpflatDeNz
         5nEx6raxwOSBU5+OQOI/WxTChZxGdUTcoiIJFo/0fwLfIXwSb+h1hYxTal7y6MFkMLzd
         x4qig8zmA/8PrYol34fPVvhv7SoAEB18tnbojWbrAw8U20QcG/aOxkU8l+4U4VuHJAZM
         a5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POhWQIt+7MKKaB0xpr8RCC2Gi7vnEhrJDayyqfFtsbU=;
        b=oW5I8xh8sS16OWwLlzWwr5rZhDOheycD6C+RJXmSETtj1teS4zS6cGBdw1gFMzOubo
         0G33WxbBTrrm0MbkNppm3qYYpcqWtit7+STxkHD+pCWJmVctyUA/Sff49pAd/a4qXa+d
         VCzOqE2nZUhfjh3BgKA0aj4P3pzpdiR9pQFkpJjvcxJQ7qSOuVsbM1YSo32NAQZOJxtg
         VGuEKJz/oQjO33S153vFN3VpGTGJeK3uz5SP6mUe4+gUlE7mSn9j5zeGWSVx0sttWG3D
         1ZCXjDC6NqFwY0kTEpHrCYkbofBUNl6IsjYtLwRBQ1quvMNQP/t1bSvvUa9vDYZlDYuP
         3VZQ==
X-Gm-Message-State: APjAAAUAUWNfdOgR/TQVy5lWbq/GXOZLSHitAJdje5jLWUbxDwYZTyhB
        7FqSXzJxmtv7SiYIHSLBO/I=
X-Google-Smtp-Source: APXvYqxV49KQ0KIVmX2RkMEowFct5KcJJEg8z5my4fLysNPQXWdjr4S/z3f64Wxu3k1PqZri9cA2MQ==
X-Received: by 2002:a9d:5e90:: with SMTP id f16mr23703768otl.276.1553621032105;
        Tue, 26 Mar 2019 10:23:52 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id z12sm3047459otp.2.2019.03.26.10.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 10:23:51 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, scott.faasse@hpe.com, leo.duran@amd.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] PCI/AER: Consistently use _OSC to determine who owns AER
Date:   Tue, 26 Mar 2019 12:23:40 -0500
Message-Id: <20190326172343.28946-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This started as a nudge from Keith, who pointed out that it doesn't make sense
to disable AER services when only one device has a FIRMWARE_FIRST HEST.

I won't re-phrase the points in the original patch [1]. The patch started a
long discussion in the ACPI Software Working Group (ASWG). The nearly unanimous
conclusion is that my original interpretation is correct.

I'd like to quote one of the tables that was produced as part of that
conversation:

(_OSC AER Control, HEST AER Structure FFS) = (0, 0)
	* OSPM is prevented from writing to the PCI Express AER registers.
	* OSPM has no guidance on how AER errors are being handled – but it
	  does know that it is not in control of AER registers. PCI-e errors
	  that make it to the OS (via NMI, etc) would be treated as spurious
	  since access to the AER registers isn’t allowed for proper sourcing.


(_OSC AER Control, HEST AER Structure FFS) = (0, 1)
	* OSPM is prevented from writing to the PCI Express AER registers.
	* OSPM is being given guidance that Firmware is handling AER errors and
	  those interrupts are routed to the platform. Firmware may pass along
	  error information via GHES


(_OSC AER Control, HEST AER Structure FFS) = (0, Does not exist)
	* OSPM is prevented from writing to the PCI Express AER registers.
	* OSPM has no guidance on how AER errors are being handled – but it
	  does know that it is not in control of AER registers. PCI-e errors
	  that make it to the OS (via NMI, etc) would be treated as spurious
	  since access to the AER registers isn’t allowed for proper sourcing.

(_OSC AER Control, HEST AER Structure FFS) = (1, 0)
	* OSPM is in control of writing to the PCI Express AER registers.
	* OSPM is being given guidance that AER errors will interrupt the OS
	  directly and that the OS is expected to handle all AER capability
	  structure read/clears for the devices with this attribute (or all if
	  the Global Bit is set.)

(_OSC AER Control, HEST AER Structure FFS) = (1, 1)
	* OSPM is in control of writing to the PCI Express AER registers.
	* OSPM is being given guidance that although OS is in control of AER
	  read/writes – the actual interrupt is being routed to the platform
	  first.
	* Subsequent fields with masks/enables should be performed by the OS
	  during initialization on behalf of firmware. These are to be honoured
	  in this mode because with FF, the firmware needs to be able to handle
	  the errors it expects and not be given errors it was not expecting to
	  handle.
	* Firmware may pass along error information via GHES, or generate an OS
	  interrupt and allow the OS to interrogate AER status directly via the
	  AER capability structures.


(_OSC AER Control, HEST AER Structure FFS) = (0, Does not exist)
	* OSPM is in control of writing to the PCI Express AER registers.
	* OSPM has no guidance from the platform and is in complete control of
	  AER error handling.


There may be one caveat. Someone mentioned in the original discussions that
there may exist machines which make the assumption that HEST is authoritative,
but did not identify any such machine. We should keep in mind that they may
require a quirk.

Alex


[1] https://lkml.org/lkml/2018/11/16/202

Changes since v1:
 * Started 6-month conversation in ASWG
 * Re-phrased commit message to reflect some of the points in ASWG discussion

Alexandru Gagniuc (2):
  PCI/AER: Do not use APEI/HEST to disable AER services globally
  PCI/AER: Determine AER ownership based on _OSC instead of HEST

 drivers/acpi/pci_root.c  |  9 +----
 drivers/pci/pcie/aer.c   | 82 ++--------------------------------------
 include/linux/pci-acpi.h |  6 ---
 3 files changed, 5 insertions(+), 92 deletions(-)

-- 
2.19.2

