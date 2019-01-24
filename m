Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C6C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 05:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875512184C
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 05:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g11UTlqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbfAXFhF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:37:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35730 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfAXFg6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 00:36:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so5074965wrb.2
        for <linux-pci@vger.kernel.org>; Wed, 23 Jan 2019 21:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcZH7cC6exfKxobfl1ESzgn6ZuhKgr3b9rR3EXyUKz0=;
        b=g11UTlqGHb4re09Bz6qphfUusi21Oo9FJmq7u1jrmiBI+r74qLgd6V00Bk5Z1Rlsij
         Bre3tMOtIwglov+QtWRZQZS0gTOhE7mBWFTKjjOZ7++FObDeke6r4ZKEDMoja9tthEPr
         yQ3gVLKkk3PYG5XthY6KDnINSsFEa3qH6I8l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcZH7cC6exfKxobfl1ESzgn6ZuhKgr3b9rR3EXyUKz0=;
        b=pQN1IuXTywzxldmbUPxBfbpxHcAdStqK2YyR/2o7r4Nr83nq1eK1yWubhN9wmYBQUE
         OZMSHdkg4kg91meOcnns8yEd+WGuyt6PqMGuaPGuyhLYmE83WLK/IXJ3oyAG4GuMTPSK
         x/LpgNzbtI1ovLH7HMwXKk5pJrx3o0Gc6wBLSPDhgX/EHqjuEVuOtNv21mE4ygSJQloP
         ePDrhDRnSIXuI0vIl+VNGwh2ZGVTEf3lhniVO+WuuR/tRGT1jIIHpaLGBOXjwUz82r9W
         E1wIsBZ1NZN5GVmJkAbaAvgaoL6qC4YriBPQ3nOX8/kJe1p9ZZpPLzBbctCNggntWg6H
         synQ==
X-Gm-Message-State: AJcUukd9gSda6G3Tq04IVdkpTPogiIY27i1OLYwvYM+RBCYax0bJcLw8
        apRtbRjGNglqf0wdSliq5q1FPykyQSul1WtJT21Faw==
X-Google-Smtp-Source: ALg8bN5XwwfwWAn8am9FawfFKsVmG1HXntlLk3XWIua/NbW5xyrom/V7kEXWUHTdHbceMlspy5/TcB8rw/0bzfcUaeo=
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr5543499wrm.83.1548308216235;
 Wed, 23 Jan 2019 21:36:56 -0800 (PST)
MIME-Version: 1.0
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com> <20190118144149.GA25249@google.com>
In-Reply-To: <20190118144149.GA25249@google.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 24 Jan 2019 11:06:44 +0530
Message-ID: <CABe79T6=2uf1SrpDEm9s3smDkcR0JB-Gq8VwDF4yL8zBL6w0zw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add IPROC PCIe new features
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the review. I will address your comments in the next patchset.

Regards,
Srinath.

On Fri, Jan 18, 2019 at 8:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jan 18, 2019 at 09:53:20AM +0530, Srinath Mannam wrote:
> > Add changes related to IPROC PCIe RC IP new features.
> >
> > This patch set is based on Linux-5.0-rc2.
> >
> > Srinath Mannam (3):
> >   PCI: iproc: Add feature to set order mode
>
> Since this apparently refers to a PCIe feature, the subject should use the
> exact terminology used in the PCIe spec.
>
> >   PCI: iproc: CRS state check in config request
>
> This subject should start with a verb, not "CRS".
>
> >   PCI: iproc: Add PCIe 32bit outbound memory configuration
> >
> >  drivers/pci/controller/pcie-iproc.c | 172 +++++++++++++++++++++++++++++++++++-
> >  drivers/pci/controller/pcie-iproc.h |  16 ++++
> >  2 files changed, 184 insertions(+), 4 deletions(-)
> >
> > --
> > 2.7.4
> >
