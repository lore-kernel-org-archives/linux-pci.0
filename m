Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE46C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 08:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F72D20700
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 08:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfBVIgB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:36:01 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:45577 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfBVIgB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Feb 2019 03:36:01 -0500
Received: from windsurf (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 41DAF10000C;
        Fri, 22 Feb 2019 08:35:55 +0000 (UTC)
Date:   Fri, 22 Feb 2019 09:35:54 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Leigh Brown <leigh@solinno.co.uk>,
        =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common
 bridge emul code
Message-ID: <20190222093554.367e3c91@windsurf>
In-Reply-To: <20190221232317.GB219879@google.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
        <20190221232317.GB219879@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On Thu, 21 Feb 2019 17:23:17 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Lorenzo, I assume you'll take both of these, so for both patches,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> Maybe we should add a stable tag (v4.20+)?

Both patches have a Fixes: tag, so they should be automatically be
backported to the applicable stable kernels. From
Documentation/process/submitting-patches.rst.

  A Fixes: tag indicates that the patch fixes an issue in a previous
  commit. It is used to make it easy to determine where a bug
  originated, which can help review a bug fix. This tag also assists
  the stable kernel team in determining which stable kernel versions
  should receive your fix. This is the preferred method for indicating
  a bug fixed by the patch. See :ref:`describe_changes` for more
  details.

Isn't that sufficient ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
