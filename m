Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0C5C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588D020989
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 19:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfA2TxH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:53:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfA2TxH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 14:53:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF0B97AE8B;
        Tue, 29 Jan 2019 19:53:06 +0000 (UTC)
Received: from redhat.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E322419745;
        Tue, 29 Jan 2019 19:53:04 +0000 (UTC)
Date:   Tue, 29 Jan 2019 14:53:02 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
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
Message-ID: <20190129195302.GI3176@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-2-jglisse@redhat.com>
 <f66ba584-9c4a-f6cd-c647-9b32a93be807@deltatee.com>
 <20190129194426.GB32069@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129194426.GB32069@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 Jan 2019 19:53:07 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 08:44:26PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 29, 2019 at 11:24:09AM -0700, Logan Gunthorpe wrote:
> > 
> > 
> > On 2019-01-29 10:47 a.m., jglisse@redhat.com wrote:
> > > +bool pci_test_p2p(struct device *devA, struct device *devB)
> > > +{
> > > +	struct pci_dev *pciA, *pciB;
> > > +	bool ret;
> > > +	int tmp;
> > > +
> > > +	/*
> > > +	 * For now we only support PCIE peer to peer but other inter-connect
> > > +	 * can be added.
> > > +	 */
> > > +	pciA = find_parent_pci_dev(devA);
> > > +	pciB = find_parent_pci_dev(devB);
> > > +	if (pciA == NULL || pciB == NULL) {
> > > +		ret = false;
> > > +		goto out;
> > > +	}
> > > +
> > > +	tmp = upstream_bridge_distance(pciA, pciB, NULL);
> > > +	ret = tmp < 0 ? false : true;
> > > +
> > > +out:
> > > +	pci_dev_put(pciB);
> > > +	pci_dev_put(pciA);
> > > +	return false;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_test_p2p);
> > 
> > This function only ever returns false....
> 
> I guess it was nevr actually tested :(
> 
> I feel really worried about passing random 'struct device' pointers into
> the PCI layer.  Are we _sure_ it can handle this properly?
> 

Oh yes i fixed it on the test rig and forgot to patch
my local git tree. My bad.

Cheers,
Jérôme
