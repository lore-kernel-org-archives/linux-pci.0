Return-Path: <SRS0=7A2k=EE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05502C55179
	for <linux-pci@archiver.kernel.org>; Thu, 29 Oct 2020 01:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B765F20796
	for <linux-pci@archiver.kernel.org>; Thu, 29 Oct 2020 01:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391053AbgJ2BVX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:21:23 -0400
Received: from mail.nic.cz ([217.31.204.67]:56656 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391052AbgJ2BVX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 21:21:23 -0400
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id 327281409C8;
        Thu, 29 Oct 2020 02:21:18 +0100 (CET)
Date:   Thu, 29 Oct 2020 02:21:11 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     "=?UTF-8?B?4oSi1p/imLvSh8ytING8INKJIMKu?=" <vtolkm@googlemail.com>
Cc:     vtolkm@gmail.com,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201029022111.50079f0d@nic.cz>
In-Reply-To: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
References: <20201028144209.GA315566@bjorn-Precision-5520>
        <87pn52mlqk.fsf@toke.dk>
        <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Oct 2020 16:40:00 +0000
"™֟☻̭҇ Ѽ ҉ ®" <vtolkm@googlemail.com> wrote:

> Found this patch
> 
> https://github.com/openwrt/openwrt/blob/7c0496f29bed87326f1bf591ca25ace82373cfc7/target/linux/mvebu/patches-5.4/405-PCI-aardvark-Improve-link-training.patch 
> 
> 
> that mentions the Compex WLE900VX card, which reading the lspci verbose 
> output from the bugtracker seems to the device being troubled.

It seems mvebu driver in combination with compex card is similarily
broken as aardvark was... :) Hopefully Pali will want to look into this.

Marek
