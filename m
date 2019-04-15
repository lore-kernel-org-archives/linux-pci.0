Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC9C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 21:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BC220880
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555364819;
	bh=IGw1mbFnYhYy2WDWvJg9H3w1ImIzzQbL243JVjHxxtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y+0IP4wMJstBd7djL+SfqCpeM02Of+2RHJhd/eHR91TClZ4BSE6zWINaBzE80v+Ag
	 OL8UG3mofNx/dpczzzHxFdW0KqpN4OcHYatP0C2LTfAd5B5sgDdP9jdr7IAQfxYEwH
	 /v220WlEVrcMQBPQ/ZjsiJSdW6BDgf9fZWet6nXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfDOVq6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfDOVq6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 17:46:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23945206B6;
        Mon, 15 Apr 2019 21:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555364816;
        bh=IGw1mbFnYhYy2WDWvJg9H3w1ImIzzQbL243JVjHxxtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Toibrz5t0G4Wfvv/mt5FTtCGsg0kqwrePbUgjmQcs66odVm9jNE7qWCufviX8RUZP
         k352ExSJOTLhK6Pr7GA9E+AkQ4asMsYs7FJC2AfMAj/6XEtJEXj6unHdMGsnHvAeN9
         BnefWeAcPBxCL07R+xiZynX4TdN58oU9LowQvZW8=
Date:   Mon, 15 Apr 2019 16:46:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Arumugam, Kamenee" <kamenee.arumugam@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error
 non-fatal
Message-ID: <20190415214651.GM126710@google.com>
References: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
 <20190410123455.26818.49424.stgit@scvm10.sc.intel.com>
 <20190410192948.GG256045@google.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6A1B14@FMSMSX108.amr.corp.intel.com>
 <A503C24F5B2FB844864C0DD400A8F742121C8525@ORSMSX108.amr.corp.intel.com>
 <20190411182938.GB14495@ziepe.ca>
 <A503C24F5B2FB844864C0DD400A8F742121C859F@ORSMSX108.amr.corp.intel.com>
 <20190412135544.GB3765@ziepe.ca>
 <ef74c759-a5ac-c497-0e82-345ddf3c9255@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef74c759-a5ac-c497-0e82-345ddf3c9255@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 02:47:01PM -0400, Dennis Dalessandro wrote:
> On 4/12/2019 9:55 AM, Jason Gunthorpe wrote:
> > On Thu, Apr 11, 2019 at 08:37:53PM +0000, Arumugam, Kamenee wrote:
> > > On Thu, Apr 11, 2019 at 06:22:45PM +0000, Arumugam, Kamenee wrote:
> > > 
> > > > This is a device bug then.
> > > 
> > > > A RDMA device must accept and respond to all TLPs that the CPU
> > > > could create for the user accessible BAR pages.
> > > 
> > > > A user process must not be able to crash the CPU or make the
> > > > device malfunction by accessing the exposed BAR page. This
> > > > includes a broad range of topics, like mis-aligned acceses,
> > > > SSE instructions, atomics, >etc.
> > > 
> > > > Is blocking AER even enough here? If the device isn't
> > > > generating a reasonable reply I have a bad feeling worse will
> > > > happen.
> > > 
> > > After blocking unsupported request error, we don't see any other
> > > issue including no system hang.
> > 
> > Are you specifically testing all the special TLPs the CPU can
> > produce?
> 
> All the special TLPs should have been tested. This however seems to
> be a missed test case. Not that surprising though given differences
> in BIOS and things of that nature that something falls through the
> cracks and is extra hard to find.

Is there a published erratum for this?  I don't have warm fuzzies yet
that we actually know the root cause here.

Kamenee said the problem case was:

  user-level application is making spurious read accesses (invalid
  width access) to this memory mapping causing the device to report an
  unsupported request error through AER.

So I guess that means the application performed a read and got invalid
data back?  I think the Root Complex had to supply *some* data to
complete the CPU's read, and since the HFI responded with UR instead
of data, the RC probably fabricated something.  Many RCs fabricate ~0,
but I don't think that's actually required by the spec, so I'm
doubtful that the application can reliably detect this.

I'd be really surprised that something as obvious as an invalid width
wasn't tested, especially if this is intended for direct mapping into
user applications.

Bjorn
