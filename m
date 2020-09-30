Return-Path: <SRS0=vfl7=DH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76BAC4727C
	for <linux-pci@archiver.kernel.org>; Wed, 30 Sep 2020 21:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0620C09
	for <linux-pci@archiver.kernel.org>; Wed, 30 Sep 2020 21:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbdT9jxE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6eueQl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgI3VsX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgI3VsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:48:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0BFC061755;
        Wed, 30 Sep 2020 14:48:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601502501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HA1EzwpUAaIZW7GFNCoiipYPA+gUwpVCjqiYX7ESWP8=;
        b=DbdT9jxEcu3rFmw1zRPzTG1hXOVtBi4tr6eT3S+cxufmUYpj86bNPyAq/DZ7AD1+SMT0df
        KgWBOPf/AOHisoOyizUhuNQOCu0/6hOf336PNYmAVdbKyUO/52tlwOcMKLA+pXqfxclP/J
        CjhQyw9D+wVHY7V0GBab951+8FII4G8dv9ZS9bvkSkFDvSIWE/D7qrYlK3FWBZDfVP6qLv
        KVW8UopbFJTIJeX4U8RYGs4UUiIRTErQ5antzL3ino9g7bYNZr2YtiyIyfIhm3gZZa9ReZ
        uX1QqjRy7/XWs3oZIF55A/LEA8qg1YZ1PXu/85NSQY0UiRmZ9U+vGV6d0HzL7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601502501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HA1EzwpUAaIZW7GFNCoiipYPA+gUwpVCjqiYX7ESWP8=;
        b=p6eueQl6DbtcMo1U3rKbnlP+9MzBbDhkvaRHju+9jz/ZhIoLmLEfLBIlxvUtB/O+R4JjK1
        q5A7i2g6oRhn9wAg==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, vkoul@kernel.org,
        megha.dey@intel.com, maz@kernel.org, bhelgaas@google.com,
        alex.williamson@redhat.com, jacob.jun.pan@intel.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, baolu.lu@intel.com,
        kevin.tian@intel.com, sanjay.k.kumar@intel.com,
        tony.luck@intel.com, jing.lin@intel.com, dan.j.williams@intel.com,
        kwankhede@nvidia.com, eric.auger@redhat.com, parav@mellanox.com,
        rafael@kernel.org, netanelg@mellanox.com, shahafs@mellanox.com,
        yan.y.zhao@linux.intel.com, pbonzini@redhat.com,
        samuel.ortiz@intel.com, mona.hossain@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 05/18] dmaengine: idxd: add IMS support in base driver
In-Reply-To: <20200930185103.GT816047@nvidia.com>
References: <160021207013.67751.8220471499908137671.stgit@djiang5-desk3.ch.intel.com> <160021248979.67751.3799965857372703876.stgit@djiang5-desk3.ch.intel.com> <87sgazgl0b.fsf@nanos.tec.linutronix.de> <20200930185103.GT816047@nvidia.com>
Date:   Wed, 30 Sep 2020 23:48:20 +0200
Message-ID: <87ft6zgcm3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30 2020 at 15:51, Jason Gunthorpe wrote:

> On Wed, Sep 30, 2020 at 08:47:00PM +0200, Thomas Gleixner wrote:
>
>> > +	pci_read_config_dword(pdev, SIOVCAP(dvsec), &val32);
>> > +	if ((val32 & 0x1) && idxd->hw.gen_cap.max_ims_mult) {
>> > +		idxd->ims_size = idxd->hw.gen_cap.max_ims_mult * 256ULL;
>> > +		dev_dbg(dev, "IMS size: %u\n", idxd->ims_size);
>> > +		set_bit(IDXD_FLAG_SIOV_SUPPORTED, &idxd->flags);
>> > +		dev_dbg(&pdev->dev, "IMS supported for device\n");
>> > +		return;
>> > +	}
>> > +
>> > +	dev_dbg(&pdev->dev, "SIOV unsupported for device\n");
>> 
>> It's really hard to find the code inside all of this dev_dbg()
>> noise. But why is this capability check done in this driver? Is this
>> capability stuff really IDXD specific or is the next device which
>> supports this going to copy and pasta the above?
>
> It is the weirdest thing, IMHO. Intel defined a dvsec cap in their
> SIOV cookbook, but as far as I can see it serves no purpose at
> all.

Why am I not surprised?

> Last time I asked I got some unclear mumbling about "OEMs".

See above.

But it reads the IMS storage array size out of this capability, so it
looks like it has some value.

> I expect you'll see all Intel drivers copying this code.

Just to set the expectations straight:

   1) Has this capability stuff any value aside of being mentioned in
      the SIOV cookbook?

   2) If it has no value, then just remove the mess

   3) If it has value then this wants to go to the PCI core and fill in
      some SIOV specific data structure when PCI evaluates the
      capabilities. Or at least have a generic function which can be
      called by the magic SIOV capable drivers.

Thanks,

        tglx


