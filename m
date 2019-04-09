Return-Path: <SRS0=JnZd=SL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CFBC10F0E
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D562084C
	for <linux-pci@archiver.kernel.org>; Tue,  9 Apr 2019 15:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a75qcMrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDIP4i (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:56:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45967 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDIP4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2019 11:56:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so9522914pgk.12;
        Tue, 09 Apr 2019 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NArL0xgn+bI/z7O7fvH+UNWE/Wsc+R2ppo10VSmfkY=;
        b=a75qcMrQNdjNaqS/dkIGlUKP2r0WfpetLqBzkQ2FGrNL9kew0VikeR051l7kz4v16H
         wfEQqznm6DKEUfs1ByIiYrG775wVQu3rucRjWJE1jJqkHhcLl30scpmtl3oWOOGoNQLU
         6j0KnAQAYfNSyIXgO+hVIMIz6/AyZN5dv4hP78QMHXvoix4aY5/FaIuIG6sG1TMratqg
         3Xr5I841b0I1E9C6HchQj136pKksQQm3dJv9IwZkrkq7ILtM2jHOWxEdLKGEWy1xJZlt
         9PwHDYma0xgy0fEn/DkfZRqYB1aJdWSnoKNUgV/G9iCS7J7rqpMmoPWM6tsv2QHag/5w
         OFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3NArL0xgn+bI/z7O7fvH+UNWE/Wsc+R2ppo10VSmfkY=;
        b=BvMon7atCTPgQ8vULJJWL2S1w/je14LVaslk0hCVlGNJqCUCxeOCkidQ6ZV8licL8U
         SIUeZL4t13CVG0L8PqxhEeXxpyQeVoRMssCI/BE2YU0Qx+V4eD1d6mfnpCODPN270XI1
         fq5vr4w/FFxC7jZ/fw5swcuPjsu/9R3JdoLup9igB5axIGGMD7V8D+meEBPND8uuQAg+
         fqpSGSElDaamYXUAaUu1nVAiu1+8gkwypymAEzoT0+IN2ubLyYjOrw8UNq/Cis/xCCes
         4BC7ni8lu0RLyAaXonT6jSTZT/DEACllFehAWYrfyUsDgl45tC5PxAyJlWH/vn1bPlmX
         3niQ==
X-Gm-Message-State: APjAAAVFR6T4GZo6gFnJzZU2WW9vt/MpRFfZl7YS8QE/F1U+kctyYU69
        MIEOu4f8D7rF9Uc39qvfFEo=
X-Google-Smtp-Source: APXvYqxL2f8XhBDUYDymfUu/TvptAzD1eo0w+WFufa4gNFGwwDpyPT3Mf8hdJUp4GyleomTP9PVSGA==
X-Received: by 2002:a63:78b:: with SMTP id 133mr4719383pgh.307.1554825397620;
        Tue, 09 Apr 2019 08:56:37 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b72sm70383560pga.86.2019.04.09.08.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:56:36 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 00/12] Include linux PCI docs into Sphinx TOC tree
Date:   Tue,  9 Apr 2019 23:56:14 +0800
Message-Id: <20190409155626.6049-1-changbin.du@gmail.com>
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
v3: update titles. (Bjorn Helgaas)

Changbin Du (12):
  Documentation: add Linux PCI to Sphinx TOC tree
  Documentation: PCI: convert pci.txt to reST
  Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST
  Documentation: PCI: convert pci-iov-howto.txt to reST
  Documentation: PCI: convert MSI-HOWTO.txt to reST
  Documentation: PCI: convert acpi-info.txt to reST
  Documentation: PCI: convert pci-error-recovery.txt to reST
  Documentation: PCI: convert pcieaer-howto.txt to reST
  Documentation: PCI: convert endpoint/pci-endpoint.txt to reST
  Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
  Documentation: PCI: convert endpoint/pci-test-function.txt to reST
  Documentation: PCI: convert endpoint/pci-test-howto.txt to reST

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

