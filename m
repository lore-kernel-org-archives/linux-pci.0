Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28E6C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 13:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD8521841
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 13:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeLRNrE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:47:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59002 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeLRNrE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 08:47:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A44F1207B2; Tue, 18 Dec 2018 14:47:02 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 77BDB207B2;
        Tue, 18 Dec 2018 14:47:02 +0100 (CET)
Date:   Tue, 18 Dec 2018 14:47:02 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated
 bridge config space
Message-ID: <20181218144702.752d97cd@windsurf>
In-Reply-To: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Tue, 18 Dec 2018 12:31:51 +0000, Luís Mendes wrote:

> I've been running Linux on a armhf with an AMD gpu card and since this
> commit, in linux 4.20, the amdgpu driver causes a kernel oops and fails to
> initialize when calling pci_map_rom, which then fails on a call to
> ioremap_page_range. If I revert the patch from commit
> 
> 1f08673eef1236f7d02d93fcf596bb8531ef0d12
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.20-rc7&id=1f08673eef1236f7d02d93fcf596bb8531ef0d12>
> then
> amdgpu successfully initializes.
> 
> The kernel oops follows in attachment.

Thanks for the bug report! I have an idea of what could be causing
this, I've cooked a patch, I'm doing a build test. I of course won't be
able to test it as I don't have amdgpu hardware, but I'll share the
patch with you for testing.

Note: I'm not sure where you found <linux-pci@atrey.karlin.mff.cuni.cz>
to be the address of the linux-pci mailing list, it's really
linux-pci@vger.kernel.org.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
