Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D940C433E6
	for <linux-pci@archiver.kernel.org>; Fri, 19 Feb 2021 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C1964EB4
	for <linux-pci@archiver.kernel.org>; Fri, 19 Feb 2021 14:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhBSOtD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Feb 2021 09:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhBSOsq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Feb 2021 09:48:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74C9B64DA8;
        Fri, 19 Feb 2021 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613746085;
        bh=Kzw8IGCLSSobTf8Sdkya+7Ssi9f530ZsrCQ+iE4rq0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=We+JJYLypeo/RFwLeiuKqd8vSG7hGAp+M6rkI6LWRHl0KSzvNYSo4p3IdqZYf3SlN
         2ufM2BVTr+Sg5tTE4xIi5LMcEaUqURy1fVoEice2gMDC7lCDVPVZyECpO+d2c+Y0Z2
         zK1AAAxA38J77G1YmuJHuPd41WRP9gYocE516xa6tv6d45Km2wLlY+Sm2zbg/18+m2
         faC/eZpXPkHRPWw4BGj6CRCEvDM5o/VKf0Y2DBqkgB3CUHT/Mdv3qAWJK1MdXawNcV
         12UCske9OcXDG68ASyox6lZyPmCp/rCy77Sn5wxvBkoDg0TkNxoGNgzYOHxVTJ1OAu
         T9Dhlq4OUQFcg==
Date:   Fri, 19 Feb 2021 15:48:00 +0100
From:   Robert Richter <rric@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     corbet@lwn.net, jarkko.nikula@linux.intel.com,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        bhelgaas@google.com, wsa@kernel.org, linux-doc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] PCI: Introduce pcim_alloc_irq_vectors()
Message-ID: <YC/PoOOgRVHa1HIH@rric.localdomain>
References: <20210218150458.798347-1-zhengdejin5@gmail.com>
 <20210218150458.798347-2-zhengdejin5@gmail.com>
 <YC/NxfsQn2RKkrp8@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC/NxfsQn2RKkrp8@rric.localdomain>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19.02.21 15:40:11, Robert Richter wrote:
> static inline int pcim_alloc_irq_vectors(struct pci_dev *dev,
> 	unsigned int min_vecs, unsigned int max_vecs, unsigned int flags)
> {
> 	if (!pci_is_managed(dev, min_vecs, max_vecs, flags))

Obiously this is meant here:

	if (!pci_is_managed(dev))

> 		return -EINVAL;
> 
> 	return pci_alloc_irq_vectors(dev, min_vecs, max_vecs, flags);
> }
