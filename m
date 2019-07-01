Return-Path: <SRS0=J5oN=U6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F61EC0650F
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jul 2019 08:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7357E208E4
	for <linux-pci@archiver.kernel.org>; Mon,  1 Jul 2019 08:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfGAIZU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:25:20 -0400
Received: from verein.lst.de ([213.95.11.211]:59464 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfGAIZU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 04:25:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE0A068B20; Mon,  1 Jul 2019 10:25:17 +0200 (CEST)
Date:   Mon, 1 Jul 2019 10:25:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dev_pagemap related cleanups v4
Message-ID: <20190701082517.GA22461@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

And I've demonstrated that I can't send patch series..  While this
has all the right patches, it also has the extra patches already
in the hmm tree, and four extra patches I wanted to send once
this series is merged.  I'll give up for now, please use the git
url for anything serious, as it contains the right thing.
