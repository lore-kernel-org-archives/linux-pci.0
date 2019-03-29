Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42903C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 19:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0038B2184D
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 19:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zxZsAqHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfC2Tc6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:32:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40382 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfC2Tc5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 15:32:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id t8so3072112otp.7
        for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2019 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4Yzf+CeFFZ/OjTiJqtBkGZm16+m8nmoCemxugx67kE=;
        b=zxZsAqHjy2Y9Bx4xA6zF2h+1CbpYruowgarysCor6ANLjnLGePYd87HqKjmFW25UWN
         hPmO2ck4OPgaGeQJMv8/EEEWlng/kHNbGlTXKS9B7dGBi52AxxxV7mqOV9YXV5s+J5b9
         46KrNLdVwWVSeUEdKUIQw/11HOobEoq2gXKv+Ga7wH72ZXFc4MPtFwgfzMiF0D+OiWtu
         Se/2SEFgkY8o67XAMWtQQSHCVzrAgci4FUoJViyvTORZHdqQ5expOvSUC5Zwch0xld1d
         4v7hpaOQRzUd704JnvlH6thRYy1kNEZd0zkL28FI61mqAGS3TN04F6ZYcALuPCb/a4dK
         qApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4Yzf+CeFFZ/OjTiJqtBkGZm16+m8nmoCemxugx67kE=;
        b=sV9YX8I2ljGrcdlVCshrahAWof08eX71h4l2QrxeuWsieUgoPJX3paTuY8BNuMVyAY
         rF+gQjcCwQt47SaekDVImpZUuA2EcrCxrQYeEM/5wXRlcjgV8eiAe+VUa5I+YafklB5w
         vPyZrEW84xi3KtjKt8+khJesavHXgnY0EKU+nx0z80KQ3Kt60SxLIZCXCWg3GA1sDIxS
         mXpVSv3fv9FNCe8cPzPNdbh+ZZ1NVFSLIwsamyAMcjJPNzh198vqKcEa1K/FxunvsfrV
         YFQwoFN4jHOUIY3ZNINtSPsApHtxtdGhLFkf3GVTCu4LEZu/3cCTtsSspwmNdXWWciqP
         ViRg==
X-Gm-Message-State: APjAAAXeYsi/THPrOk6ZKDhV6SkvYspdZluu8RqiJYDnLqtHeOfdVhvo
        UOzgf742Wryd4s3KATiT3XU4lDHvHvbvhR8jWw6y/w==
X-Google-Smtp-Source: APXvYqwKKdJS1Ua99aSwjJMfej/Pl2KR1kuLlRSNXUVME1MVVPAjFR1jZGMaGITHccVokDGIy7QDL3CNtMKk6tuVlMc=
X-Received: by 2002:a9d:7749:: with SMTP id t9mr6559409otl.229.1553887977043;
 Fri, 29 Mar 2019 12:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155387327020.2443841.6446837127378298192.stgit@dwillia2-desk3.amr.corp.intel.com>
 <cfda881b-d99c-7c53-64cb-745ff4b257b0@deltatee.com>
In-Reply-To: <cfda881b-d99c-7c53-64cb-745ff4b257b0@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Mar 2019 12:32:44 -0700
Message-ID: <CAPcyv4jZiK+OHjwNqDARv4g326AQZx7N_Lmxj1Zux_bX1T2CLQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] pci/p2pdma: Track pgmap references per resource, not globally
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        linux-pci@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 29, 2019 at 10:50 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Thanks Dan, this is great. I think the changes in this series are
> cleaner and more understandable than the patch set I had sent earlier.
>
> However, I found a couple minor issues with this patch:
>
> On 2019-03-29 9:27 a.m., Dan Williams wrote:
> >  static void pci_p2pdma_release(void *data)
> >  {
> >       struct pci_dev *pdev = data;
> > @@ -103,12 +110,12 @@ static void pci_p2pdma_release(void *data)
> >       if (!pdev->p2pdma)
> >               return;
> >
> > -     wait_for_completion(&pdev->p2pdma->devmap_ref_done);
> > -     percpu_ref_exit(&pdev->p2pdma->devmap_ref);
> > +     /* Flush and disable pci_alloc_p2p_mem() */
> > +     pdev->p2pdma = NULL;
> > +     synchronize_rcu();
> >
> >       gen_pool_destroy(pdev->p2pdma->pool);
>
> I missed this on my initial review, but it became obvious when I tried
> to test the series: this is a NULL dereference seeing pdev->p2pdma was
> set to NULL a few lines up.

Ah, yup.

> When I fix this by storing p2pdma in a local variable, the patch set
> works and never seems to crash when I hot remove p2pdma memory.

Great!

>
> >  void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
> >  {
> > -     void *ret;
> > +     void *ret = NULL;
> > +     struct percpu_ref *ref;
> >
> > +     rcu_read_lock();
> >       if (unlikely(!pdev->p2pdma))
> > -             return NULL;
>
> Using RCU here makes sense to me, however I expect we should be using
> the proper rcu_assign_pointer(), rcu_dereference() and __rcu tag with
> pdev->p2pdma. If only to better document what's being protected with the
> new RCU calls.

I think just add a comment because those helpers are for cases where
the rcu protected pointer is allowed to race the teardown. In this
case we're using rcu just as a barrier to force the NULL check to
resolve.
