Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B9CC56201
	for <linux-pci@archiver.kernel.org>; Thu, 12 Nov 2020 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3E421D40
	for <linux-pci@archiver.kernel.org>; Thu, 12 Nov 2020 17:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ScUqn50A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKLRjK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Nov 2020 12:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgKLRjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 12:39:10 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC613C0613D4
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 09:39:08 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id a15so1000210qvk.5
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 09:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9/BWB2JMcyfr9SsyIuCQhSr0cozjVOSg0qZsEvg/Gec=;
        b=ScUqn50Av3jkuanAHL9FGgKs2H2CEtXkHfhtLCKnJl/JiHzXM6ZbzMHOwZ2hp+OVWx
         Fi+0vs1eN6mEx8OmQp7fn4u8wWGm8kj8NVs7rBtEM7yvcDuwy5qDdx1T0eYjrmriTWdQ
         TA3moLECIUN1PPVAu7IX9pZj8s7lUFYHIf/pVvChzvfn/0oXRiGe/H0vUzt7bo0jX06e
         tmnOhDEESzGoBN/C/rIcyYQA3vEILCTSVyippGbU4XhjiCwQUYijQdef9FmKKpYJTadq
         RJuyOMJeRyyohYZIhVoK3M2B9uoBrkvVFWuxnJaphy18XoYCDwDAKW9xlbTD7A35Jvfi
         k+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/BWB2JMcyfr9SsyIuCQhSr0cozjVOSg0qZsEvg/Gec=;
        b=PKMQPZivA6Tf/wvDxG9mcjfNibFNKMP8u0zzKnaKwf66qiV67JjI4m2VYGBAmddvT5
         VE9391trWxOWJwAtbj+ZcCuXzQdboGh8aUfG3CZEXeKPzcTRRtCT3eDz+LafIvbIJrlb
         DP0rE2FDXGE1wRfjRl2dOL9UGESHGBEsL00oB5YPk1hUbymOdx0Dh/9ZuR2YI7aeUUqk
         7Wc2vJd/MFXlHQVzj8mBzBNzPFlyl77sYx2sJzSURWG4YCQaFhOvgar7UCfyeITU+6bl
         sRhwNvV+aKRcw2x9995PasBTiDpDGWYVK+NfdrQiUl9XRZst8nTTLQUOOPIF/50E1EQM
         4d/Q==
X-Gm-Message-State: AOAM533zBpgVJ5y8YyhRJLC+uguOygJcYhZDXHe1y5kQxGI4NjMly3uo
        O7RkSMz3OrM3u2CE3JnsvG1Y6A==
X-Google-Smtp-Source: ABdhPJxGjs7RKm1+d6vm7YlPcQDBoWbQJjGD0bECyIRJfi4QeWUNLlgH4DteMkEt2qfo5HNkxSMv+g==
X-Received: by 2002:a0c:f607:: with SMTP id r7mr714119qvm.47.1605202747806;
        Thu, 12 Nov 2020 09:39:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d12sm4989837qtp.77.2020.11.12.09.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 09:39:07 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdGYs-003z7n-Ku; Thu, 12 Nov 2020 13:39:06 -0400
Date:   Thu, 12 Nov 2020 13:39:06 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: remove dma_virt_ops v2
Message-ID: <20201112173906.GT244516@ziepe.ca>
References: <20201106181941.1878556-1-hch@lst.de>
 <20201112165935.GA932629@nvidia.com>
 <20201112170956.GA18813@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112170956.GA18813@lst.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12, 2020 at 06:09:56PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 12, 2020 at 12:59:35PM -0400, Jason Gunthorpe wrote:
> >  RMDA/sw: Don't allow drivers using dma_virt_ops on highmem configs
> 
> I think this one actually is something needed in 5.10 and -stable.

Done, I added a

Fixes: 551199aca1c3 ("lib/dma-virt: Add dma_virt_ops")

Jason
