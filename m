Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF849C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 21:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80419206BA
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 21:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80419206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeKTIXs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:23:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41785 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731422AbeKTIXs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 03:23:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5E25A20D0D; Mon, 19 Nov 2018 22:58:06 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id C35D420510;
        Mon, 19 Nov 2018 22:57:55 +0100 (CET)
Date:   Mon, 19 Nov 2018 22:57:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Antoine =?UTF-8?B?VMOpbmFydA==?= 
        <antoine.tenart@free-electrons.com>,
        =?UTF-8?B?R3LDqWdvcnk=?= Clement 
        <gregory.clement@free-electrons.com>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal 
        <miquel.raynal@free-electrons.com>, Victor Gu <xigu@marvell.com>
Subject: Re: [PATCH RFC v4.14] PCI: aadrvark: warm reset the cores and card
Message-ID: <20181119225754.1284ee1b@xps13>
In-Reply-To: <20181119170948.GA30910@red-moon>
References: <20181024152056.17813-1-marek.behun@nic.cz>
        <20181119170948.GA30910@red-moon>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Mon, 19 Nov 2018
17:09:48 +0000:

> On Wed, Oct 24, 2018 at 05:20:56PM +0200, Marek Behún wrote:
> > Add code to do a warm reset on the PHY and PCIE cores and if PERSTN GPIO
> > is specified in device tree (as reset-gpio), also reset the card.
> > 
> > The reset-gpio is inspired by what is done in U-Boot and linux-marvell,
> > and is not final version: I am hoping this can be done via a PCIe register
> > rather than GPIO - bit 3 of CTRL_WARM_RESET_REG register (which is added
> > by this patch) is called PERSTN_GPIO_EN (Enable PERSTN from GPIO) and
> > I think this is the right register, but manipulating this register did
> > not have any effect on the PERSTN pin, even when pinctrl was correctly set.
> > 
> > I asked Marvell about this and am awaiting their reply.
> > 
> > The reset-gpio is needed for Compex 5 GHz wifi card model WLE900VX. Without
> > this patch the PCIe link never comes up in kernel (although U-Boot pci
> > command was able to enumerate the card).
> > 
> > What is weird is that the link does not come up for this card when
> > pci-aardvark driver is probed in U-Boot. I haven't yet had time to discover
> > the problem there. My temporary solution is to compile out the pci-aardvark
> > driver from U-Boot.
> > 
> > This patch is based on 4.14 kernel.  
> 
> This is not a commit log, these comments go either in a cover letter
> or below the log, prior to the diff.
> 
> Patches should always be aimed at mainline, that's what is discussed
> and merged on linux-pci@vger.kernel.org
> 
> Given its RFC status I consider this patch a proof of concept and
> won't consider it for upstreaming, not yet at least.
> 
> > If you have time, please try it with some PCIe cards and let me know
> > if they work correctly.  
> 
> See above. For the time being I will drop this patch from the linux-pci
> patch queue, I really do not know what to do with it.
> 
> Thanks,
> Lorenzo

Just an FYI, I am currently working on S2RAM support on A3700, and
doing this I added a few things to this driver including reset GPIO
support. Patches will come soon. There is no warm-reset coming in
though. 

Thanks,
Miquèl
