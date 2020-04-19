Return-Path: <SRS0=+/lQ=6D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A1EC38A2F
	for <linux-pci@archiver.kernel.org>; Sun, 19 Apr 2020 04:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA76C21973
	for <linux-pci@archiver.kernel.org>; Sun, 19 Apr 2020 04:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="UOmx00zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDSEBI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 19 Apr 2020 00:01:08 -0400
Received: from mail.nic.cz ([217.31.204.67]:45604 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDSEBH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Apr 2020 00:01:07 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 9AFCB140C9C;
        Sun, 19 Apr 2020 06:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587268865; bh=UrRGZIJijw+vawifGSHtqyzyN2YE4XkTCoN71IMaOm4=;
        h=Date:From:To;
        b=UOmx00znzgZ69fqztOtqoJvuOPXYdgeCVrEBCNuqFWfu+Ur70H51XaCPeJQwNyIwH
         RD7thUVmx4Z2iIstMKFG14ZG5+L/1HQe0xw3OqygsE486fkb+jS2uaoMg7KJsqUoVn
         RrUxEiySBKRSfPzIUrjocSv/Jlx7ZaHkNQCr+KXE=
Date:   Sun, 19 Apr 2020 06:01:05 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200419060105.4c7bc4a5@nic.cz>
In-Reply-To: <20200415160054.951-1-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali, I tested this series with Compex WLE900VX and with a ASMedia SATA
card.

Both are visible with these patches.

But if I enable the pci-driver in U-Boot, kernel reports "link
never came up" fo the WLE900VX card. The SATA card works in this case.

advk-pcie d0070000.pcie: issuing PERST via reset GPIO for 1ms
advk-pcie d0070000.pcie: setup link speed to 2
advk-pcie d0070000.pcie: link never came up
advk-pcie d0070000.pcie: setup link speed to 1
advk-pcie d0070000.pcie: link never came up

We should try to somehow reset the whole PCIe controller in Linux. There
are the PCIe Core Warm Reset and PCIe PHY Warm Reset register. I also think
that maybe we should try to reset the whole PCI comphy.

Marek
