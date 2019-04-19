Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F5CC282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D522E222AF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCvw4Vlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfDSSUX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:20:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46286 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfDSSUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2019 14:20:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id s24so4919835otk.13;
        Fri, 19 Apr 2019 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipjuS9qwCBATwNCfiYQ7UMxrBp0CW7IGZyik2RLkA8k=;
        b=BCvw4Vlg+myPyQWBJ2S3QoHoQcZKQVipkBr29A0k8XZovUaQSdNFIbceNqG82T02CQ
         KEC+jflXwJqTev+PKU4uJrmlHB/VSKdv42J/kXoQDVkKYl8nM14rUMcoiCp9Eev3Lvvt
         Rq60STu0ds5xhk/B+nJgGJe+3WI/RgSgkt8m3rzjJC7yOg6Gc1Y/D3Pp9bSG0xeDXil4
         24admgq16mUBdqzqaYjpQkE03jqAB8LKbvZnY7o0hwArtHc5U+Ib6UTaE0Myiyi+Ez4B
         7dWe1+zJSzNUk32+Ik4CBOkCXMHHy5W3Z9e6HQY+uPOV19vt+KmD9R5ORsGiYGnGlFV7
         Lq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipjuS9qwCBATwNCfiYQ7UMxrBp0CW7IGZyik2RLkA8k=;
        b=L2FHZZhRTEn1VUHBBhmQXpmb5qSPYcMdCLKOvpDl6k2yepSk6m2RLup9q4aMcdariP
         uiO3pgxK0LQqHGgrMMaE12ggzdCBtkziCIMFrjOX0BrOHaE6xkvuY9rMWaWLz0AI8uQR
         kwZD6LY3429/LfsYPh3ptHknoaXjMAQf86Rk9k9HwLBUw31ZeCGqN74Uvt5H4Fo4JsZO
         ltqwx81OeXHqAC9/yjDHk6D1yvt4XhLFqan1rxsFV0SuYdXr4yZJeLVDE4lW+NgzVu3F
         DXd99b8kRUlMDbQxFhv+7mjoWnAgPFJe7wwk8ZiAVoUHwGIbmKmOqcCppmZ5XUDPzmXD
         9cNg==
X-Gm-Message-State: APjAAAViuHCa7U8tsIzfkdrzo3ObrWOo05EvJGuLicGScW0TWqqaYRhA
        8YCW6vdhMwyJW66piApwDMVIYLtTKV8=
X-Google-Smtp-Source: APXvYqzZ8xyGTM3ZMXaIL3XSTamVAkCAEfCVf7lu1O9Ot6N30o43UgnFX8RvXrV7bMbRKOsacZGq3g==
X-Received: by 2002:a9d:19cd:: with SMTP id k71mr2433184otk.267.1555687368735;
        Fri, 19 Apr 2019 08:22:48 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id y9sm1981723otk.20.2019.04.19.08.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 08:22:47 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] PCI: pciehp: Do not turn off slot if presence comes up after link
Date:   Fri, 19 Apr 2019 10:22:22 -0500
Message-Id: <20190419152238.12251-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190419000148.GI126710@google.com>
References: <20190419000148.GI126710@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the old PCIe spec, PDS would always have to come up with
or before DLLLA. For various reasons, not all OEMs followed this
requirement. As a result, in PCIe 4.0(*), there is a new way to disable
in-band presence reporting, such that PDS always reports the status of
the out-of-band presence (if implemented).

For us, this means it is legal to get a Card Present event after the
link is active, and the driver was loaded. This causes an erroneous
removal of the device driver, followed by immediate re-probing.

In a fully PCIe-compliant world, we could leave inband presence
enabled and not require any software changes. However, certain OEMs
simply disable inband presence without implementing the requisite
query and control bits. I present two solutions to resolve this.

The first and last patch in the series are required. Of the remaining
two, only one is required to complete the series. Since we don't yet have
a go/no-go on which method to use, both solutions are included:
 - 2/4: Try to wait for PDS _before_ loading the driver
 - 3/4: Load as usual, and recognize the delayed PDS event as such

(*) ECN was approved in Nov 2018, and is normative spec text. A lot of
the leaked PCIe 4.0 specs do not have this change.

Changes since v2:
 * Dropped [RFC] from title
 * Addressed style issue found by Lukas

Alexandru Gagniuc (4):
  PCI: hotplug: Add support for disabling in-band presence
  PCI: pciehp: Do not turn off slot if presence comes up after link
  PCI: hotplug: Wait for PDS when in-band presence is disabled
  PCI: hotplug: Add quirk For Dell nvme pcie switches

 drivers/pci/hotplug/pciehp.h      |  1 +
 drivers/pci/hotplug/pciehp_ctrl.c | 24 ++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 52 ++++++++++++++++++++++++++++++-
 include/linux/pci.h               |  1 +
 include/uapi/linux/pci_regs.h     |  2 ++
 5 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.20.1

