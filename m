Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A29C433F4
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 16:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF312083A
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 16:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF312083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbeISWLt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:11:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34018 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbeISWLt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 18:11:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E68280D;
        Wed, 19 Sep 2018 09:33:09 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 865063F5BD;
        Wed, 19 Sep 2018 09:33:07 -0700 (PDT)
Date:   Wed, 19 Sep 2018 17:33:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Douglas <adouglas@cadence.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: remove unnecessary check of device_type == pci
Message-ID: <20180919163301.GA21474@e107981-ln.cambridge.arm.com>
References: <20180829183440.13601-1-robh@kernel.org>
 <20180913145130.GA5756@e107981-ln.cambridge.arm.com>
 <CAL_JsqKoOJigMkiWqoG77+nstr-6=qiAeTePZkSThcfbVAtEQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKoOJigMkiWqoG77+nstr-6=qiAeTePZkSThcfbVAtEQQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919163301.tQ7K0OPoTPeSLmk82u2lsWRjQQYGr5gPg9T698qXBfc@z>

On Tue, Sep 18, 2018 at 12:05:40PM -0700, Rob Herring wrote:
> On Thu, Sep 13, 2018 at 7:51 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Wed, Aug 29, 2018 at 01:34:40PM -0500, Rob Herring wrote:
> > > PCI host drivers have already matched on compatible strings, so checking
> > > device_type is redundant. Also, device_type is considered deprecated for
> > > FDT though we've still been requiring it for PCI hosts as it is useful
> > > for finding PCI buses.
> >
> > Hi Rob,
> >
> > I have no problem with the patch per-se, I can't parse though the second
> > paragraph, in particular what you mean by "useful for finding PCI
> > buses".
> 
> Device_type is the only generic way we can identify PCI buses which is
> useful for dtc for example to do PCI binding checks. Maybe we can use
> the node name which is what I'm doing for cpu nodes, but we've been
> less consistent about that for PCI.
> 
> >
> > What about the corresponding dts files ? I suspect we had better leave
> > them alone lest we can trigger regressions with new dts and older
> > kernels.
> 
> Yes. it will take some time before we can remove from dts files. Or
> maybe only new ones change.

OK, thanks. What about PCI host controllers bindings ? I assume we leave
the bindings (that enforce device_type) unchanged too.

If Will and Michal have no objections I will queue this patch as-is
for v4.20.

Thanks,
Lorenzo
