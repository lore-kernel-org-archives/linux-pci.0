Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189BECE561
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA762087A
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 10:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="SaiEXStG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA762087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cesnet.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeIXQD7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:03:59 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:56654 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeIXQD7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Sep 2018 12:03:59 -0400
Received: from localhost (ip-78-45-154-186.net.upcbroadband.cz [78.45.154.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 27531400074;
        Mon, 24 Sep 2018 12:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1537783361;
        bh=phMCcRPhiu73eSp4pl4+2N/29MiXHy/zMlDbpY55Hb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SaiEXStGVPH3r133hecm1RVve7Lurl+QXRLDZBXhxgT6iZXz1UH7ugTGa3fmDP6P5
         qD4RQIXRkZh0wYBeGzXC7JlTWNKrA6IyCDCnppppswx57kL15hZ2RD+zYTFXUf7ygs
         XE3UDec5tG6oHnS8eoWdWbXu/ftlxw4e80Ye+DC8=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
Date:   Mon, 24 Sep 2018 12:02:33 +0200
MIME-Version: 1.0
Message-ID: <a3da76eb-7d17-40ba-a98d-c4a743240785@cesnet.cz>
In-Reply-To: <20180913104241.65db8243@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il> <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
Organization: CESNET
User-Agent: Trojita/v0.7-361-gfee56b6f-dirty; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>>> What about something like the below. I tested it, including the error
>>> case by forcing an -EPROBE_DEFER. The new pci_unmap_io() is modeled
>>> after pci_unmap_iospace(). Actually, I would prefer to use
>>> pci_remap_iospace() and pci_unmap_iospace() but for now this API
>>> doesn't allow overloading the memory type used for the mapping. =20
>>=20
>> Thanks for providing this fix so quickly, Thomas. I can confirm that this=20=

>> patch -- tested on top of=20
>> 54eda9df17f3215b9ed16629ee71ea07413efdaf ("Merge=20
>> tag 'pci-v4.19-fixes-1' of=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci").=20
>> Disclaimer: I=20
>> have zero familiarity with Linux' PCI code.
>>=20
>> Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
>
> Thanks for the testing. I'll wait for Russell to say if he is happy
> (or not) with the addition of pci_unmap_io() in the ARM code, if that's
> the case, I'll send a proper patch to fix the issue.

Hi Thomas, Russell,
is there a proper patch for this? I've just verified that 4.19-rc5 won't=20
boot for me either. Thomas' quick patch applies and makes the problem go=20
away.

With kind regards,
Jan
