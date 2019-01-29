Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DCEC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E694520989
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548791075;
	bh=viEJwDEtg1GHjzjkuyc+bBKWHo390MegK+/fo4Fble8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sOXnJASyCZbuQF0jg1LU8S4JhNJ7rlq/Nr6crYN41xCqSgbsHGunzh3FvJtUa8cGQ
	 PNYtFT6IbIltF/o+5rWBLdaysnAzzfpLiw4ZHyAIUPlf/8d6BQoCTBiHy6QXPbuZAD
	 mOEVNQai9V0OVDhmkzGlv1j2zGL25T2moKpZ/zC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfA2To3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfA2To3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 14:44:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1840F20882;
        Tue, 29 Jan 2019 19:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548791068;
        bh=viEJwDEtg1GHjzjkuyc+bBKWHo390MegK+/fo4Fble8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZ49LH+jLUB5srps9pOXePp/VyVK991R5wyjKZybFUFX8MoQbeRfWiIJ2VIgtJ0ON
         BIFTzisFgCYTDNpFD+PiiDclPm8bLV+kxGugwnruf/jhxkgGGOSQHLA6pLyhwHnCkM
         j3wL4ZpMUUn9yw+WfZbhWycVuoC0YG+hjkARojvo=
Date:   Tue, 29 Jan 2019 20:44:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     jglisse@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Subject: Re: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer
 capability
Message-ID: <20190129194426.GB32069@kroah.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-2-jglisse@redhat.com>
 <f66ba584-9c4a-f6cd-c647-9b32a93be807@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66ba584-9c4a-f6cd-c647-9b32a93be807@deltatee.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 11:24:09AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:
> > +bool pci_test_p2p(struct device *devA, struct device *devB)
> > +{
> > +	struct pci_dev *pciA, *pciB;
> > +	bool ret;
> > +	int tmp;
> > +
> > +	/*
> > +	 * For now we only support PCIE peer to peer but other inter-connect
> > +	 * can be added.
> > +	 */
> > +	pciA = find_parent_pci_dev(devA);
> > +	pciB = find_parent_pci_dev(devB);
> > +	if (pciA == NULL || pciB == NULL) {
> > +		ret = false;
> > +		goto out;
> > +	}
> > +
> > +	tmp = upstream_bridge_distance(pciA, pciB, NULL);
> > +	ret = tmp < 0 ? false : true;
> > +
> > +out:
> > +	pci_dev_put(pciB);
> > +	pci_dev_put(pciA);
> > +	return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_test_p2p);
> 
> This function only ever returns false....

I guess it was nevr actually tested :(

I feel really worried about passing random 'struct device' pointers into
the PCI layer.  Are we _sure_ it can handle this properly?

thanks,

greg k-h
