Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C6BC4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425D4206DF
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYPz5GAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDCPuR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:50:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44689 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfDCPuR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 11:50:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so8238839pll.11;
        Wed, 03 Apr 2019 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YAsPV+3wt971TJitavnaBOUM/MA2kuirvHBnf75ItEk=;
        b=HYPz5GANrO/CSBx/gVQkdHvf0qQZPUsDrlmIvcslnuLAREtUBCAyvq7Qw72iVFFw5U
         LA7IQZNFV+gPQg6ywH9yqVBbpCJzcbH0bTap3/3X1KatvTpNdBsquatWQ5YfVzr/61n/
         Yv8po9/PqQsbgSa/5ufihEszRjgzApRRcgw6OUVh4Pak8Um557sEwfm1LPhA1jQcnyCv
         +4VGBFcG+AkiGLw1Ll58XyPeBTLKb2COXaWng4lqTS4zxXT15+3xAMIKdEBVNWfVD/E+
         ALldwRGx6UcLfQpxU3AUZ7hmQ2Dbc+q3/mKS9oV16TR5WF/VH5YOcRE2A/sZuZSyaGux
         8NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YAsPV+3wt971TJitavnaBOUM/MA2kuirvHBnf75ItEk=;
        b=nyT78l/wg5We0FuMf8066UqiqVn/bbh3j7Npo1BAJdD17ER/c4NJDjqZmPLsCBaPNJ
         lqcr5ZNe9nwAMLe0lhuoh0v+GS8selP8saOrRU+9WwEwVUysPtsTAEv5wcuw1d44iAeL
         oxwxhsZzoAFX14riByDvv39NjlMNxik3VRZHfmVtJk9x3ycXcXP+OP7MB8ceMeh8aZyX
         oNtlOVKdc8U1VCVK25ADSU+t70BtWkkQf8SlhOmDPDVSYXQ/xgfnqOjdIcBijCiNDFWW
         5jeQGK0Bpm7gCYnxqC6Z4BAgr1tsFipJN+3yYLoRHElDSmDWYa7cdwUWMjqSqXpNzHM1
         zE1Q==
X-Gm-Message-State: APjAAAUP1WMNJM+pN/AHULuKP0OFuTqqNL2SaKt7kfFQYZqsGS0F1wbC
        lYQQ+HNDjj4q6Y86ZKfvaOU=
X-Google-Smtp-Source: APXvYqz7A7N0UUqWhdNsZDhRqxnT3HXEV6+GlNcXrvxrtrouDyzmi7XkIvc85GydrON/p2P+LyNbWA==
X-Received: by 2002:a17:902:7589:: with SMTP id j9mr621505pll.287.1554306616264;
        Wed, 03 Apr 2019 08:50:16 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b8sm18906922pgq.33.2019.04.03.08.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:50:15 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 00/12] Include linux PCI docs into Sphinx TOC tree
Date:   Wed,  3 Apr 2019 23:49:43 +0800
Message-Id: <20190403154955.12096-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted most of the Linux PCI docs to rst
format in this serias.

For you to preview, please visit below url:
http://www.bytemem.com:8080/kernel-doc/PCI/index.html

Thank you!

v2: trivial style update.

Changbin Du (12):
  Documentation: add Linux PCI to Sphinx TOC tree
  Documentation: PCI: convert PCI/pci.txt to reST format
  Documentation: PCI: convert PCI/PCIEBUS-HOWTO.txt to reST format
  Documentation: PCI: convert PCI/pci-iov-howto.txt to reST format
  Documentation: PCI: convert PCI/MSI-HOWTO.txt to reST format
  Documentation: PCI: convert PCI/acpi-info.txt to reST format
  Documentation: PCI: convert PCI/pci-error-recovery.txt to reST format
  Documentation: PCI: convert PCI/pcieaer-howto.txt to reST format
  Documentation: PCI: convert PCI/endpoint/pci-endpoint.txt to reST
    format
  Documentation: PCI: convert PCI/endpoint/pci-endpoint-cfs.txt to reST
    format
  Documentation: PCI: convert PCI/endpoint/pci-test-function.txt to reST
    format
  Documentation: PCI: convert PCI/endpoint/pci-test-howto.txt to reST
    format

 .../PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst}      |  83 +++---
 .../{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}  | 140 +++++----
 .../PCI/{acpi-info.txt => acpi-info.rst}      |  11 +-
 Documentation/PCI/endpoint/index.rst          |  13 +
 ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++++---
 .../{pci-endpoint.txt => pci-endpoint.rst}    |  95 ++++---
 ...est-function.txt => pci-test-function.rst} |  32 ++-
 ...{pci-test-howto.txt => pci-test-howto.rst} |  81 ++++--
 Documentation/PCI/index.rst                   |  18 ++
 ...or-recovery.txt => pci-error-recovery.rst} | 178 ++++++------
 .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++++-----
 Documentation/PCI/{pci.txt => pci.rst}        | 267 +++++++++---------
 .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 110 +++++---
 Documentation/index.rst                       |   1 +
 MAINTAINERS                                   |   2 +-
 15 files changed, 754 insertions(+), 537 deletions(-)
 rename Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} (88%)
 rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (70%)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (82%)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
 rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)
 create mode 100644 Documentation/PCI/index.rst
 rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (80%)
 rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)
 rename Documentation/PCI/{pci.txt => pci.rst} (78%)
 rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (81%)

-- 
2.20.1

