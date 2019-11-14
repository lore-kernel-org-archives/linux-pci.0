Return-Path: <SRS0=nbQ7=ZG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE13C432C3
	for <linux-pci@archiver.kernel.org>; Thu, 14 Nov 2019 19:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF2320718
	for <linux-pci@archiver.kernel.org>; Thu, 14 Nov 2019 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573759073;
	bh=BRlUt8H8C2cCUF+o48sd08rpe84GQ5Ch/lSREuI227M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=tmyH1RzeJP16j2d7A3YoYAjn3ywpBPkcuaxwGS0ZbWuuWBSRk1PWgWEyIYI8WJU3R
	 ItWbu5cEGn9TvBL8n1/qDT/0EHr5P3uBcLZf7bJG03AIrnBYpGxB334ZeCTMU/7aVP
	 6ceFDy8ClNIbfJHwH6oamHypbX5XmxH6npXb0yh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKNTRx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfKNTRw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 14:17:52 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3212220723;
        Thu, 14 Nov 2019 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573759072;
        bh=BRlUt8H8C2cCUF+o48sd08rpe84GQ5Ch/lSREuI227M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OCSOyWQnU2SUIgtuGCoEOQkznlpQMYS0s3nwlDSKP12YoVGWPz5Fyo/I5QICTjY3W
         7j4jMq8ENB5tWXtSEiZr3PcXEy8aYamsqw+DnI0uUl1LatCua8MvbV46Ci7CVCVQj2
         J4nT6TEJLsamfDN9Qv5ULXzwWiMtxsuSsiFLPH80=
Date:   Thu, 14 Nov 2019 13:17:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: Question about pci_alloc_consistent() return address
Message-ID: <20191114191750.GA230106@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHhAz+j+pN3fy_9NTBBchuz_X1a-FQK0Lt8ty3sk3qkufH7KYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph]

On Thu, Nov 14, 2019 at 02:21:21PM +0530, Muni Sekhar wrote:
>  I’m using pci_alloc_consistent() in PCIe driver. My PCIe device only
> works 64 bit data  boundary transactions.
> 
> Is there a way to make sure pci_alloc_consistent() always returns
> 64-bit aligned address?

See Documentation/DMA-API-HOWTO.txt.  pci_alloc_consistent() is
implemented in terms of dma_alloc_coherent(), and that doc says
regions returned from dma_alloc_coherent() are guaranteed to be at
least PAGE_SIZE-aligned.

Are you seeing otherwise, or are you just making sure?  The dma_pool
interface for allocating smaller regions has a way to request the
alignment you need.

Bjorn
