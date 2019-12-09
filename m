Return-Path: <SRS0=OOKX=Z7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A21C43603
	for <linux-pci@archiver.kernel.org>; Mon,  9 Dec 2019 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B172080D
	for <linux-pci@archiver.kernel.org>; Mon,  9 Dec 2019 12:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfLIMhj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:37:39 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:39816 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfLIMhj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2019 07:37:39 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 39EB51C246E; Mon,  9 Dec 2019 13:37:38 +0100 (CET)
Date:   Mon, 9 Dec 2019 13:37:38 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: Re: Linux v5.5 serious PCI bug
Message-ID: <20191209123738.pp34bu7ulqp5adv6@ucw.cz>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Hi,
> 
> I have compiled Linux v5.5-rc1 and thought all was good until I 
> hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the 
> GPU was not loaded (blacklisted) so the crash is nothing to do with the 
> GPU driver.

Obvious question is: does it work on in v5.4?
									Pavel
