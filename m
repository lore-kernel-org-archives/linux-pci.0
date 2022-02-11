Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E610C433F5
	for <linux-pci@archiver.kernel.org>; Fri, 11 Feb 2022 18:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbiBKSBV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Feb 2022 13:01:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiBKSBU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 13:01:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A528D2C9;
        Fri, 11 Feb 2022 10:01:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F11CB82BA5;
        Fri, 11 Feb 2022 18:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C16C340E9;
        Fri, 11 Feb 2022 18:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644602477;
        bh=wMW0j4PfYt0BMQjeNuwCX/MnQDgOf/USyjs5rO4GXDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hA82dzXmjfgeaRHEjem0WwcADQKw+7H4gOqFrgDxq+Gqpo2CS87+A7aBmtUvLRDcp
         bxyt62Q7pXnHqohWtpyczQV+9bCA+loaLH5p8WJ0xLuPUZaHUcKeZs5u8j1fYe9cnd
         B3XgIeb/4Oj8Y2HUzV0rJHyr5gJ4s7scqavjwBrfYOyrJG2HsZPgwTlILxHRFupI7g
         PlnlCbFUepo5wLdtgFGZuMYMgBONFuh6INutqc1q+wR2iRp7ImFx2tHi9MZi3H4Zz8
         qkLpBGgVvQ0bb+HE2G6NFU1V98dc3lPP1V+dcOyAyOP6NBsyxzKYoVuVeFTSpnnT07
         uPhYlLEi27yrg==
Received: by pali.im (Postfix)
        id 7804813A8; Fri, 11 Feb 2022 19:01:14 +0100 (CET)
Date:   Fri, 11 Feb 2022 19:01:14 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/11] PCI: mvebu: subsystem ids, AER and INTx
Message-ID: <20220211180114.ggw45n2clhsxvuq4@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220211175029.GA2300@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211175029.GA2300@lpieralisi>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 11 February 2022 17:50:45 Lorenzo Pieralisi wrote:
> Do not repost yet, I will be back at v5.17-rc5 and work towards merging it for v5.18.

Ok!
