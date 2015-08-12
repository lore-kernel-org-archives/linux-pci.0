Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35453 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbbHLPNm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 11:13:42 -0400
Received: by lbcbn3 with SMTP id bn3so11273487lbc.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2015 08:13:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439372036-15303-5-git-send-email-l.stach@pengutronix.de>
References: <1439372036-15303-1-git-send-email-l.stach@pengutronix.de>
	<1439372036-15303-5-git-send-email-l.stach@pengutronix.de>
Date: Wed, 12 Aug 2015 20:43:40 +0530
Message-ID: <CAHM4w1kj_WDkhFXuJrR57tMco-5HfR-zbD+C4h72cK9ZQOQSZA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] PCI: designware: change prototype of get_msi_addr
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 12, 2015 at 3:03 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Use phys_addr_t to allow the MSI target address to be above the
> 4GB mark for 64bit or PAE systems. No functional change for the
> current 32bit platform users as phys_addr_t maps to u32 for them.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
