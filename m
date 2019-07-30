Return-Path: <SRS0=at4K=V3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E697BC433FF
	for <linux-pci@archiver.kernel.org>; Tue, 30 Jul 2019 18:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DB8208E4
	for <linux-pci@archiver.kernel.org>; Tue, 30 Jul 2019 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564511106;
	bh=2xncdpK2J1RersRdjUzIlXExFmZioyenQiPobsms38I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kGeIJ09FF0iKqY8elMSKkrpRT4uwbJrVyvUmIJYssPDFjoVJyS1Ikt18i4cw6uTUo
	 YtENIksI0CHE5K3ynJeR5I8G6ImEKOQ00zQ/u6IA7OwAuSeDLmepXkA2QHsqL33vhz
	 QObv6YkT9VhSjl3sLFjYox9v6HUFsM9xw6ytEoKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfG3SZG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfG3SZG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jul 2019 14:25:06 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66F82087F;
        Tue, 30 Jul 2019 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564511105;
        bh=2xncdpK2J1RersRdjUzIlXExFmZioyenQiPobsms38I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wkG/el70Z3il0Z8+OdQuanuSkDxOvC+ZkzjEzWuTzbFHpKZv+kLZuaQXwOJ5GinhX
         1Vm+dEqxDYq8jNWNdMxQw5CFKnO99k9uuzCsdVjFY1FoSWpGbndvVX5t8pu/eTrBvy
         h0sJpcy4GffeO7R5WdLzSlefy0e6Qf/9B8+xW87M=
Date:   Tue, 30 Jul 2019 13:25:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: Convert pci_resource_to_user() to a weak
 function
Message-ID: <20190730182503.GJ203187@google.com>
References: <20190729101401.28068-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729101401.28068-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 29, 2019 at 01:13:56PM +0300, Denis Efremov wrote:
> Architectures currently define HAVE_ARCH_PCI_RESOURCE_TO_USER if they want
> to provide their own pci_resource_to_user() implementation. This could be
> simplified if we make the generic version a weak function. Thus,
> architecture specific versions will automatically override the generic one.
> 
> Changes in v2:
> 1. Removed __weak from pci_resource_to_user() declaration
> 2. Fixed typo s/spark/sparc/g
> 
> Denis Efremov (5):
>   PCI: Convert pci_resource_to_user to a weak function
>   microblaze/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
>   mips/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
>   powerpc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
>   sparc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
> 
>  arch/microblaze/include/asm/pci.h |  2 --
>  arch/mips/include/asm/pci.h       |  1 -
>  arch/powerpc/include/asm/pci.h    |  2 --
>  arch/sparc/include/asm/pci.h      |  2 --
>  drivers/pci/pci.c                 |  8 ++++++++
>  include/linux/pci.h               | 12 ------------
>  6 files changed, 8 insertions(+), 19 deletions(-)

Thanks, I added Paul's ack, squashed into a single patch since I think
it's easier to see what's going on then, and applied to pci/misc for
v4.5.
