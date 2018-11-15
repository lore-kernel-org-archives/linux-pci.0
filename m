Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C997C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 23:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0181F2145D
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 23:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsamsSTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0181F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeKPJ0J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:26:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38415 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeKPJ0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 04:26:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id u3so14542222ota.5;
        Thu, 15 Nov 2018 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Endo/rnyrZtQzjl63XIlDlk+0dMOEvUstgeXnyJyS2g=;
        b=KsamsSTGaj7EBVUbAIZgS9T7QGovy1ECRb9FIS9XU9sUYyBGhXoNh1Dxv+3p9Vb+MC
         rBge74EsJgxU7dSbXROotH6geTkJ8i/KZyLd3HwVJonemqEDH1Ziqo+AU/h6Zm0vrxph
         RGu/QdFcCc1SZwwYyNe80U3qp+gnfzF74r6n4yfrtwob7Wwep+SvBwBID8N+meev7cUK
         NskWGA+n2lJQgl3rgu0ky2Vk1x3UmPO5s5yzC6uPNYnAeSE+27jgCl0erJwC8bIZgO5k
         VjLuY1jTSF94wyopm5l0Tlxu76snt9z4RT5ZRK3DpuWe2USlEDYlqdLJdWo4D2LCrIy0
         MW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Endo/rnyrZtQzjl63XIlDlk+0dMOEvUstgeXnyJyS2g=;
        b=BJorB97ht5wJXG8GG6AFBjLJVuLVHJGxpAIWV0ve7cgcO68DKId8ckXZzoPjAc5fQd
         NPzoCygoHwDlLnc7Fvm07gwLjk4mP/DgrEb3dSaIiGZJ8grDU7vjbDJqZrFNwZN9bmdK
         w6kBUa4teSpJ178wmDj44tI2U4+9UthkCr04Ykrp3r8+RKTZzcVD6wEUMM8oAJQmHOez
         xgmS4V++qjB1IKNPRuEKFfLZGcf8LioulnEaz+OF1L+KwAkn4w+hS+SvNd3kfZ0/148v
         +3gjTy0iUmzyplhyLzkRBIwDQzk3snGnGe1+UjPJD85lU2tmF5kl17qd7RcJtv9u7mby
         P52w==
X-Gm-Message-State: AGRZ1gImhMW76zuXNaq8A7m0ztRs7uEBoKNtZFOKTXibSMctaw/g3/OG
        UjO+KxiEFkLOfB2MUtZrXzA=
X-Google-Smtp-Source: AJdET5frJbOEeY/44Q01Ar6ekmvTcypP0TiJnoI3eU4fo6IOIeyweFzux9/jZ+VI6V2Avp76imE1ow==
X-Received: by 2002:a9d:2aea:: with SMTP id e97mr5094109otb.206.1542323775740;
        Thu, 15 Nov 2018 15:16:15 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id o81-v6sm8680267oif.1.2018.11.15.15.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 15:16:15 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     helgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns AER
Date:   Thu, 15 Nov 2018 17:16:01 -0600
Message-Id: <20181115231605.24352-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks to Keith for pointing out that it doesn't make sense to disable
AER services when only one device has a FIRMWARE_FIRST HEST.

AER ownership is an interesting issue brought in by FFS (firmware-first)
model. In a nutshell if FFS handles AER, then OS should not touch any
of the AER bits. FW might set things up so that it receives AER
notifications via SMI. It's theoretically possible to receive SCIs,
but the exact mechanism is platform-dependent. OS touching AER bits
when firmware owns them may interfere with these notifications.

The ACPI mechanism for negotiating control of AER is _OSC, and is
described in detail in ACPI 6.2 Ch. 6.2.11.3. _OSC is negotiated at
the root bus level. Any root port, switch, or endpoint under the bus
would have its AER ownership negotiated in one _OSC call.

Then there is HEST, which is part of ACPI Platform Error Interfaces
(APEI). HEST tables describe the errors that FW may report to the OS.
A types 6,7 and 7 HEST tables describe AER errors from PCIe devices.
As part of this description, we're told if the error source is FFS.

Information in HEST seems to be redundant, as each error reported by
FW will have a CPER table that describes it in detail.

Because HEST describes an error source as firmware-first or not, we've
taken this to mean ownership of AER. Because AER ownership and error
reporting are coupled, _OSC and HEST usually agree on the matter of
ownership. However, that doesn't seem to be required by ACPI.

I've asked around a few people at Dell and they unanimously agree that
_OSC is the correct way to determine ownership of AER. In linux, we
use the result of _OSC to enable AER services, but we use HEST to
determine AER ownership. That's inconsistent. This series drops the
use of HEST in favor of _OSC.

[1] https://lkml.org/lkml/2018/11/15/62

Alexandru Gagniuc (2):
  PCI/AER: Do not use APEI/HEST to disable AER services globally
  PCI/AER: Determine AER ownership based on _OSC instead of HEST

 drivers/acpi/pci_root.c  |  9 +----
 drivers/pci/pcie/aer.c   | 82 ++--------------------------------------
 include/linux/pci-acpi.h |  6 ---
 3 files changed, 5 insertions(+), 92 deletions(-)

-- 
2.17.1

