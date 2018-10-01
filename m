Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B02C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 14:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C697213A2
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 14:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="VstMdQWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C697213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cesnet.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeJAVW7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:22:59 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:51836 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbeJAVW7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2018 17:22:59 -0400
Received: from localhost (unknown [IPv6:2001:718:1:2c:618c:c23d:a7ac:fd26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 277C0400063;
        Mon,  1 Oct 2018 16:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1538405088;
        bh=A0NijwNka8Dd83gIcjjZhKdM2NclvCr9tVjoCQMLCyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VstMdQWCrajtGoyj+zU1hfilHBRSATsyZigfk3/iCf88ycQ+LnYXVZz5f6OuCZ9nm
         ucdBOfZNweD6vNUTtXB6bzUNI2txzp1d5LEpZwwP/TRnt0y31uHXCgE4yV6rkMsB5l
         DVVVs345+z1W95h4//pm918OUOMVlXL1uND0mR9E=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PCI: mvebu: Fix PCI I/O mapping creation sequence
Date:   Mon, 01 Oct 2018 16:44:44 +0200
MIME-Version: 1.0
Message-ID: <afee5e1a-4b5a-47f6-91a9-dfe5d041a388@cesnet.cz>
In-Reply-To: <20181001124934.7222-1-thomas.petazzoni@bootlin.com>
References: <20181001124934.7222-1-thomas.petazzoni@bootlin.com>
Organization: CESNET
User-Agent: Trojita/v0.7-361-gfee56b6f-dirty; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On pond=C4=9Bl=C3=AD 1. =C5=99=C3=ADjna 2018 14:49:34 CEST, Thomas Petazzoni =
wrote:
> Commit ee1604381a371 ("PCI: mvebu: Only remap I/O space if
> configured") had the side effect that the PCI I/O mapping was created
> much earlier than before, at a point where the probe() of the driver
> could still fail. This is for example a problem if one gets an
> -EPROBE_DEFER at some point during probe(), after pci_ioremap_io() has
> been called.
>
> Indeed, there is currently no function to undo what pci_ioremap_io()
> did, and switching to pci_remap_iospace() is not an option in
> pci-mvebu due to the need for special memory attributes on Armada 38x.
>
> Reverting ee1604381a371 ("PCI: mvebu: Only remap I/O space if
> configured") would be a possibility, but it would require also
> reverting 42342073e38b5 ("PCI: mvebu: Convert to use pci_host_bridge
> directly"). So instead, we use an open-coded version of
> pci_host_probe() that creates the PCI I/O mapping at a point where we
> are guaranteed not to fail anymore.
>
> Reported-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
> Fixes: ee1604381a371 ("PCI: mvebu: Only remap I/O space if configured")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

Just a rebuild-and-boot test. We don't use any PCIe devices yet, but I'll=20
grab an ugly eBay converter and try this patch with a normal PCIe card=20
later.

Thanks!

Jan
