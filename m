Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359B9C04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEEF2146D
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 07:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vD/qvUd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEEF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeLFHfy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:35:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33747 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbeLFHfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 02:35:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so10270515pgu.0;
        Wed, 05 Dec 2018 23:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2ZsWQVz6K7IMqGD7I8xBIJdRSxJKWbe6GSMqRClhDU=;
        b=vD/qvUd5WEtJaYTUSEU5qCoQHtssNX69nO2w8+O42oBcdbGTkAPVbKyq6G/cy6kiH3
         JnyNb2AcVWvSq5ioFEjIm11oOF80Wqrn7G/8eD6mBtxSZf0ku3CoE7f04LWdsMt2HIA6
         Gj9W8EqZ/uL2oyl65+a/aORxikIUtBJ2J7mIm4DyxXncxXOUg2jLC0V7Bi/kE2GzWr6B
         e2W1xDJ3ZkSi6jl9RXp8syFdKsyQk2pBlB8BMm2SpVarM6pPZUWfzyfpFYdQMRWwNluv
         iC9HFaGXSYX9kxYBTIkCxRCqM6TzCwZDcMwzeOUu52abq+6DRE2cIQ0N2/2H0Amnc1aT
         L6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2ZsWQVz6K7IMqGD7I8xBIJdRSxJKWbe6GSMqRClhDU=;
        b=Tkkw9oaAmPUmGJj+5wxd1Wn7nmrVcSwJGzRW79Zd/MThQc2Tso0stCCT8F9AdkSStV
         d2+9ib2eQeSApOryXknEEVLw/EpEPd7cyQikrc+wPoUUjhBUWwRJovn9nAo/xmUoHeGi
         arsNW9MA4zl0uxXZMqffkQyM9V66hoSIJZkM80bSv7/wIpLN2g2m4wrFGs/R62wHGBOK
         PB6RLSQWCq9meI4stUAJ5E7pqlYPjLVX832OcJqa8v8o6e54oiRNuHgzzfJqYdBnaLyN
         d4I353/4US53QWFLrHvNAOlUItX+bpPGtNbXrxCK2Tto+fWlqvkvSmwcJ2nHVPNA8mvg
         qwaQ==
X-Gm-Message-State: AA+aEWYSZEEYS3fOmHD1DSeM328L2MIaUULSyPWIvOAbL/XwfahFiTRX
        TJhQNrXdXTGDqoW1TAoYNgnDx9S0
X-Google-Smtp-Source: AFSGD/X96cga7L2HEXEND/HglZJZWnpJQvLeHPfyFWieLW8Y+GWIparzOiEDUQihnwlxtLrFGBTl3g==
X-Received: by 2002:a63:64c:: with SMTP id 73mr23027435pgg.373.1544081753354;
        Wed, 05 Dec 2018 23:35:53 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v15sm33035894pfn.94.2018.12.05.23.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:35:52 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, bhelgaas@google.com,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] PCIE support for i.MX8MQ
Date:   Wed,  5 Dec 2018 23:35:42 -0800
Message-Id: <20181206073545.10967-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Everyone:

This series contains changes I made in order to enable support of PCIE
IP block on i.MX8MQ SoCs (full tree can be found at [github-v2]).

NOTE: The last patch have a Kconfig symbol depenency on [imx8mq-kconfig].

Changes since [v1]:

 - Driver changed to use single "fsl,controller-id" property to
   distinguish between two intances of PCIE IP block

 - All code pertaining to L1SS was dropped to simplify the patch

 - Documented additions to DT bindings

Feedback is welcome!

Thanks,
Andrey Smirnov

[v1] https://lore.kernel.org/linux-arm-kernel/20181117181225.10737-1-andrew.smirnov@gmail.com/
[github-v2] https://github.com/ndreys/linux/commits/imx8mq-pcie-v2
[imx8mq-kconfig] https://lore.kernel.org/linux-arm-kernel/20181114175242.12468-1-l.stach@pengutronix.de/

Andrey Smirnov (3):
  PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
  PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
  PCI: imx: Add support for i.MX8MQ

 .../bindings/pci/fsl,imx6q-pcie.txt           |  6 +-
 drivers/pci/controller/dwc/Kconfig            |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 87 ++++++++++++++++++-
 3 files changed, 90 insertions(+), 5 deletions(-)

-- 
2.19.1

