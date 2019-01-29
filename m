Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D055C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39AF20989
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548791170;
	bh=n979B516WvO1WMnU9UTm77UKXWyQQ/SZXEgeapMTWYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iyvI4/rC1C+yiswVa04xAQA14IPqShfK6WYbgcGSOMEjiaHPJtiReFxxZpGy25hAd
	 SNhD+8lx62xNP1DEFFxrEjVn51irjAY69YBr4EoHOG2AeZJlU9C0a97LkPFkguavOn
	 Ub87/xC0245a/ywVbbSl5I4cfoVHsq9OaSu29Sl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfA2TqJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfA2TqJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 14:46:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308A320882;
        Tue, 29 Jan 2019 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548791168;
        bh=n979B516WvO1WMnU9UTm77UKXWyQQ/SZXEgeapMTWYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vSEbdOMdxB5zWHviLP5pUWw/pnkTofE5nbC3y6u6wmVIIjKd0uVrkqkM46iS+Zz3/
         /oCcoZpH9rhZa64+PdpUEKsaAK3nyCg9x7phTjMPalaJVViQJOMrOZrwStIWdN6Tg/
         hbaBioLq5FUwGZAnQ27o4GMt5X6OG52soxoLUyLg=
Date:   Tue, 29 Jan 2019 20:46:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 2/5] drivers/base: add a function to test peer to
 peer capability
Message-ID: <20190129194605.GC32069@kroah.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-3-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129174728.6430-3-jglisse@redhat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 12:47:25PM -0500, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> device_test_p2p() return true if two devices can peer to peer to
> each other. We add a generic function as different inter-connect
> can support peer to peer and we want to genericaly test this no
> matter what the inter-connect might be. However this version only
> support PCIE for now.

There is no defintion of "peer to peer" in the driver/device model, so
why should this be in the driver core at all?

Especially as you only do this for PCI, why not just keep it in the PCI
layer, that way you _know_ you are dealing with the right pointer types
and there is no need to mess around with the driver core at all.

thanks,

greg k-h
