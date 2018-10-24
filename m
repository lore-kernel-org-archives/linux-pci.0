Return-Path: <SRS0=WZ4f=NE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C676ECDE44
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 22:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B0120831
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 22:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzXDEVjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B0120831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJYGaj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeJYGaj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 02:30:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F284E2075D;
        Wed, 24 Oct 2018 22:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540418450;
        bh=ltRyFvvnL2kTzdym5JpZLgLj3QWdbxk/oZumBfWn/HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzXDEVjANDni3q193gY/k1mVhPwxLs+BZrUAhAfFBEi/5Wu92G//jOWDzqGS11nzI
         LMrkDqsdkPhc2NTBApSPVG5uOfSXXMMLTDdWQLmqcVdBqBRgzni0Wum804RxLedlQD
         +eQRmeajoBcRjFmecWVMpFdH3AtN4/eZVlnHd9rI=
Date:   Wed, 24 Oct 2018 17:00:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-pci@vger.kernel.org,
        Antoine =?iso-8859-1?Q?T=E9nart?= 
        <antoine.tenart@free-electrons.com>,
        =?iso-8859-1?Q?Gr=E9gory?= Clement 
        <gregory.clement@free-electrons.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal 
        <miquel.raynal@free-electrons.com>, Victor Gu <xigu@marvell.com>
Subject: Re: [PATCH RFC v4.14] PCI: aadrvark: warm reset the cores and card
Message-ID: <20181024220048.GD214775@bhelgaas-glaptop.roam.corp.google.com>
References: <20181024152056.17813-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181024152056.17813-1-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Wed, Oct 24, 2018 at 05:20:56PM +0200, Marek Behún wrote:
> Add code to do a warm reset on the PHY and PCIE cores and if PERSTN GPIO
> is specified in device tree (as reset-gpio), also reset the card.
> 
> The reset-gpio is inspired by what is done in U-Boot and linux-marvell,
> and is not final version: I am hoping this can be done via a PCIe register
> rather than GPIO - bit 3 of CTRL_WARM_RESET_REG register (which is added
> by this patch) is called PERSTN_GPIO_EN (Enable PERSTN from GPIO) and
> I think this is the right register, but manipulating this register did
> not have any effect on the PERSTN pin, even when pinctrl was correctly set.
> 
> I asked Marvell about this and am awaiting their reply.
> 
> The reset-gpio is needed for Compex 5 GHz wifi card model WLE900VX. Without
> this patch the PCIe link never comes up in kernel (although U-Boot pci
> command was able to enumerate the card).
> 
> What is weird is that the link does not come up for this card when
> pci-aardvark driver is probed in U-Boot. I haven't yet had time to discover
> the problem there. My temporary solution is to compile out the pci-aardvark
> driver from U-Boot.
> 
> This patch is based on 4.14 kernel.

Thanks for your research and the patch!

As I'm sure you know, this would have to be applied to the latest
kernel, e.g., v4.20-rc1 (when that comes out in about 10 days), so the
best place to test it would be v4.19 + this patch, or v4.20-rc1 + this
patch.

After it's applied to the master branch, it's possible it could be
backported to stable kernels if appropriate.

> If you have time, please try it with some PCIe cards and let me know if they
> work correctly.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Lorenzo  Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Bjorn Helgaas  <helgaas@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: Antoine Ténart  <antoine.tenart@free-electrons.com>
> Cc: Grégory  Clement  <gregory.clement@free-electrons.com>
> Cc: Miquèl Raynal  <miquel.raynal@free-electrons.com>
> Cc: Victor Gu <xigu@marvell.com>

Nit: some of the CC lines above have extra spaces.
