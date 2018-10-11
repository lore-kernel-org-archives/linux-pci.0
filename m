Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB44C32788
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FB220659
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FB220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJKXad (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeJKXad (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 19:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DCE83083395;
        Thu, 11 Oct 2018 16:02:43 +0000 (UTC)
Received: from w520.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08B2685732;
        Thu, 11 Oct 2018 16:02:41 +0000 (UTC)
Date:   Thu, 11 Oct 2018 10:02:41 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH v5 08/11] PCI: Unify pci_reset_function_locked() and
 __pci_reset_function_locked()
Message-ID: <20181011100241.42c10935@w520.home>
In-Reply-To: <20181011045008.32212-8-okaya@kernel.org>
References: <20181011045008.32212-1-okaya@kernel.org>
        <20181011045008.32212-8-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 11 Oct 2018 16:02:43 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 11 Oct 2018 04:50:00 +0000
Sinan Kaya <okaya@kernel.org> wrote:

> The difference between pci_reset_function_locked() and
> __pci_reset_function_locked() is the saving and restoring of the registers.
> Unify these API by adding saverestore argument that caller passes.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c               |  2 +-
>  drivers/net/ethernet/cavium/liquidio/lio_main.c |  2 +-
>  drivers/pci/pci.c                               | 10 +++++++---
>  drivers/pci/pci.h                               |  1 +
>  drivers/xen/xen-pciback/pci_stub.c              |  6 +++---
>  include/linux/pci.h                             |  4 ++--
>  6 files changed, 15 insertions(+), 10 deletions(-)

TBH, I'm not a fan of this patch or the remainder in this series.
Having a function prefixed with underscored or specifically indicate
locked tells callers that these are special cases and should be
understood before using.  Adding bool parameters to the common
functions ensures that every caller now needs to understand those
special cases and potentially get them wrong.  Also, a string of random
bool options to a function means that any time we want to use it we
need to go reexamine the function definition.  It's not intuitive to
use or review.  Thanks,

Alex
