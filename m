Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA46C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A082070D
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 12:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfBVMpc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 07:45:32 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38575 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfBVMpc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 07:45:32 -0500
X-Originating-IP: 90.88.23.190
Received: from windsurf (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 94FC71BF212;
        Fri, 22 Feb 2019 12:45:29 +0000 (UTC)
Date:   Fri, 22 Feb 2019 13:45:28 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Leigh Brown <leigh@solinno.co.uk>,
        Lu??s Mendes <luis.p.mendes@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common
 bridge emul code
Message-ID: <20190222134528.138099c1@windsurf>
In-Reply-To: <20190222110450.GA32670@e107981-ln.cambridge.arm.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
        <20190221232317.GB219879@google.com>
        <20190222093554.367e3c91@windsurf>
        <20190222110450.GA32670@e107981-ln.cambridge.arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lorenzo,

On Fri, 22 Feb 2019 11:05:12 +0000
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> > Isn't that sufficient ?  
> 
> Adding a CC: stable won't hurt so that it is certain it will get
> stable kernels attention, that's what I will do.

Ah, yes, indeed. Sorry for forgetting about these, and thanks for
applying with those Cc: stable added!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
