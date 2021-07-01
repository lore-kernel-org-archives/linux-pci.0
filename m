Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C3C11F64
	for <linux-pci@archiver.kernel.org>; Thu,  1 Jul 2021 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009C26140B
	for <linux-pci@archiver.kernel.org>; Thu,  1 Jul 2021 14:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhGAO1t (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:27:49 -0400
Received: from verein.lst.de ([213.95.11.211]:47780 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhGAO1s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 10:27:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4572267357; Thu,  1 Jul 2021 16:25:13 +0200 (CEST)
Date:   Thu, 1 Jul 2021 16:25:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: finish RCU conversion of pdev->p2pdma
Message-ID: <20210701142512.GA23105@lst.de>
References: <20210701095621.3129283-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701095621.3129283-1-eric.dumazet@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
