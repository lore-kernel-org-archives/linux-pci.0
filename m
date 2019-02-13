Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3510C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7390C2175B
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550079373;
	bh=+64rGtgcnjS6VZmsqUi02650DnjbpxORkN/EdH3Ch20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gINuvM+3gt9VCrbK7G8HVR77wW1zwOZlZLImf8uOerd2Zx/pr14AppVb6YdzQkkcZ
	 mpNjlnaaibj6oScvld13Z+cLr/k0LbdbUuJkUtQ1Ump7XWC0ZlG0QHLHpnE+LVrtKd
	 KQm0ilmNVE8wqdL3f1jMqAQtYKYcTw5G4QgroQ3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390543AbfBMRgM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:36:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732687AbfBMRgM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 12:36:12 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B7B2086C;
        Wed, 13 Feb 2019 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550079372;
        bh=+64rGtgcnjS6VZmsqUi02650DnjbpxORkN/EdH3Ch20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrWOIxOQJI/TamTSj0vJ40fMNDjBeHOxJDCXhCEtURAYP+pDU8DlZ4qJYMt6JSm9/
         0Yphv1x+/c+g0W09jwRtcmRWzL2vP6io+rA4CnrcQR9YsDD9OjcJNoUHSAhifVvZUu
         yW0Cx1JqZS1tPweWtFYzBC2j/Od1p+6VUU0yFtcU=
Date:   Wed, 13 Feb 2019 11:36:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI/ACPI: Improve _OSC control request granularity
Message-ID: <20190213173610.GG96272@google.com>
References: <1539642186-12821-1-git-send-email-asierra@xes-inc.com>
 <1540483292-24049-1-git-send-email-asierra@xes-inc.com>
 <1540483292-24049-3-git-send-email-asierra@xes-inc.com>
 <20190130225752.GL229773@google.com>
 <1855383852.134524.1550079067380.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1855383852.134524.1550079067380.JavaMail.zimbra@xes-inc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 13, 2019 at 11:31:07AM -0600, Aaron Sierra wrote:
> ----- Original Message -----
> > From: "Bjorn Helgaas" <helgaas@kernel.org>
> > To: "Aaron Sierra" <asierra@xes-inc.com>
> > Sent: Wednesday, January 30, 2019 4:57:53 PM
> > Subject: Re: [PATCH v2 2/2] PCI/ACPI: Improve _OSC control request granularity
> 
> > On Thu, Oct 25, 2018 at 11:01:32AM -0500, Aaron Sierra wrote:

> > Then the calls would look like:
> > 
> >  control |= __osc_set_pciehp_control(root, support);
> >  control |= __osc_set_shpchp_control(root, support);
> >  ...
> 
> Yes, I do like that better. I had a draft with that structure, but I changed
> for some reason. FYI, I'm inclined to rename these bit-setting functions to
> "osc_get_X_control_bits()" to try to avoid confusion. Hopefully that sits well
> with you.

Sounds good!

Bjorn
