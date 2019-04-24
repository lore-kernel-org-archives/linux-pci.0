Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F5C282E1
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 18:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD80321773
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128903;
	bh=wNXcIqY1MVKVHuCsEnUMmWVAN5ICJzgIMqeNjNsFLvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jcvj2yCHGFNF/QRrV8qUPxQ4tswOuhvpsa2VGEqhpHA+uE3v6v/bTRsiAr+sJ1YYE
	 rfTg20rwcRSYuvfVeN9AGBtlcQrS1qdhvmRydqlqSQHmP45VOkQeOFmjq09Ejqg+WC
	 V8ua/Wj6cF3qTlC1Zux7ZRV9pTymQ7K6CABFySfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbfDXRV6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbfDXRV4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 13:21:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCD021907;
        Wed, 24 Apr 2019 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126515;
        bh=wNXcIqY1MVKVHuCsEnUMmWVAN5ICJzgIMqeNjNsFLvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0kfEoHpCLZuXfPbDjh9BVDkHxMUpnaJaiglX/lrRv9Y4BfLEUiUqEkUerjEOH6G7q
         zqv62ll+pEyTjBxqjSLozW+uMtS+LFkJub4ASphzhjWrsh9kNWTEaKm09H7/xfJM17
         h+1V+QcggPYZSq4RC/dvv+DG8VB2Q5cxQe7rqIIg=
Date:   Wed, 24 Apr 2019 12:21:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Alexander Fomichev <fomichev.ru@gmail.com>,
        linux-pci@vger.kernel.org, linux@yadro.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH RESEND] PCI: disable runtime PM for PLX switches
Message-ID: <20190424172151.GB244134@google.com>
References: <20190415135903.wiyw34faiezdnbbs@yadro.com>
 <20190415141554.GL126710@google.com>
 <20190423215340.GH14616@google.com>
 <20190424100102.iyxogbsa4l7dyusb@yadro.com>
 <20190424141148.GA244134@google.com>
 <20190424145819.GL2654@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424145819.GL2654@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 05:58:19PM +0300, Mika Westerberg wrote:
> On Wed, Apr 24, 2019 at 09:11:48AM -0500, Bjorn Helgaas wrote:
> >   - Maybe the PCI sysfs accessors (pci_mmap_resource(), etc) should
> >     turn off runtime PM?  If we allow mmap of a BAR and then put the
> >     device in D3hot, that seems like a bug that could affect lots of
> >     things.  But maybe that's already done magically elsewhere?
> 
> IIRC there is no PM magic happening for MMIO userspace accesses.
> 
> What you suggest above sounds like a good way to fix it. We already do
> similar for config space access from userspace (if the device is in
> D3cold) so definitely makes sense to do the same for MMIO. However, I
> don't think we need to disable runtime PM - it should be enough to
> increase the reference count (pm_runtime_get_sync() and friends) during
> the time the MMIO resource is mmapped.

OK, so if I understand correctly this would be basically adding
pm_runtime_get_sync(dev) in pci_mmap_resource().  I don't know what
the unmap path is, but there would have to be a matching
pm_runtime_put() somewhere.

And a similar change in the read/write path for /sys/.../resource<N>;
I think this must be related to the sysfs_create_bin_file() call in
pci_create_attr(), but I don't see the path where the actual
read/write to the device is done.

And probably something similar should be done in pci_resource_io(),
pci_map_rom(), and pci_unmap_rom().

Bjorn
