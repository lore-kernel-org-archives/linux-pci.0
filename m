Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBFC43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 21:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65503208E3
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 21:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfACVxc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:53:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:39713 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfACVxc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 16:53:32 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 13:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="105331087"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2019 13:53:31 -0800
Date:   Thu, 3 Jan 2019 14:51:50 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] pci/irq: Handle vector reduce and retry
Message-ID: <20190103215149.GA10822@localhost.localdomain>
References: <20190103210954.11129-1-keith.busch@intel.com>
 <20190103210954.11129-3-keith.busch@intel.com>
 <20190103213900.GB168876@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103213900.GB168876@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 03, 2019 at 03:39:01PM -0600, Bjorn Helgaas wrote:
> Hi Keith,
> 
> Thanks a lot for jumping on this.
> 
> I know I'm a broken record.  Please run "git log --oneline
> drivers/pci/msi.c" and make your subject match.

Sure thing, my mistake.
 
> On Thu, Jan 03, 2019 at 02:09:53PM -0700, Keith Busch wrote:
> Can you also add some explanation to Documentation/PCI/MSI-HOWTO.txt
> about the concept of "sets" and how to use
> nr_sets/sets/recalc_sets/priv?

Yes, will do. Do you prefer documentation in a separate patch or the same
one?

> > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > index c672f34235e7..326c9bd05f62 100644
> > --- a/include/linux/interrupt.h
> > +++ b/include/linux/interrupt.h
> > @@ -249,12 +249,16 @@ struct irq_affinity_notify {
> >   *			the MSI(-X) vector space
> >   * @nr_sets:		Length of passed in *sets array
> >   * @sets:		Number of affinitized sets
> > + * @recalc_sets:	Recalculate sets original requested allocation failed
> 
> This sentence is missing something and doesn't parse quite right.
> "if"?  Is "original" superfluous?

Yikes, that was a very poor merge of two different thought streams. I'll
fix that up.
