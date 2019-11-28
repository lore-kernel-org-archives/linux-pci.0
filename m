Return-Path: <SRS0=N5mx=ZU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF01C432C0
	for <linux-pci@archiver.kernel.org>; Thu, 28 Nov 2019 14:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6351721771
	for <linux-pci@archiver.kernel.org>; Thu, 28 Nov 2019 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574952370;
	bh=aABX5Q1BvqEKbAEBAop5t1E8OsXAl/GaY2nZT/5zL6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=bQXcM1JP61emsDMPsNsc9bAu5vkrekqSMbmJgMGsQvVTkA1Mx9PFJcNX9lVJ0sQqz
	 zJQHEhAeRZzjg4IeI4p2b9+1Mvr0LKvO0vTUKoyxRx5t9d22fcozp42BDLeGTRoRyR
	 L1NwBuFbt9KdrmFzTOFl5olYf4zy5yzchXjXCOAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfK1OqJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfK1OqJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Nov 2019 09:46:09 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D43A7208E4;
        Thu, 28 Nov 2019 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574952369;
        bh=aABX5Q1BvqEKbAEBAop5t1E8OsXAl/GaY2nZT/5zL6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1LUFUO866b2Rej6uHJUpLgpxoW8pCIwrTp/vbhGwksORP5DOq85lTzdQWurOU6yLa
         b1rfS0zSZKqIFfntn/LR6p9T8WQejBKc6ljQ0+kUmP7STiHzcUAsmcLhRbvLEq4uQj
         mJNlVnQQxBULrcaoiozskkZTvJHfvFzSupvWW10Q=
Date:   Thu, 28 Nov 2019 08:46:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, rdunlap@infradead.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 0/1]Fix build warning and errors
Message-ID: <20191128144606.GA260904@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128101954.GA30478@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 28, 2019 at 10:19:55AM +0000, Lorenzo Pieralisi wrote:
> [+Bjorn]
> 
> On Thu, Nov 28, 2019 at 04:31:12PM +0800, Dilip Kota wrote:
> > Mark Intel PCIe driver depends on MSI IRQ Domain to fix
> > the below warnings and respective build errors.
> > 
> > WARNING: unmet direct dependencies detected for PCIE_DW_HOST
> >   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
> >   Selected by [y]:
> >   - PCIE_INTEL_GW [=y] && PCI [=y] && OF [=y] && (X86 [=y] || COMPILE_TEST [=n])
> 
> I don't know yet if we fix it up or I drop the series, given how
> late this is in the release cycle and very short time this code
> has been in -next.

I think given the timing and the holiday we need to drop it for now.
