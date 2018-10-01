Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754A5C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 21:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AE32145D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 21:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHV41BUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AE32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeJBDl3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeJBDl3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 23:41:29 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0578320666;
        Mon,  1 Oct 2018 21:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538427709;
        bh=nyOqSHf5GBCgabU0j8NVAuvUKyvRd8MQZUOoJibHyk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHV41BUK6jldTNiOXlau9owxY6uDkAnNd22Tw6OWGNbX4lZyGgvAgztGyIGt4VPoP
         x5K6c5ohMoOzuG3bd3IFVvuMpfmfiZNv276Zhq0A8JXpk9qOjMrirsLHqHNkYFHWlA
         1mEHygedoiu9RJNhwyveEEgJ+LZpdPdY9gMKfhtE=
Date:   Mon, 1 Oct 2018 16:01:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        linux-pci@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20181001210147.GF142872@bhelgaas-glaptop.roam.corp.google.com>
References: <20180924101213.GO30658@n2100.armlinux.org.uk>
 <20180924122614.70738b5c@windsurf>
 <20180924111341.GP30658@n2100.armlinux.org.uk>
 <20180924141203.3df9707a@windsurf>
 <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
 <20180924151040.5e57462b@windsurf>
 <20180924141512.GA11875@e107981-ln.cambridge.arm.com>
 <20180924165218.26c7c418@windsurf>
 <0f80dc88-dffe-4ca6-bb85-c4e5c967e0e1@cesnet.cz>
 <20181001145148.158c6207@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181001145148.158c6207@windsurf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 01, 2018 at 02:51:48PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon, 01 Oct 2018 12:56:37 +0200, Jan Kundrát wrote:
> 
> > Thomas, Russell, Lorenzo,
> > did you have time to convert this into a patch which can hit 4.19? I don't 
> > see anything related in 4.19-rc6, but perhaps I missed something. Is there 
> > something that I should test or otherwise help?
> 
> Sorry, I suddenly got busy (my second son arrived a few days earlier
> than expected).

Congratulations!

> I just sent a proper patch with the proposal I made last week, after
> testing on ClearFog and Armada XP GP. Note that on ClearFog, I only
> tested that it fixes the panic at boot, since I didn't had any
> mini-PCIe devices at hand. On Armada XP GP, I verified that an E1000E
> NIC was still working as expected. Therefore, it would be useful if
> you could test on your ClearFog platform with PCI devices connected.
> 
> Thanks a lot and sorry for the delay.

And thanks for the patch!  No need to apologize for having a life :)

Bjorn
