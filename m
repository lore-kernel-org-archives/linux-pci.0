Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB2DC43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA7C2087A
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 20:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiaOx7wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA7C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeJKEM3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeJKEM3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 00:12:29 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34E4020870;
        Wed, 10 Oct 2018 20:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539204516;
        bh=oIX+NYLe24gV8UVZSxrHeVrZYB7utXTldSJxeijHIeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jiaOx7wygGq2r09l7regO35bWNIMF1nKm9cPBHPl5ALSU4axA2XW//vbR1jW5yrcf
         Sbfat+SU5IcFsKGbrF6T+pmwktnb7AabTS/VlXVeD/vCns5aUyJwx/ViGxJG2k+4Gf
         aRU+c09zVTvf4p235oqc9VjutfqAiJpLdurDMIuw=
Date:   Wed, 10 Oct 2018 15:48:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI DMA compat cleanups
Message-ID: <20181010204835.GJ5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181009140824.18667-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009140824.18667-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 09, 2018 at 04:08:21PM +0200, Christoph Hellwig wrote:
> Start removing a few almost unused bits of the PCI DMA compat wrappers.

Applied to pci/misc for v4.20, thanks!
