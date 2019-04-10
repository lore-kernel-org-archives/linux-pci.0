Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE4C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 22:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3337F2082A
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 22:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554933971;
	bh=jcZFV41+J0l5CJg5QLNtSM+VmfZUJbKXlyd5pb9wVOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a1FflU7uyqvHFz4+K/dy9DOiFct6ya2iGMixNMg0/6/Lcc0iIlSRfQ5IkuC06MIbR
	 AId4uV8zhqRU1BwOxvy0vZi/RJwnOlYuTFoicCy21W0/JtWWUTHbUQyb86R9Njb19+
	 rA63h+CLtZtmfKDmXAJTu4NnFCBGWlPGaX9cZw5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfDJWGG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfDJWGG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 18:06:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B07B2082A;
        Wed, 10 Apr 2019 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554933965;
        bh=jcZFV41+J0l5CJg5QLNtSM+VmfZUJbKXlyd5pb9wVOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4e6hH71BVlhzRcH0Qkvg1dpeZ5BlDPECmiMr4LVUIlvMJgU7I2uM1T+4Vm+OIJH9
         qHjg6tbmP5qn7b/xUdyEv0IECQlryHfa44fZmMTXJaSygAnO9GXIAdYJsOVcLZZcOj
         uQs5JerF0sOpmtjj1V1wTnI/ZtCmzCJvNVkQSlS0=
Date:   Wed, 10 Apr 2019 17:06:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v2 2/4] PCI: Cleanup comments in setup-bus.c to meet
 kernel coding style guidelines
Message-ID: <20190410220603.GL256045@google.com>
References: <20190311162154.3852-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB06428C4318A200E85C590BBC80480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB06428C4318A200E85C590BBC80480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicholas,

On Mon, Mar 11, 2019 at 04:23:23PM +0000, Nicholas Johnson wrote:
> Change block comments to accepted style with asterisks on each line.
> 
> Justify block comments to 80-character limit to reduce the number of
> lines where possible.

Thanks for doing this; I do accept cleanup patches like this.  It does
simplify things if they are last in a series because that makes it
less likely that the "real" patches will cause conflicts.

Don't repost this series just to fix that; I fixed the (trivial)
conflict by hand already.  Just FYI for the future :)

Bjorn
