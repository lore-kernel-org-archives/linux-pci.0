Return-Path: <SRS0=GIoD=2G=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C596C43603
	for <linux-pci@archiver.kernel.org>; Mon, 16 Dec 2019 06:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBFA20717
	for <linux-pci@archiver.kernel.org>; Mon, 16 Dec 2019 06:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLPGu2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 16 Dec 2019 01:50:28 -0500
Received: from mx2a.mailbox.org ([80.241.60.219]:48597 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfLPGu2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 01:50:28 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 60E2CA1C9B;
        Mon, 16 Dec 2019 07:50:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id u1m2KkARh5S2; Mon, 16 Dec 2019 07:50:22 +0100 (CET)
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
To:     bjorn@helgaas.com,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
References: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
 <PSXP216MB0438BE9DA58D0AF9F908070680540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <c9f154e5-4214-aa46-2ce2-443b508e1643@denx.de>
 <PSXP216MB0438AD1041F6BD7DB51363A380540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CABhMZUUGTiH-KfPtLQrc6LkXzc7CpkrAcOSmvv6p0Uj4K+_abQ@mail.gmail.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <be8abbfc-2f98-a6cb-fbf5-7ec8e7051a39@denx.de>
Date:   Mon, 16 Dec 2019 07:50:20 +0100
MIME-Version: 1.0
In-Reply-To: <CABhMZUUGTiH-KfPtLQrc6LkXzc7CpkrAcOSmvv6p0Uj4K+_abQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16.12.19 01:46, Bjorn Helgaas wrote:
>>> The logs are also included. Please let me know, if I should do any other
>>> tests and provide the logs.
> 
> Please include these logs in your mail to the list or post them
> someplace where everybody can see them.

Gladly. Please find the archive here:

https://filebin.ca/55U8waihXJVI/logs.tar.bz2

Thanks,
Stefan
