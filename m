Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD03C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD79218A2
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 16:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKlQ92t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfC2QEc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:04:32 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39586 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfC2QEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 12:04:32 -0400
Received: by mail-pl1-f175.google.com with SMTP id b65so1241512plb.6;
        Fri, 29 Mar 2019 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YXILdX77K+hi8/lhchzWWbH8Caqo/qny7amt4lpsvc=;
        b=EKlQ92t0JKnkgzqpEqFa41XpEo9xdR0N7ugHGst23y5ZUXvhFVvTD555RJsjMTYH86
         vq0NLKNPhTNzEhbovSdYS+EpBUKd2GJoNBA5e3w1IHkJh2xPHJTD8RtP6nnLEi3saxNp
         v+rjfMW7oDYjZTjr7hKV7ZYnY760sRjBbl7/XtwamB7uvbCJjAZEUCieRJ2QqzqXQ+E+
         DCsoSjms1EDd8WOMc6yKCojpuWX7ykbQUcVHmSIcdAIQP/bb9odka85Y1+Xjg2EAWJYz
         RtzGUgG0R5POfqDfOI5CPoYuTfROKCVE8ExOMwA1RlaE/m2hrR6Snt9bCFfjg7IXN6NE
         6UEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8YXILdX77K+hi8/lhchzWWbH8Caqo/qny7amt4lpsvc=;
        b=CSabLdL8AwxAxL/GafguGZfGtdqwcR+0IqDG4PvB93t5FgCHr43GMAB6GD+axaOpU6
         SFoAPr00ntFdDIMpLbFngZY/SiUDO3V0y/snTPMB3l3Aj6V9oFH0itIf4J+qiK/d3Jhp
         0GwIEumG7q4OIseT0BMQqvlulGQ66DsRDbPz8BLsLJqpwy+ag6f9eKbbtLQA4IfqEvgv
         PjZcUJP5v/GBi8m3nkp2neEAKn0VU7K8LpJScWbINE0UuAB2/uW0XBrtgg5R0fJ8xxYo
         Hecyyujgy5e/gN2n/Z7PK9okG4yi168qvfrdLMe3mOYsdqqmBSr3au+TmnbU0abGyNsK
         63iw==
X-Gm-Message-State: APjAAAXm/sAWaKEK8SyW2YNlkMvKDW5pZTR/H3NGLIiK2uvTooJxWUmJ
        BfTRHk/tRZJYhXYGZ2Dz8Zs=
X-Google-Smtp-Source: APXvYqx37GfhxEkyhIeP5fh23cYnGBpHniEKB2i5hPlTvb+ItcVWWlgD6KNQYYZRJ5ul/aoGJXhugw==
X-Received: by 2002:a17:902:2b81:: with SMTP id l1mr3237349plb.289.1553875471318;
        Fri, 29 Mar 2019 09:04:31 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id i1sm9484285pgc.63.2019.03.29.09.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:04:30 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 00/12] Include linux PCI docs into Sphinx TOC tree
Date:   Sat, 30 Mar 2019 00:04:01 +0800
Message-Id: <20190329160413.4293-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Corbet,
I also did the conversion for PCI documentation. Please check, Thanks!

The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted most of the Linux PCI docs to rst
format in this serias.

For you to preview, please visit below url:
http://104.238.181.70:8080/kernel-doc/PCI/index.html

Thank you!

Changbin Du (12):
  Documentation: add Linux PCI to Sphinx TOC tree
  pci doc: convert PCI/pci.txt to rst format
  pci doc: convert PCI/PCIEBUS-HOWTO.txt to rst format
  pci doc: convert PCI/pci-iov-howto.txt to rst format
  pci doc: convert PCI/MSI-HOWTO.txt to rst format
  pci doc: convert PCI/acpi-info.txt to rst format
  pci doc: convert PCI/pci-error-recovery.txt to rst format
  pci doc: convert PCI/pcieaer-howto.txt to rst format
  pci doc: convert PCI/endpoint/pci-endpoint.txt to rst format
  pci doc: convert PCI/endpoint/pci-endpoint-cfs.txt to rst format
  pci doc: convert PCI/endpoint/pci-test-function.txt to rst format
  pci doc: convert PCI/endpoint/pci-test-howto.txt to rst format

 .../PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst}      |  56 +++--
 .../{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst}  | 112 +++++----
 .../PCI/{acpi-info.txt => acpi-info.rst}      |  11 +-
 Documentation/PCI/endpoint/index.rst          |  13 ++
 ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++++----
 .../{pci-endpoint.txt => pci-endpoint.rst}    |  74 +++---
 ...est-function.txt => pci-test-function.rst} |  32 +--
 ...{pci-test-howto.txt => pci-test-howto.rst} |  51 ++--
 Documentation/PCI/index.rst                   |  17 ++
 ...or-recovery.txt => pci-error-recovery.rst} | 180 ++++++++-------
 .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 144 +++++++-----
 Documentation/PCI/{pci.txt => pci.rst}        | 218 +++++++++---------
 .../{pcieaer-howto.txt => pcieaer-howto.rst}  |  67 ++++--
 Documentation/index.rst                       |   1 +
 MAINTAINERS                                   |   2 +-
 15 files changed, 641 insertions(+), 436 deletions(-)
 rename Documentation/PCI/{MSI-HOWTO.txt => MSI-HOWTO.rst} (89%)
 rename Documentation/PCI/{PCIEBUS-HOWTO.txt => PCIEBUS-HOWTO.rst} (75%)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (97%)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (86%)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
 rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (83%)
 create mode 100644 Documentation/PCI/index.rst
 rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (80%)
 rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (65%)
 rename Documentation/PCI/{pci.txt => pci.rst} (80%)
 rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (83%)

-- 
2.20.1

