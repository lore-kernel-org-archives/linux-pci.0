Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E2DC433E0
	for <linux-pci@archiver.kernel.org>; Fri, 15 Jan 2021 06:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1CD23A05
	for <linux-pci@archiver.kernel.org>; Fri, 15 Jan 2021 06:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbhAOGbx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Jan 2021 01:31:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbhAOGbx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Jan 2021 01:31:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56E5E235DD;
        Fri, 15 Jan 2021 06:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610692272;
        bh=eQf9Y8eJMoRe88X1Cj0Th9MUH/4cRNQWkj9gmjjHO9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNU0dv+pTcD03IN4pWiZtj4grJN2qC+dzUJhP5y+xNyC95+1of8DZV8hK7RZKrybd
         Q4as6+WsWoXsX1YM0J4TkaCX1DNohy6kw2//t5HvlTGzwAy7uW7/CCDWSwY5haUFAm
         3c5StF0pNe9U1qtT4DHIsxtAqjjtdQ6LLnXGfK1LDoQvO5EVsdBKYeESE7VlHA4f53
         r0WARA4jeZG8sq13IGU3i9i+5MzzG/LIn7anncWcUlBJLfbZGyRHiN9VLH/gQHDDke
         +iBrr1N+fCv0q2nxdyDvAVko6OJLAXMONMfasJ4qQ21tgF0TxNrFxR8DVvAoJiWIcm
         0I0rQGzalcZXQ==
Date:   Fri, 15 Jan 2021 08:31:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     tglx@linutronix.de, ashok.raj@intel.com, kevin.tian@intel.com,
        dave.jiang@intel.com, megha.dey@intel.com, dwmw2@infradead.org,
        alex.williamson@redhat.com, bhelgaas@google.com,
        dan.j.williams@intel.com, will@kernel.org, joro@8bytes.org,
        dmaengine@vger.kernel.org, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, jgg@mellanox.com, kvm@vger.kernel.org,
        kwankhede@nvidia.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        maz@kernel.org, mona.hossain@intel.com, netanelg@mellanox.com,
        parav@mellanox.com, pbonzini@redhat.com, rafael@kernel.org,
        samuel.ortiz@intel.com, sanjay.k.kumar@intel.com,
        shahafs@mellanox.com, tony.luck@intel.com, vkoul@kernel.org,
        yan.y.zhao@linux.intel.com, yi.l.liu@intel.com
Subject: Re: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
Message-ID: <20210115063108.GI944463@unreal>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-2-baolu.lu@linux.intel.com>
 <20210114132627.GA944463@unreal>
 <b0c8b260-8e23-a5bd-d2da-ca1d67cdfa8a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c8b260-8e23-a5bd-d2da-ca1d67cdfa8a@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 15, 2021 at 07:49:47AM +0800, Lu Baolu wrote:
> Hi Leon,
>
> On 1/14/21 9:26 PM, Leon Romanovsky wrote:
> > On Thu, Jan 14, 2021 at 09:30:02AM +0800, Lu Baolu wrote:
> > > Some vendor IOMMU drivers are able to declare that it is running in a VM
> > > context. This is very valuable for the features that only want to be
> > > supported on bare metal. Add a capability bit so that it could be used.
> >
> > And how is it used? Who and how will set it?
>
> Use the existing iommu_capable(). I should add more descriptions about
> who and how to use it.

I want to see the code that sets this capability.

Thanks
