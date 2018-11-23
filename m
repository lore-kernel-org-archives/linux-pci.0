Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8631C43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 11:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2C720865
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 11:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2C720865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbeKWWcW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:32:22 -0500
Received: from foss.arm.com ([217.140.101.70]:42806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387844AbeKWWcW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 17:32:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC0F83620;
        Fri, 23 Nov 2018 03:48:26 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C81B03F5A0;
        Fri, 23 Nov 2018 03:48:24 -0800 (PST)
Date:   Fri, 23 Nov 2018 11:48:16 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCHv3 0/4] dts/layerscape-pci: removed unsuitable compatible
 string
Message-ID: <20181123114816.GA3564@e107981-ln.cambridge.arm.com>
References: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
 <20181119120123.GQ5829@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119120123.GQ5829@dragon>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 19, 2018 at 08:01:25PM +0800, Shawn Guo wrote:
> On Wed, Nov 07, 2018 at 05:35:12AM +0000, Z.q. Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > 
> > Removed the compatible string "snps,dw-pcie" from FSL layerscape-pci compatible
> > string list.
> > 
> > Hou Zhiqiang (4):
> >   dt-bindings: pci: layerscape-pci: add compatible strings
> >     "fsl,ls1043a-pcie"
> >   dt-bindings: pci: layerscape-pci: removed compatible string
> >     "snps,dw-pcie"
> >   ARM: dts: ls1021a: removed compatible string "snps,dw-pcie"
> >   arm64: dts: layerscape: removed compatible string "snps,dw-pcie"
> 
> Applied all, thanks.

Ok, thanks, patches dropped from PCI patch queue.

Lorenzo
