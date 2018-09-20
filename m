Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8E9ECE561
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 09:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3AA21523
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 09:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3AA21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeITOo3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:44:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeITOo3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 10:44:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83E067A9;
        Thu, 20 Sep 2018 02:02:03 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 549303F5C0;
        Thu, 20 Sep 2018 02:02:03 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C73F51AE3307; Thu, 20 Sep 2018 10:02:22 +0100 (BST)
Date:   Thu, 20 Sep 2018 10:02:22 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Douglas <adouglas@cadence.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: remove unnecessary check of device_type == pci
Message-ID: <20180920090222.GA17617@arm.com>
References: <20180829183440.13601-1-robh@kernel.org>
 <20180913145130.GA5756@e107981-ln.cambridge.arm.com>
 <CAL_JsqKoOJigMkiWqoG77+nstr-6=qiAeTePZkSThcfbVAtEQQ@mail.gmail.com>
 <20180919163301.GA21474@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919163301.GA21474@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 19, 2018 at 05:33:01PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Sep 18, 2018 at 12:05:40PM -0700, Rob Herring wrote:
> > On Thu, Sep 13, 2018 at 7:51 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Wed, Aug 29, 2018 at 01:34:40PM -0500, Rob Herring wrote:
> > > > PCI host drivers have already matched on compatible strings, so checking
> > > > device_type is redundant. Also, device_type is considered deprecated for
> > > > FDT though we've still been requiring it for PCI hosts as it is useful
> > > > for finding PCI buses.
> > >
> > > Hi Rob,
> > >
> > > I have no problem with the patch per-se, I can't parse though the second
> > > paragraph, in particular what you mean by "useful for finding PCI
> > > buses".
> > 
> > Device_type is the only generic way we can identify PCI buses which is
> > useful for dtc for example to do PCI binding checks. Maybe we can use
> > the node name which is what I'm doing for cpu nodes, but we've been
> > less consistent about that for PCI.
> > 
> > >
> > > What about the corresponding dts files ? I suspect we had better leave
> > > them alone lest we can trigger regressions with new dts and older
> > > kernels.
> > 
> > Yes. it will take some time before we can remove from dts files. Or
> > maybe only new ones change.
> 
> OK, thanks. What about PCI host controllers bindings ? I assume we leave
> the bindings (that enforce device_type) unchanged too.
> 
> If Will and Michal have no objections I will queue this patch as-is
> for v4.20.

Fine by me!

Will
