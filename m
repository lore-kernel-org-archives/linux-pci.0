Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB23C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 18:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749642087C
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555438529;
	bh=Oj9HxjX40cPbEgAsC3G0t2QRlyq856rzOsHMrs74fOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YaMk95L6Rsro1ctCR+5oaC0IW8wkQ8QePd2z2WkF6KTNNvIbKhRgwdBmxlQGovrvW
	 0kwg43jCTPC7aEyYVJe6NDBXgfeMWugI3z5Arwz3hdZL17jvFPGng+94EgAF+ROCbL
	 irjxSl3pooeH/0VNNNyyPcJWvI1iFI79r9MBBuDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfDPSP2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfDPSP2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Apr 2019 14:15:28 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC43B20868;
        Tue, 16 Apr 2019 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555438528;
        bh=Oj9HxjX40cPbEgAsC3G0t2QRlyq856rzOsHMrs74fOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vo/VlBgcddYzkezu+Wsk1rcnLlnw8xxamPqzTdwy/+2+9onXqj1ltvFz3QRtv1UHJ
         HnXaYLaxXoOS8ShL1kqINStLh+rk1cqbisWhnqPOY6RCPiAtsql5g1J99CnQWuiTcx
         FSwDDQCsjdIQ/QiSYuNLNB32wbjcqfCxvrurGIQE=
Date:   Tue, 16 Apr 2019 13:15:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aaron Sierra <asierra@xes-inc.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3] PCI/ACPI: Improve _OSC control request granularity
Message-ID: <20190416181525.GO126710@google.com>
References: <20190213213242.21920-1-asierra@xes-inc.com>
 <20190416175253.786-1-asierra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416175253.786-1-asierra@xes-inc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 16, 2019 at 12:52:53PM -0500, Aaron Sierra wrote:
> Bjorn,
> 
> Just checking if this is still on your radar. Has it been superseded or
> complicated by other work?

Still on my radar, sorry for the delay.  I use the patchwork instance at
https://patchwork.ozlabs.org/project/linux-pci/list/, and as long as it's
"New" there, I haven't forgotten about it.

Bjorn
