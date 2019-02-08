Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A15EC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45A2177B
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549634722;
	bh=DsU+0hlCk7sbsBOJm1lgVHUBCpUoH/G+M2w3qlCNprM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=01qtaKriwJzJZRVYe3G7fGTcY1rPb1YsuDEDJI60F2Rgj2KjlK2Ppe64hkbsyvO/U
	 XDWk5CgcvogBXENJ+awMAx9O7Bvkwlk3AIIiyDbklWSS8ryP0HWN66KgEy86KovrNn
	 KKaeciN82fxweq4gXKC9opAMmzB59kg4QYEwipYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfBHOFV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfBHOFV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 09:05:21 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D32020857;
        Fri,  8 Feb 2019 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549634720;
        bh=DsU+0hlCk7sbsBOJm1lgVHUBCpUoH/G+M2w3qlCNprM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yc86h83Xw4f4Ghd3Af2SfEhnV2zh5oxPFkiL8SccQf4tG/rEmrrlqc0cvITOxMTgF
         IouXvYzSbA50AR5lSlYkLYGljrnWlcs5rDNeIuHervafjrwpGtOPv7KeHztuli93Qe
         z1x2XMo6/rRdiHSJZXEsAuZVgbfCyw+DkJYG5JMQ=
Date:   Fri, 8 Feb 2019 08:05:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific
 dw_pcie_host_ops
Message-ID: <20190208140517.GT7268@google.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-9-kishon@ti.com>
 <20190207212622.GO7268@google.com>
 <2b839b2f-d792-069b-b45f-4a455335f016@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b839b2f-d792-069b-b45f-4a455335f016@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 08, 2019 at 10:43:40AM +0530, Kishon Vijay Abraham I wrote:
> > I don't see the whole series on linux-pci (I only see patches 2, 6, 8, 9),
> 
> I do see all the patches here
> https://patchwork.kernel.org/project/linux-pci/list/. Maybe it arrived little late?

For some reason Gmail decided many of your recent messages were spam.
Sorry for the noise.

> > but I expected to somewhere see the removal of assignments to these
> > pointers.  It would be easier to review if the removal of assignments and
> > the removal of the function pointers from the structure were in the same
> > patch, but maybe that's not really feasible.
> 
> The removal of the assignments are in 7th patch of the series (PCI: keystone:
> Use Keystone specific msi_irq_chip). It's feasible but just wanted to keep the
> keystone changes and DesignWare changes in separate patches.

OK, makes sense.

Bjorn
