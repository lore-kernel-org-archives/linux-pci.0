Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E65C282C8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 14:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F81820989
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 14:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfA1OBh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:01:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:48404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbfA1OBh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 09:01:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D9A8AF3D;
        Mon, 28 Jan 2019 14:01:36 +0000 (UTC)
Date:   Mon, 28 Jan 2019 15:01:35 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 7/7] MIPS: SGI-IP27: abstract chipset irq from bridge
Message-Id: <20190128150135.66f85834ab80813e6dc5ddf5@suse.de>
In-Reply-To: <20190128133317.GD744@infradead.org>
References: <20190124174728.28812-1-tbogendoerfer@suse.de>
        <20190124174728.28812-8-tbogendoerfer@suse.de>
        <20190128133317.GD744@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Jan 2019 05:33:17 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> Shouldnt this just use chained irqchip drivers instead?

you mean using irq_set_chained_handler() ? If yes, this IMHO doesn't look usefull
because it's used for adding a secondary interrupt controller. But what I need
is telling bridge ASIC to direct the xtalk IRQ packet to a specific HUB/HEART/BEDROCK
from the HUB/HEART/BEDROCK specific code. And want to avoid dragging in bridge details
to that specific code.

But I'm open reusing whatever fits the bill here.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
