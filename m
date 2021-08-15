Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ECBC4338F
	for <linux-pci@archiver.kernel.org>; Sun, 15 Aug 2021 10:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC24560F39
	for <linux-pci@archiver.kernel.org>; Sun, 15 Aug 2021 10:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhHOKhe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 15 Aug 2021 06:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237619AbhHOKhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 06:37:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7319460F39;
        Sun, 15 Aug 2021 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629023812;
        bh=y3HH8dTU1vjjNiKf8SEbgUBpnwG9NSmKj4wCFYCFoKE=;
        h=From:To:Cc:Subject:Date:From;
        b=C/BqcZvlIV/AusIO1BYJwvsYVWLhz1s/LQiuK94iRNdW1R0zTAML9BRGyJiNtQ5UH
         GigSXcrphQj1NCSMZBs7cY2v0TYrVQgRfn0+FL5JKepeZbEQNgDKjz8i+JUUOW8Y56
         DJNkU+UVliXqeJsaxmkVOYcR3QbEb8QrwJOj1I0VH10woQ+tuI4Wrl+IsTpQSzh64y
         yLWenF8aWM2S36MrfGnGjFYYSSsiMU8vWymaM3dgLqJkghVOMUCacy4u+RJ7p2jeir
         UWNQmxXgmUZWxRtRXbEQt3SV4QvBRUxTziu/oTCt1dCr7Q/SY1/wYH9pFcbaBuo5rS
         H5vO2TdIIfswg==
Received: by pali.im (Postfix)
        id 0BFA498C; Sun, 15 Aug 2021 12:36:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PCI: aardvark: MSI interrupt fixes
Date:   Sun, 15 Aug 2021 12:36:21 +0200
Message-Id: <20210815103624.19528-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fixes MSI and MSI-X interrupt support in
pci-aardvark.c driver and depends on patch series:
https://lore.kernel.org/linux-pci/20210625090319.10220-1-pali@kernel.org/

Pali Rohár (3):
  PCI: aardvark: Fix reading MSI interrupt number
  PCI: aardvark: Fix masking MSI interrupts
  PCI: aardvark: Enable MSI-X support

 drivers/pci/controller/pci-aardvark.c | 57 +++++++++++++++++++++------
 1 file changed, 44 insertions(+), 13 deletions(-)

-- 
2.20.1

