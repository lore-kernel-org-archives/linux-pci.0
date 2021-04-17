Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FD7C433B4
	for <linux-pci@archiver.kernel.org>; Sat, 17 Apr 2021 15:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE699611AF
	for <linux-pci@archiver.kernel.org>; Sat, 17 Apr 2021 15:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhDQPUR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 17 Apr 2021 11:20:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56964 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236287AbhDQPUR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Apr 2021 11:20:17 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lXmjS-00HG9v-O3; Sat, 17 Apr 2021 17:19:38 +0200
Date:   Sat, 17 Apr 2021 17:19:38 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Marek Behun <marek.behun@nic.cz>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain
 to zero
Message-ID: <YHr8ikD+zoT2/K3W@lunn.ch>
References: <20210412123936.25555-1-pali@kernel.org>
 <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
 <20210415083640.ntg6kv6ayppxldgd@pali>
 <20210415104537.403de52e@thinkpad>
 <CAL_JsqL2gjprb3MDv8KPSpe0CUBFjGajnMbF71DM+F9Yewp2uw@mail.gmail.com>
 <20210417144953.pznysgn5rdraxggx@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417144953.pznysgn5rdraxggx@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Currently this code is implemented in pci_bus_find_domain_nr() function.
> IIRC domain number is 16bit integer, so plain bitmap would consume 8 kB
> of memory. I'm not sure if it is fine or some other tree-based structure
> for allocated domain numbers is needed.

Hi Pali

Have a look at lib/idr.c

     Andrew
