Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398DAC43612
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 15:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACC121783
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270168;
	bh=ep05JDV0jUZt3JPGp9M2KlJH4vaZEgl8Hdop8Y4VudM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hTMd3rEd9aKwvuesUK5SPOt7gTwUM3/L4aum31TVFGUkywBYwR9pXKjxtQTVPAknF
	 cEU5HmV4L4s/2esxPTHdmylEz7f86BgbuVdOCiicuV/ERK194ljOoLp6AjYPZVYYdB
	 G/9T41l00bljsC4IhuGifya7r6uBtKgBhcjyoeo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeLaP31 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:29:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeLaP31 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 10:29:27 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450502133F;
        Mon, 31 Dec 2018 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270166;
        bh=ep05JDV0jUZt3JPGp9M2KlJH4vaZEgl8Hdop8Y4VudM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mt0r7B0iq02qpZwkWngDX5Luz/oENZKBhgEcBqkTHCTQcRyFPofeZML5H1E9YBOqQ
         tdH+hVzbPtNVeaIHfgLU9Iy3EtQ5aCx4FerbGPIi16vBMMlfHLuxi9M5ZBGDpk/YWr
         K8GJ97dJjnBde51sDxnTnWd20bkbwedHDdoB/dmk=
Date:   Mon, 31 Dec 2018 09:29:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
        Robin Leblon <robin.leblon@ncentric.com>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
Message-ID: <20181231152918.GE159477@google.com>
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
 <20181230010625.GC159477@google.com>
 <m336qegfzv.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m336qegfzv.fsf@t19.piap.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 31, 2018 at 11:14:28AM +0100, Krzysztof Hałasa wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > 802b7c06adc7 replaced cns3xxx_pci_write_config(), which always used
> > __raw_writel() so it only did 32-bit accesses, with
> > pci_generic_config_write(), which uses writeb/writew/writel()
> > depending on the size.
> >
> > 802b7c06adc7 also converted cns3xxx_pci_read_config() from always
> > using __raw_readl() (a 32-bit access) to using
> > pci_generic_config_read32(), which also always does a 32-bit access.
> >
> > This makes me think the cnx3xxx hardware is only capable of 32-bit
> > accesses, and this patch should change the driver to use
> > pci_generic_config_write32() instead of pci_generic_config_write() in
> > addition to the mapping fix above.
> 
> Hasn't it already been verified that the CNS3xxx can do 8-bit accesses
> (and probably 16-bit ones as well), and that the docs don't mention any
> such limitation?

Quite possibly.  I'm not familiar with the hardware or docs so can't
comment personally.

802b7c06adc7 reimplemented cns3xxx_pci_read_config() using
pci_generic_config_read32(), which preserved the property of only
doing 32-bit reads.  It replaced cns3xxx_pci_write_config() with
pci_generic_config_write(), so it changed writes from always being 32
bits to being the actual size.  I think this was an error in the
original commit, since the changelog doesn't mention this change; in
fact, the changelog says it changes __raw_writel to writel.

The change from 32-bit to actual size accesses would logically be a
separate commit from changing to use the generic accessors.

Assuming the hardware does support smaller accesses, I'd propose two
patches:

  1) The current one that corrects the address alignment error, and
  2) A new one that converts cns3xxx_pci_read_config() to use
     pci_generic_config_read() instead of pci_generic_config_read32().

Ideally the changelog for the second patch would refer to the
verification that the hardware is capable of 8- and 16-bit accesses.

Bjorn
