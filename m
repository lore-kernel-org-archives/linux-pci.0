Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBACECE561
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 01:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F165214C2
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 01:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jypLQSOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F165214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeISHY7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:24:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45603 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbeISHY7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 03:24:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B963221FB7;
        Tue, 18 Sep 2018 21:49:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 18 Sep 2018 21:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TkbrD3
        Z5mS/TrhR2eGrJmflwxC1YOPQMdlMIujcGRf8=; b=jypLQSOz98FwHaqw+eHu1L
        WA6ARy/+DkQmrVLL/ys2xm9cc/VO/3qfVjOjfS6Euwz/VWY65eFBpiPFq3vOZGPq
        eU+Dz+00aFFY63nmFwC63FuGeFjBN6RWG/IipfCIRbfCRpA2rzYMnqsaPedJtJRr
        TN3KMwsf5yYN3okoRuUOlqrs+z5NqGPIU7jt8jqHKETOA9ms4SvdsSIUh1FEzcF9
        gWSF1LVJlUsLcEmUzqFnyOGMsHgbYhhnpCvNdTfOclaY4wwlUTBst9ulgrtIoxV8
        Di/H0UAiRt3XDuXS7L4sy3P3+MgkMOvtq46gjDm4sey5OPUNifDtTsxDa7AuB8cQ
        ==
X-ME-Proxy: <xmx:LKuhW5iM-c9OmA5WTrB57tvxEu6Fijb2BpKEyz7t4_cXYhYZjP_sxw>
    <xmx:LKuhW7-1i1VaGUmp8VEgTF11WJH4uiWhMHwSefRb2w7jtPnMvMi0pg>
    <xmx:LKuhWwp6oAmdln7qOULjcl0-vRYH9CR97XoDsEZ5J8tRT9gl6fDP1Q>
    <xmx:LKuhW6_dyBFju2p1PoC4_Td4pWRImy-rtsn76sNHBz7evuOd8vMfQA>
    <xmx:LKuhW0VQmgQLbS3jhCy5jMLouh1n_0OjKxMrzDmPXcE6JhK-rB73vw>
    <xmx:LquhW7KSqtffKQ5x4dgPQ4eGr_tcTb0WjOG20cJuRIg7aFAPBFVw1A>
X-ME-Sender: <xms:LKuhW5gUUWOoFeer7IAS7JzEtXIrPqKKzIrZGXyuOLxJlxmp0NmVrw>
Received: from snap.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 26A3FE46B6;
        Tue, 18 Sep 2018 21:49:28 -0400 (EDT)
Message-ID: <1020abbb3d8a8f121d25da7327e296cfa1aaa698.camel@russell.cc>
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error
 handling
From:   Russell Currey <ruscur@russell.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, oohall@gmail.com,
        sbobroff@linux.ibm.com
In-Reply-To: <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
         <20180918215854.GH13616@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Sep 2018 11:49:26 +1000
Mime-Version: 1.0
X-Mailer: Evolution 3.28.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919014926.yX4q-KnX0Q1aUYKix5JXvTZTft33zCF5v1ihV4E34zc@z>

On Tue, 2018-09-18 at 16:58 -0500, Bjorn Helgaas wrote:
> On Wed, Sep 12, 2018 at 11:55:26AM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The original PCI error recovery functionality was for the powerpc-specific
> > IBM EEH feature.  PCIe subsequently added some similar features, including
> > AER and DPC, that can be used on any architecture.
> > 
> > We want the generic PCI core error handling support to work with all of
> > these features.  Driver error recovery callbacks should be independent of
> > which feature the platform provides.
> > 
> > Add the generic PCI core error recovery files to the powerpc EEH
> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
> > generic PCI error handling strategy.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> I applied the following to for-linus for v4.19.  Russell, if you want
> to be removed, let me know and I'll do that.

Oliver's email address for kernel stuff is oohall@gmail.com, I think benh has been
CCing his IBM address.  But other than that,

Acked-by: Russell Currey <ruscur@russell.cc>

Thanks for this, Bjorn.

- Russell

> 
> commit 3fed0e04026c
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Sep 12 11:55:26 2018 -0500
> 
>     MAINTAINERS: Update PPC contacts for PCI core error handling
>     
>     The original PCI error recovery functionality was for the powerpc-specific
>     IBM EEH feature.  PCIe subsequently added some similar features, including
>     AER and DPC, that can be used on any architecture.
>     
>     We want the generic PCI core error handling support to work with all of
>     these features.  Driver error recovery callbacks should be independent of
>     which feature the platform provides.
>     
>     Add the generic PCI core error recovery files to the powerpc EEH
>     MAINTAINERS entry so the powerpc folks will be copied on changes to the
>     generic PCI error handling strategy.
>     
>     Add Sam and Oliver as maintainers for this area.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ece30f15777..f23244003836 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11203,8 +11203,14 @@ F:	tools/pci/
>  
>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>  M:	Russell Currey <ruscur@russell.cc>
> +M:	Sam Bobroff <sbobroff@linux.ibm.com>
> +M:	Oliver O'Halloran <oliveroh@au1.ibm.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
> +F:	Documentation/PCI/pci-error-recovery.txt
> +F:	drivers/pci/pcie/aer.c
> +F:	drivers/pci/pcie/dpc.c
> +F:	drivers/pci/pcie/err.c
>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
>  F:	arch/powerpc/kernel/eeh*.c
>  F:	arch/powerpc/platforms/*/eeh*.c
