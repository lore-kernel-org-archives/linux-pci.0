Return-Path: <SRS0=QMyA=XU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3089C432C1
	for <linux-pci@archiver.kernel.org>; Wed, 25 Sep 2019 09:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8E72082F
	for <linux-pci@archiver.kernel.org>; Wed, 25 Sep 2019 09:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbfIYI77 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:59:59 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57785 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfIYI7t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2019 04:59:49 -0400
X-Originating-IP: 86.250.200.211
Received: from windsurf (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id EA14CFF802;
        Wed, 25 Sep 2019 08:59:44 +0000 (UTC)
Date:   Wed, 25 Sep 2019 10:59:44 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH 01/11] PCI: aardvark: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20190925105944.30fe64cd@windsurf>
In-Reply-To: <20190924214630.12817-2-robh@kernel.org>
References: <20190924214630.12817-1-robh@kernel.org>
        <20190924214630.12817-2-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 24 Sep 2019 16:46:20 -0500
Rob Herring <robh@kernel.org> wrote:

> Convert aardvark to use the common pci_parse_request_of_pci_ranges().
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 58 ++-------------------------
>  1 file changed, 4 insertions(+), 54 deletions(-)

Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
(on Armada 3720-DB, with a E1000E NIC)

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
