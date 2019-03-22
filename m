Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C2C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACF121900
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553273271;
	bh=+WR5/YkORYFKXnsrL4Kq4xe+UkSaYNt9o/GK851Cwdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KUP8624EC5lHwMuGY7c6GfqF5/NlS+szWj6m2hz7g1CDZRHvmEo6A1JxOcfpigIGi
	 dOYHnap8R8SiWFRFw3MYxHkE49tiJH9waZ8Ks5AAMRoYD4Dzqh7KtHmuAFN2qSEbby
	 j5SE8ZWkHjIIAw2fDCeaRYWyHnZoy/PsH23NSmao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCVQrq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCVQrq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 12:47:46 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E9621900;
        Fri, 22 Mar 2019 16:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553273265;
        bh=+WR5/YkORYFKXnsrL4Kq4xe+UkSaYNt9o/GK851Cwdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cN7cxwyrt4aXb+RwQl8Xo4qso2c8wK5bSKmQiiym/GXp+MdEPUr6QRhgRkD4he4wU
         NZ0slkZCa2VyxBwE7V6d9dXRCNdFwmwvGAIH50fB27eNt3dSlthuDXZSkd24FXXMcg
         UzdDEDYUQOCdjeaI34qJ5BdB83CySX5CvjcHoRHI=
Date:   Fri, 22 Mar 2019 11:47:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>
Subject: Re: [PATCH v3 09/10] NTB: Add MSI interrupt support to ntb_transport
Message-ID: <20190322164743.GN251185@google.com>
References: <20190322000645.15580-1-logang@deltatee.com>
 <20190322000645.15580-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322000645.15580-10-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Logan,

Drive-by nits:

On Thu, Mar 21, 2019 at 06:06:44PM -0600, Logan Gunthorpe wrote:
> Introduce the module parameter 'use_msi' which, when set uses

s/set/set,/

> MSI interrupts instead of doorbells for each queue pair (QP). T
> he parameter is only available if NTB MSI support is configured into

Spurious newline in the middle of "The".

> the kernel. We also require there to be more than one memory window
> (MW) so that an extra one is available to forward the APIC region.
> 
> To use MSIs, we request one interrupt per QP and forward the MSI address
> and data to the peer using scratch pad registers (SPADS) above the MW
> spads. (If there are not enough SPADS the MSI interrupt will not be used.)

/spads/SPADS/ for consistency

> Once registered, we simply use ntb_msi_peer_trigger and the recieving

s/recieving/receiving/

> ISR simply queues up the rxc_db_work for the queue.
> 
> This addition can significantly improve performance of ntb_transport.
> In a simple, untuned, apples-to-apples comparision using ntb_netdev
> and iperf with switchtec hardware, I see 3.88Gb/s without MSI
> interrupts and 14.1Gb/s which is a more than 3x improvement.

s/which is/with MSI, which is/

Bjorn
