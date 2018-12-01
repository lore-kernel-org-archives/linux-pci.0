Return-Path: <SRS0=IfUz=OK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3733C04EB8
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 00:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908022145D
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 00:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kvLOg+Vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908022145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLAMEG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:04:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42961 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLAMEG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Dec 2018 07:04:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so6785942otk.9
        for <linux-pci@vger.kernel.org>; Fri, 30 Nov 2018 16:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRYshC/pQ0qYWjfqH+kV5ROPjGOP9RnyUeFhFlXm0Nk=;
        b=kvLOg+VykFD85Cs3MSzczgd7cE8OVuFUzKtGaXU2nrt/4CFuAKf6rEJBdexLjM37iE
         eWK97PIgqWvotql6dKX5qbVj3AMRyjRlFHToSOiDVON76pQsN6AxZqOuOENvEkYAE3Q8
         Ji1Jeq46Hcg2f5WtDnp1rXsIibZMJSWsKo1eyWsNVUqDd3PNKiVaD7vkWmGqe6czYzNe
         qXH56xfOzbFGa8ktOuuuz/GZhcSATr1Z1GG9YKWDfgG149fUxWoiAJgARIXsFILYZpZa
         drGT7semM2bVAvokB1O2Apt+GRHWLEJMN5e/ZOE684215Uf3713eAj2YDwvISgl9NlRP
         4qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRYshC/pQ0qYWjfqH+kV5ROPjGOP9RnyUeFhFlXm0Nk=;
        b=GdZ+2m/VpYFbmFB6pvmIA2TmfC4i3hscEnn4lGzOa9y9Bhc0JFla8R69scQwhNZiWK
         uy5IckhOXDqgIa47LCAkkb56kpt1PlRI8uRp8W/QnOzB08GrMs9bVaNDD0drymYHrr0Z
         DHAAaRgpjJVfPYUHVtAHsskqxGi7iQfn34AwOKcf0EjTRjqZIfBiFIAPPacVgHRSja/d
         LqqRyd4fo5E622lSouvx57JBCeyJkncrB/UVLDvSNu8khI2/qnKoBmd6dvzWX1Jp6Si9
         6wAHkv6rHqQnx3h2zfv6Giam7OCUEFyAI6UWSyWRrOhRGNjQOVcFEU1QfZp4WeVRpLtP
         Lg+g==
X-Gm-Message-State: AA+aEWYcInM98KxRMP19fvtA7bvPCEWNOkUDpx0eBQPaLrA+sFIpihFs
        Xn33eLpE8kNO6qJdH+nH4bDzLtZIMPV2sGvmlQi/Qg==
X-Google-Smtp-Source: AFSGD/Wv3usxcnLZIpAsHPFAf5cdEwRibKsxWDdz8k0gLb564Mx3fVhcGiQs+xMWpPYdZbUh5ScDgQROCHIym3XnZig=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr4623979otl.32.1543625575051;
 Fri, 30 Nov 2018 16:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20181130225911.2900-1-logang@deltatee.com>
In-Reply-To: <20181130225911.2900-1-logang@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Nov 2018 16:52:43 -0800
Message-ID: <CAPcyv4jHF-3H09Zgtcm_+AVviMAvE1zfEQnoipAakE+o=KMpUg@mail.gmail.com>
Subject: Re: [PATCH] PCI/P2PDMA: Match interface changes to devm_memremap_pages()
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 30, 2018 at 2:59 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> "mm-hmm-mark-hmm_devmem_add-add_resource-export_symbol_gpl.patch" in the
> mm tree breaks p2pdma. The patch was written and reviewed before p2pdma
> was merged so the necessary changes were not done to the call site in
> that code.
>
> Without this patch, all drivers will fail to register P2P resources
> because devm_memremap_pages() will return -EINVAL due to the 'kill'
> member of the pagemap structure not yet being set.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
