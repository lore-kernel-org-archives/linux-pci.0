Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3CDC43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 17:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0567020861
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 17:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0567020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391594AbeKXEfx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:35:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbeKXEfx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 23:35:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB203574;
        Fri, 23 Nov 2018 09:50:38 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798403F5CF;
        Fri, 23 Nov 2018 09:50:36 -0800 (PST)
Date:   Fri, 23 Nov 2018 17:50:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [RESEND PATCH v3 2/2] PCI: uniphier: Add UniPhier PCIe host
 controller support
Message-ID: <20181123174754.GA9772@e107981-ln.cambridge.arm.com>
References: <1539667641-26024-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20181119161653.GA32232@e107981-ln.cambridge.arm.com>
 <20181120211531.3607.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120211531.3607.4A936039@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 20, 2018 at 09:15:31PM +0900, Kunihiko Hayashi wrote:

[...]

> > > +static int uniphier_pcie_link_up(struct dw_pcie *pci)
> > 
> > This function returns a bool value, make it return a bool.
> 
> This function is registered in struct dw_pcie_ops.link_up, that is defined
> in pcie-designware.h as follows:
> 
>        int     (*link_up)(struct dw_pcie *pcie);
> 
> Changing the return type of this function makes type mismatch,
> so I think it's difficult to change it.

You are right, it is fine.

Thanks,
Lorenzo
