Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60AFC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 05:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939E92084C
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 05:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCbCeWPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939E92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeKMO7C (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:59:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeKMO7B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 09:59:01 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F224920817;
        Tue, 13 Nov 2018 05:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542085361;
        bh=kfgSEg80hSw6L+6zKKxwF+SG2m0X6DrimMnxrBJP9K8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCbCeWPrUbMg2INXAk36+TLO0/VxfMj8lv9cwwnV1gIdVGuv/gRDeL9NwaVoctlI3
         mBmqZyTyBlh3jRxkSYWKlkPGhR4ofrEDekQKLN/iBVIbwbpfXXzMu257pGB6nxkJYq
         H+QGRvlSsb0yRISggPyOg9tGi3g2ZHRkLUsIE1O0=
Date:   Mon, 12 Nov 2018 23:02:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex_Gagniuc@Dellteam.com
Cc:     oohall@gmail.com, gregkh@linuxfoundation.org,
        keith.busch@intel.com, mr.nuke.me@gmail.com,
        linux-pci@vger.kernel.org, Austin.Bolen@dell.com,
        Shyam.Iyer@dell.com, linux-kernel@vger.kernel.org,
        jonathan.derrick@intel.com, lukas@wunner.de, ruscur@russell.cc,
        sbobroff@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181113050240.GA182139@google.com>
References: <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
 <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
 <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jon, for related VMD firmware-first error enable issue]

On Mon, Nov 12, 2018 at 08:05:41PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 11/11/2018 11:50 PM, Oliver O'Halloran wrote:
> > On Thu, 2018-11-08 at 23:06 +0000, Alex_Gagniuc@Dellteam.com wrote:

> >> But it's not the firmware that crashes. It's linux as a result of a
> >> fatal error message from the firmware. And we can't fix that because FFS
> >> handling requires that the system reboots [1].
> > 
> > Do we know the exact circumsances that result in firmware requesting a
> > reboot? If it happen on any PCIe error I don't see what we can do to
> > prevent that beyond masking UEs entirely (are we even allowed to do
> > that on FFS systems?).
> 
> Pull a drive out at an angle, push two drives in at the same time, pull 
> out a drive really slow. If an error is even reported to the OS depends 
> on PD state, and proprietary mechanisms and logic in the HW and FW. OS 
> is not supposed to mask errors (touch AER bits) on FFS.

PD?

Do you think Linux observes the rule about not touching AER bits on
FFS?  I'm not sure it does.  I'm not even sure what section of the
spec is relevant.

The whole issue of firmware-first, the mechanism by which firmware
gets control, the System Error enables in Root Port Root Control
registers, etc., is very murky to me.  Jon has a sort of similar issue
with VMD where he needs to leave System Errors enabled instead of
disabling them as we currently do.

Bjorn

[1] https://lore.kernel.org/linux-pci/20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com
