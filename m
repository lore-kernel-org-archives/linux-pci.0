Return-Path: <SRS0=zjv9=63=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B205FC2D0FC
	for <linux-pci@archiver.kernel.org>; Wed, 13 May 2020 11:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BC92078C
	for <linux-pci@archiver.kernel.org>; Wed, 13 May 2020 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589368615;
	bh=40kDCCPvDFkDZnvfE0oEeO/xo+Tmp5VDSTcS0YnGUcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jr31MRkehGnfktQAzGQdZxxSZ8PBnIzzOp7ZjPX0mW3UcRFtuaLKCsZnX97iDnXW9
	 fiV/DwT7feZrJeee/9XppquyUL5QObmjgJhkVfmm/FT+n4ayXJBkZkUcYODKHa+7gE
	 uKT9NSV/33ZARRKHbe+d0Dv6pXTC0aD2zBq8wRNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgEMLQy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 May 2020 07:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbgEMLQy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 07:16:54 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FBA5206E5;
        Wed, 13 May 2020 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589368614;
        bh=40kDCCPvDFkDZnvfE0oEeO/xo+Tmp5VDSTcS0YnGUcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXXj67nUm87Aj49o92BvnC3oSAFsTthqZjQKC0eGfYLl0piCJ61Rh/94Vv33cn0qU
         NlwzFE3k3y3tH6QW1f+W4FOXT00EvVDZ1cSdL1TRZLYm6Pb+OPk/XkfSd3f3oNJF2N
         +vpKvMCxEV0BPtWUsbbo7nJzNa8KBH7fAK3nsooc=
Received: by pali.im (Postfix)
        id E89ED774; Wed, 13 May 2020 13:16:51 +0200 (CEST)
Date:   Wed, 13 May 2020 13:16:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200513111651.q62dqauatryh6xd6@pali>
References: <20200430080625.26070-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430080625.26070-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 30 April 2020 10:06:13 Pali Rohár wrote:
> Hello,
> 
> this is the fourth version of the patch series for Armada 3720 PCIe
> controller (aardvark). It's main purpose is to fix some bugs regarding
> buggy ath10k cards, but we also found out some suspicious stuff about
> the driver and the SOC itself, which we try to address.
> 
> Patches are available also in my git branch pci-aardvark:
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark

Hello! Thanks everybody for review and testing of this patch series.

I would like to ask, is there something needed to fix / modify in this
patch series? If everything is OK, would you Bjorn or Lorenzo take this
patch series into your tree?
