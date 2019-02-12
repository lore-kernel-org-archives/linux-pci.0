Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D86C282CA
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 13:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A422184A
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 13:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfBLNlH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:41:07 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:44719 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfBLNlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 08:41:07 -0500
Received: from windsurf (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B51E310000A;
        Tue, 12 Feb 2019 13:41:03 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:41:02 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Leigh Brown <leigh@solinno.co.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: Out-of-tree mwlwifi driver crashes
Message-ID: <20190212144102.412ef7e6@windsurf>
In-Reply-To: <3029c89268680e5abe4f073d8247f74d@solinno.co.uk>
References: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
        <20190129155913.163f1e98@windsurf>
        <a56827554c95a3bcd8435d72167d35f9@solinno.co.uk>
        <20190129163117.0af2ebb3@windsurf>
        <8eb5b2981e6e60e91a3eacbb88a5ee7b@solinno.co.uk>
        <20190131164653.2599d6e7@windsurf>
        <3029c89268680e5abe4f073d8247f74d@solinno.co.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Leigh,

On Thu, 31 Jan 2019 16:06:10 +0000
Leigh Brown <leigh@solinno.co.uk> wrote:

> Thanks for responding. I had to manually apply the patch, but it 
> certainly fixes the issue.

Could you check if the branch at:

  https://github.com/tpetazzoni/linux/tree/5.0/marvell/pci-mvebu-fix

also fixes the issue for you ?

I'm sorry to ask you to do all those tests, but since I don't have a
PCIe device that uses prefetchable memory BARs, I can't test :-/

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
