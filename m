Return-Path: <SRS0=XWMu=Q5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BB1C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 11:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48135206B6
	for <linux-pci@archiver.kernel.org>; Fri, 22 Feb 2019 11:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfBVLFU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:05:20 -0500
Received: from foss.arm.com ([217.140.101.70]:57786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfBVLFU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Feb 2019 06:05:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21FFDA78;
        Fri, 22 Feb 2019 03:05:20 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A573F5C1;
        Fri, 22 Feb 2019 03:05:18 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:05:12 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Leigh Brown <leigh@solinno.co.uk>,
        Lu??s Mendes <luis.p.mendes@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common bridge
 emul code
Message-ID: <20190222110450.GA32670@e107981-ln.cambridge.arm.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
 <20190221232317.GB219879@google.com>
 <20190222093554.367e3c91@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222093554.367e3c91@windsurf>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 22, 2019 at 09:35:54AM +0100, Thomas Petazzoni wrote:
> Hello Bjorn,
> 
> On Thu, 21 Feb 2019 17:23:17 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > Lorenzo, I assume you'll take both of these, so for both patches,
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thanks!
> 
> > Maybe we should add a stable tag (v4.20+)?
> 
> Both patches have a Fixes: tag, so they should be automatically be
> backported to the applicable stable kernels. From
> Documentation/process/submitting-patches.rst.
> 
>   A Fixes: tag indicates that the patch fixes an issue in a previous
>   commit. It is used to make it easy to determine where a bug
>   originated, which can help review a bug fix. This tag also assists
>   the stable kernel team in determining which stable kernel versions
>   should receive your fix. This is the preferred method for indicating
>   a bug fixed by the patch. See :ref:`describe_changes` for more
>   details.
> 
> Isn't that sufficient ?

Adding a CC: stable won't hurt so that it is certain it will get
stable kernels attention, that's what I will do.

Thanks,
Lorenzo
