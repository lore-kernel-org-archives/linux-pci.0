Return-Path: <SRS0=Q3uD=3E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D1C32771
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17F42465A
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579107704;
	bh=eOi5R+y1PHXXhkCj84dFj6bDFzmL2yN20+wjZc//NUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=bmPuyyLeENq6B6uXSqx4oILM0GpEdVfwi5fNyRU2gFn6SnYmPdPHL4Gb2cPJ8e47E
	 8mPDU1KIyUOrGc/lyrl7rVcoLpwmQ7UBDqP7GoDsSbAsvbOm0LvNxGvXDblzucfON0
	 3q3lU/p32qshV7kwGoLlRpSoSTDyqOg+XinC4PQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAORBo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgAORBo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:01:44 -0500
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F4FE214AF;
        Wed, 15 Jan 2020 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579107703;
        bh=eOi5R+y1PHXXhkCj84dFj6bDFzmL2yN20+wjZc//NUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L0OaVMAz60Ii0HQk32z784XU+N8eFgGcdoFAR3XfA0/I5QK6KoWzdDae9BDQfendb
         XmvlfJaxi/b8SLAkTuYMUavXjbwjxQbnBdo8mXHp8MKvjeIKt+qC2ngT9Af/ZjWAVJ
         g97BX0mZU4ONjlqd5sHwDbI7oExQ0b/drjnyBRBc=
Date:   Wed, 15 Jan 2020 11:01:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>
Subject: Re: [PATCH v2 0/7]  Switchtec Gen4 Support
Message-ID: <20200115170142.GA171752@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115035648.2578-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 08:56:41PM -0700, Logan Gunthorpe wrote:
> Hi,
> 
> Here are the cleaned up version of the patches for Gen4 support in
> switchtec. The end result is mostly the same, save some very minor
> changes, but the organization into commits has been reworked per
> Bjorn's feedback. This set is also rebased onto pci/switchtec.

Beautiful.  Applied to pci/switchtec, thank you very much!

> Kelvin Cao (2):
>   PCI/switchtec: Add gen4 support for the flash information interface
>   PCI/switchtec: Introduce gen4 variant IDS in the device ID table
> 
> Logan Gunthorpe (5):
>   PCI/switchtec: Rename generation specific constants
>   PCI/switchtec: Introduce Generation Variable
>   PCI/switchtec: Refactor ioctl_flash_part_info()
>   PCI/switchtec: Separate out gen3 register structures into unionse
>   PCI/switchtec: Add gen4 support for the system info registers
> 
>  drivers/pci/quirks.c                 |  18 ++
>  drivers/pci/switch/switchtec.c       | 334 +++++++++++++++++++++------
>  include/linux/switchtec.h            | 148 ++++++++++--
>  include/uapi/linux/switchtec_ioctl.h |  13 +-
>  4 files changed, 424 insertions(+), 89 deletions(-)
> 
> --
> 2.20.1
