Return-Path: <SRS0=0Z47=VZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1042FC7618F
	for <linux-pci@archiver.kernel.org>; Sun, 28 Jul 2019 20:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E2520657
	for <linux-pci@archiver.kernel.org>; Sun, 28 Jul 2019 20:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfG1UWs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 28 Jul 2019 16:22:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35031 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfG1UWr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2019 16:22:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so56543056ljh.2;
        Sun, 28 Jul 2019 13:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H30JE1TBEsAuw94izU6UpoMxwvUnP+RXDRNZnh1O8pc=;
        b=NLzJaWYk5pMNRm/jy6AFK25+6c/JRuiw6a2ZmsVY9Jk0rGXvm9qACQVpp1krrsUqhN
         WjiTp9weCHhsYEZPZ34ofjaooYmsITNBwfBMRlhfJXJZL6U5RrbJP8dnrLk8K3xeMemD
         BsCdoOYcOp73v7nJe++hkZweON+IrnjFEHiYtdOPQDWernOaqUDrkkWSOWQ8w2hrniJX
         iq/zg/OqExeQ5obLpXS0azII9NH2WQegjMCrK6W3Up2FweU6FwSttyYg+W3F9xklEjT5
         xeYFTkidA0pZOFNLbV/sU5DHAm9Gc8KqiSvhX8MBsaXVQu+9gIBB87BPwUHR2mKvDcNe
         B8Bw==
X-Gm-Message-State: APjAAAVw9yrGvkX3Y9WaxgQqHauF9mleTbSwOPNzyHk6e1pxChU9gXC6
        4matc8CsCj0kWRKmnMlRGRc=
X-Google-Smtp-Source: APXvYqygX2Y5dS/gnwNqOZKPSCByVOdOdiau/6PoALAhMf0ml07RPwI9uM2EKDeRpNnJ5yE9cYpa9g==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr20112908ljg.167.1564345365258;
        Sun, 28 Jul 2019 13:22:45 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id z17sm12395917ljc.37.2019.07.28.13.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 13:22:44 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] PCI: Convert pci_resource_to_user() to a weak function
Date:   Sun, 28 Jul 2019 23:22:08 +0300
Message-Id: <20190728202213.15550-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Architectures currently define HAVE_ARCH_PCI_RESOURCE_TO_USER if they want
to provide their own pci_resource_to_user() implementation. This could be
simplified if we make the generic version a weak function. Thus,
architecture specific versions will automatically override the generic one.

Denis Efremov (5):
  PCI: Convert pci_resource_to_user to a weak function
  microblaze/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
  mips/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
  powerpc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
  spark/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER

 arch/microblaze/include/asm/pci.h |  2 --
 arch/mips/include/asm/pci.h       |  1 -
 arch/powerpc/include/asm/pci.h    |  2 --
 arch/sparc/include/asm/pci.h      |  2 --
 drivers/pci/pci.c                 |  8 ++++++++
 include/linux/pci.h               | 18 +++---------------
 6 files changed, 11 insertions(+), 22 deletions(-)

-- 
2.21.0

