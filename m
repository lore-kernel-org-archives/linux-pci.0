Return-Path: <SRS0=yR10=4N=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F968C35DE1
	for <linux-pci@archiver.kernel.org>; Tue, 25 Feb 2020 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA21D222C2
	for <linux-pci@archiver.kernel.org>; Tue, 25 Feb 2020 14:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWCtNvbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgBYODO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:03:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43505 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgBYODO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 09:03:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id r11so14864570wrq.10;
        Tue, 25 Feb 2020 06:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gT5zrM2j7XEtMlB7rHoEuszlfwjRx6IJBGVhnWU8za8=;
        b=hWCtNvbvUOUdk4K2EShu9FzOHbBorzKRWJunvJI4ZLaV/J+MGAuQb3AYW1Mn5+jcbn
         ZTtDmexNlmcBaSl5uuWo+w8hLruzzQ/wbfRnMWAYJmgsQMtLoC59sPePZugKWJEYfD1g
         9T82BYG5cdxvkUSaOAdQbMR0Tk2Kch+5VODE/it0LOUb7emCWewH6eqNAWPBpQYdeNPi
         G/HuJG2TvTBhPk0gJwVqN8cAlZTRC6mnjCP5eP/ea2gZGVG73SmG/w7vdN/BPGExb1rv
         +Emu9lFoHa/YvTQoGcV8yJgaP4gvQxzM+hakIcI0ns8OK45ZhdlUXVNyL7wrRgp8Fp31
         SjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gT5zrM2j7XEtMlB7rHoEuszlfwjRx6IJBGVhnWU8za8=;
        b=uc+wrjEndL6mFV0idYjrZeTNosHZRxGIyS0MIgfP48JvL7hK1adsrM7LUGMfsxBr7F
         U9uHz2d66lZw/LtryVrsqYPG4yLxSin250Y+KywsWA6W1DYu4KHtC54zoNclSlm+4Pc5
         D56WZAFknFAzI0H4c6gGaMrN9IEJwNvfG6UaGiyBpVW2jSM5HlXanLCwQwkOwO+mz4Zh
         jkIS3B3en7KohhdVjGmtUqiAOua5PQIdXa2Js4LEMcLFIfc+SgaHkmEmXQ+HQ2Zedx3Y
         JUPKoGzvQCmI0amQvc8iOJm6zv5uINuwedo7HfOOH6+J05bUUxp/wHGVbKI83EqVFMSj
         pumQ==
X-Gm-Message-State: APjAAAWiSHYRumFAlWz6UvWpFU0nbFW+uu/SVeM3dphbXBytan+mQG4/
        undrnWQtbxC1LZqnLE5Iw2Y=
X-Google-Smtp-Source: APXvYqzjvPCANPXCFeieo7Z7xtgMjQdPoQ0t/NA8OENUa0brXY7/kaqZFx/zHdDvsPU6g66uUU9LsQ==
X-Received: by 2002:adf:a35e:: with SMTP id d30mr68333564wrb.33.1582639390815;
        Tue, 25 Feb 2020 06:03:10 -0800 (PST)
Received: from ?IPv6:2003:ea:8f29:6000:30a8:e117:ed7d:d145? (p200300EA8F29600030A8E117ED7DD145.dip0.t-ipconnect.de. [2003:ea:8f29:6000:30a8:e117:ed7d:d145])
        by smtp.googlemail.com with ESMTPSA id u8sm4297464wmm.15.2020.02.25.06.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:03:10 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 0/8] PCI: add and use constant PCI_STATUS_ERROR_BITS and
 helper pci_status_get_and_clear_errors
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        David Miller <davem@davemloft.net>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        alsa-devel@alsa-project.org
Message-ID: <20ca7c1f-7530-2d89-40a6-d97a65aa25ef@gmail.com>
Date:   Tue, 25 Feb 2020 15:03:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few drivers have own definitions for this constant, so move it to the
PCI core. In addition there are several places where the following
code sequence is used:
1. Read PCI_STATUS
2. Mask out non-error bits
3. Action based on set error bits
4. Write back set error bits to clear them

As this is a repeated pattern, add a helper to the PCI core.

Most affected drivers are network drivers. But as it's about core
PCI functionality, I suppose the series should go through the PCI
tree.

v2:
- fix formal issue with cover letter
v3:
- fix dumb typo in patch 7

Heiner Kallweit (8):
  PCI: add constant PCI_STATUS_ERROR_BITS
  PCI: add pci_status_get_and_clear_errors
  r8169: use pci_status_get_and_clear_errors
  net: cassini: use pci_status_get_and_clear_errors
  net: sungem: use pci_status_get_and_clear_errors
  net: skfp: use PCI_STATUS_ERROR_BITS
  PCI: pci-bridge-emul: use PCI_STATUS_ERROR_BITS
  sound: bt87x: use pci_status_get_and_clear_errors

 drivers/net/ethernet/marvell/skge.h       |  6 -----
 drivers/net/ethernet/marvell/sky2.h       |  6 -----
 drivers/net/ethernet/realtek/r8169_main.c | 15 +++++-------
 drivers/net/ethernet/sun/cassini.c        | 28 ++++++++-------------
 drivers/net/ethernet/sun/sungem.c         | 30 +++++++----------------
 drivers/net/fddi/skfp/drvfbi.c            |  2 +-
 drivers/net/fddi/skfp/h/skfbi.h           |  5 ----
 drivers/pci/pci-bridge-emul.c             | 14 ++---------
 drivers/pci/pci.c                         | 23 +++++++++++++++++
 include/linux/pci.h                       |  1 +
 include/uapi/linux/pci_regs.h             |  7 ++++++
 sound/pci/bt87x.c                         |  7 +-----
 12 files changed, 60 insertions(+), 84 deletions(-)

-- 
2.25.1



