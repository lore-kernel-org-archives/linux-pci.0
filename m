Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4124C04AA5
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 20:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859202098A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 20:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/ApFkNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859202098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeJPEp4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbeJPEpz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 00:45:55 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D809208B3;
        Mon, 15 Oct 2018 20:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539637139;
        bh=Yc8YPImrbm0bG3HuT5L0gGmGboXxuPslHc/I3dHqBAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/ApFkNraFOU0JrdoZthxEE4Vyd/4BYUKte1YL7bvUmRflF8ZVyxfEQKhxDVbWCEz
         ht1hd5oWbs7s44vzcKG+PxdlZhmL9Rkfv/w6ENfeCUC9gHQSKH/46emqSBKs0D+zsp
         Hh1bIQ+MNWpS/TllWOw0DpU8uppi10WUhwRF1Yo8=
Date:   Mon, 15 Oct 2018 15:58:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/8] pci: consolidate PCI config entry in drivers/pci
Message-ID: <20181015205857.GE5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013151016.31674-5-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/^pci: /PCI: / in subject

On Sat, Oct 13, 2018 at 05:10:12PM +0200, Christoph Hellwig wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAS_PCI symbol that indicates availability
> of PCI support and the handle the rest in drivers/pci.
> 
> Note that for powerpc we now select HAS_PCI globally instead of the
> convoluted mess of conditional or or non-conditional support per board,
> similar to what we do e.g. on x86.  For alpha PCI is selected for the
> non-jensen configs as it was the default before, and a lot of code does
> not compile without PCI enabled.  On other architectures with limited
> PCI support that wasn't as complicated I've left the selection as-is.

Thanks for doing this.  It's a great cleanup.  I know you have a few
things you're cleaning up, but add my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

when you do that.
