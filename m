Return-Path: <SRS0=X3es=PR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C05C43387
	for <linux-pci@archiver.kernel.org>; Wed,  9 Jan 2019 07:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DFC2070B
	for <linux-pci@archiver.kernel.org>; Wed,  9 Jan 2019 07:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfAIHZ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:25:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:57873 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfAIHZ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jan 2019 02:25:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x097PHmV006512;
        Wed, 9 Jan 2019 01:25:18 -0600
Message-ID: <1cf957e55f9587cb5aba557d0e723deaa5358fe1.camel@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        davem@davemloft.net, saeedm@mellanox.com, ogerlitz@mellanox.com,
        tariqt@mellanox.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, alex.williamson@redhat.com,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        sbest@redhat.com, paulus@samba.org
Date:   Wed, 09 Jan 2019 18:25:17 +1100
In-Reply-To: <23e44611-7eec-b57c-c5a0-6c3b96133a9e@ozlabs.ru>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
         <20181206064509.GM15544@mtr-leonro.mtl.com>
         <20190104034401.GA2801@umbus.fritz.box> <20190105175116.GB14238@ziepe.ca>
         <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
         <20190108040129.GE5336@ziepe.ca>
         <012d24d58a542ed44c8af9f517f1bd61ab912037.camel@kernel.crashing.org>
         <20190109053045.GE6682@umbus.fritz.box>
         <23e44611-7eec-b57c-c5a0-6c3b96133a9e@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-01-09 at 17:32 +1100, Alexey Kardashevskiy wrote:
> I have just moved the "Mellanox Technologies MT27700 Family
> [ConnectX-4]" from garrison to firestone machine and there it does not
> produce an EEH, with the same kernel and skiboot (both upstream + my
> debug). Hm. I cannot really blame the card but I cannot see what could
> cause the difference in skiboot either. I even tried disabling NPU so
> garrison would look like firestone, still EEH'ing.

The systems have a different chip though, firestone is P8 and garrison
is P8', which a slightly different PHB revision. Worth checking if we
have anything significantly different in our inits and poke at the HW
guys.

BTW. Are the cards behind a switch in either case ?

Cheers,
Ben.


