Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960ACC07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 13:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502CB20849
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544536589;
	bh=mJqxL9nZ+fu6JayXta2fjAfTfIkryhYx1ithZ/auKbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1zsViWnhhJ/l878CY4ZxniAI4zfRNBcEo5ivoxZ4fGBgqMKVU82f9HEOYMRVBqBj3
	 dZTcPgI+mGnhMmI6ovzAFKuIyC4iCiWE10wYS/earDnnO7MhVtlZPJR/mawFWaG+Ti
	 Fg8KxxGJdgTo9Sn4jF2uRk7j1aezWKJ6UW/487+g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502CB20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeLKN42 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLKN42 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 08:56:28 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883FD2082F;
        Tue, 11 Dec 2018 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544536587;
        bh=mJqxL9nZ+fu6JayXta2fjAfTfIkryhYx1ithZ/auKbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1tpdpM9qd8GW5cAjdhQ7gPdWbHUy4dzEW27qrFfbbQPsBgPMoYv4G6vb/TgagIcMY
         v3cwbRGEi8IWZMK5QaUcvbG+ibBBDkGDTmEMY2ih4j+E+exn0GA3/vtciYIOkLLh1K
         VuobXpxBu5A0RCu+Ixt/o4WDTwmnsSP0jxKcONUo=
Date:   Tue, 11 Dec 2018 07:56:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] PCI/P2PDMA: Match interface changes to
 devm_memremap_pages()
Message-ID: <20181211135626.GC99796@google.com>
References: <20181130225911.2900-1-logang@deltatee.com>
 <20181206204643.GC247703@google.com>
 <c226426d-e88c-da18-f643-f3faaf1c0dbd@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c226426d-e88c-da18-f643-f3faaf1c0dbd@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 06, 2018 at 03:17:00PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-12-06 1:46 p.m., Bjorn Helgaas wrote:
> > On Fri, Nov 30, 2018 at 03:59:11PM -0700, Logan Gunthorpe wrote:
> >> "mm-hmm-mark-hmm_devmem_add-add_resource-export_symbol_gpl.patch" in the
> >> mm tree breaks p2pdma. The patch was written and reviewed before p2pdma
> >> was merged so the necessary changes were not done to the call site in
> >> that code.
> >>
> >> Without this patch, all drivers will fail to register P2P resources
> >> because devm_memremap_pages() will return -EINVAL due to the 'kill'
> >> member of the pagemap structure not yet being set.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Applied with Dan's reviewed-by to pci/peer-to-peer for v4.21, thanks!
> > 
> > If the mm patch you mention gets merged for v4.20, let me know and I can
> > promote this to for-linus so v4.20 doesn't end up broken.
> 
> Thanks Bjorn, but I think Andrew has also picked it up in the mm tree
> with the patch in question. My hope is that he squashes the two but I'm
> not sure what his intentions are. I mostly copied you for  information
> purposes as this patch shouldn't even compile without Dan's patch.
> 
> Though, I guess we'll find out what goes in after the merge window --
> you may not need to do anything.

OK, I dropped this because I don't have the matching mm patch.  I agree,
it should be squashed so we avoid a bisection hole.  Let me know if I
need to do anything else with this.

Bjorn
