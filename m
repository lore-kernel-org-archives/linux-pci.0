Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC62C00449
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D172145D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRjWmo9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D172145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeJBDU2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeJBDU2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 23:20:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90628208AE;
        Mon,  1 Oct 2018 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538426452;
        bh=DQgJAjwHTliGl6ri8SgmSvR0ckheZ5C5Pxzn7UoAmrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRjWmo9zOrjE28IjHcLwZTCauu9QexCKI/R3vSwa2AQMVJkbo7jL9uxnGgQSfAHK0
         OI3wPnk21a59sMyrmtkHTur2CesHKUPrOUQnhH9Rnmme8NCCrEiAuGFZQFYd1vpbmM
         7iWTTTvFftAHOgIfQNx+SCyKDAiDwzWQUb3QSdec=
Date:   Mon, 1 Oct 2018 15:40:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     lukas@wunner.de, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com
Subject: Re: [PATCH v4 1/6] mpt3sas: Introduce
 mpt3sas_base_pci_device_is_available
Message-ID: <20181001204051.GD142872@bhelgaas-glaptop.roam.corp.google.com>
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537935759-14754-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <20180926213241.GI28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927070327.wvl5glb4c7gtjoa3@wunner.de>
 <20180927184746.GM28024@bhelgaas-glaptop.roam.corp.google.com>
 <20180927190959.dio4qwti3i4accjm@wunner.de>
 <CA+RiK64EdoSngTzDMUP4xXNcZQa6KfyucsRw42+DUo3s+JPmVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+RiK64EdoSngTzDMUP4xXNcZQa6KfyucsRw42+DUo3s+JPmVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 01, 2018 at 12:27:28PM +0530, Suganath Prabu Subramani wrote:
> On Fri, Sep 28, 2018 at 12:40 AM Lukas Wunner <lukas@wunner.de> wrote:
> > On Thu, Sep 27, 2018 at 01:47:46PM -0500, Bjorn Helgaas wrote:

> > > I'm not sure how mpt3sas benefits from adding
> > > mpt3sas_base_pci_device_is_available() here, other than the fact that
> > > it avoids an MMIO read to the device in most cases.  I think it would
> > > be simpler and better to make mpt3sas_base_get_iocstate() smarter
> > > about handling ~0 values from the readl().
> >
> > Avoiding an MMIO read when it's known to run into a Completion Timeout
> > buys about 17 ms.  If the function is executed many times (I don't know
> > if that's the case here, I'm referring to the general case), or if bailing
> > out of it early avoids significant amounts of further I/O, then checking
> > for disconnectedness makes sense.

I agree that if we know the device is gone, it's helpful to avoid
further I/O to it.  The misleading pattern used in this patch is:

  R1) Check for device presence
  R2) Read from device
  R3) Consume data from device

That promotes the misconception that "the device is present, so we got
valid data from it."  But in fact the device may disappear between R1
and R2, so the following pattern is better:

  A) Read from device
  B) Check data for validity, e.g., look for ~0
  C) Consume data if valid

If we're writing to the device, we don't expect any response, and it
makes sense to do:

  W1) Check for device presence
  W2) If device present, write to device

Obviously the device can disappear between W1 and W2, so this can't
eliminate *all* writes to non-existent devices, but if we want to
reduce them and we're only doing writes to the device (with no reads),
this is the best we can do.

We can learn that the device is gone in several ways: pciehp might
notice the link is down, the driver might notice a ~0 return, etc.

The driver writer knows the structure of communication with the
device, so he/she should know the appropriate places to check for
valid data from reads and where to check to minimize the number of
writes to a non-existent device.

> This function is called only during controller reset, system shutdown
> and driver unload operations.
> For this case we can remove mpt3sas_base_pci_device_is_available() check,
> since we can make the device removal from readl in
> mpt3sas_base_get_iocstate() as you suggested.

> But we need mpt3sas_base_pci_device_is_available() in other places
> like while submitting the
> IO/TMs to the HBA firmware etc where driver is not checking for the
> IOC state (through readl() operation)
> to gracefully handle the HBA hot-unplug operation.

This is the W1/W2 case above, and what you can do is constrained by
the device model, i.e., where it requires reads from the device.  I
agree you may want to check whether the device is absent to minimize
writes after a device has been removed.

I think the names "pci_device_is_present()" and
"mpt3sas_base_pci_device_is_available()" contribute to the problem
because they make promises that can't be kept -- all we can say is
that the device *was* present, but we know whether it is *still*
present.  I think it would be better if the interfaces were something
like "pci_device_is_absent()" because that gives a result we can rely
on.  If that returns true, we know the device is definitely gone.

Bjorn
