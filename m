Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5FFC43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98092084C
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 19:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="eQ2I/Mmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98092084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cesnet.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeJBCEm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:04:42 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:46378 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJBCEm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2018 22:04:42 -0400
Received: from localhost (unknown [IPv6:2001:718:1:2e:618c:c23d:a7ac:fd26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id CA21F400070;
        Mon,  1 Oct 2018 21:25:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1538421923;
        bh=RLus09YEAra5NwIGDH0OyI0HwjIsliG082XMaBzUMIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eQ2I/MmzqA9zuP4ooFgFHN+wQhTt51Z0znvveqFcaXabCpxrQh3QgUVaqjK9QHurl
         giBk1xNyn07xElV8Q3RInRZlvYFZZHVilWeVxjeHXAQ+in+XVCYLJKvsZ9qnTHTQVT
         TlhovuWclADaVAwkYh6VcvEwpqQ8ZFh9PjnVCPsI=
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
Date:   Mon, 01 Oct 2018 21:25:21 +0200
MIME-Version: 1.0
Message-ID: <3ced4629-5fed-4399-9ac4-2e570033e6af@cesnet.cz>
In-Reply-To: <afee5e1a-4b5a-47f6-91a9-dfe5d041a388@cesnet.cz>
References: <20181001124934.7222-1-thomas.petazzoni@bootlin.com>
 <afee5e1a-4b5a-47f6-91a9-dfe5d041a388@cesnet.cz>
Organization: CESNET
User-Agent: Trojita/v0.7-361-gfee56b6f-dirty; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Just a rebuild-and-boot test. We don't use any PCIe devices=20
> yet, but I'll grab an ugly eBay converter and try this patch=20
> with a normal PCIe card later.

The patch works. I can access an i210 over a miniPCIe -> PCIe adapter.

With kind regards,
Jan
