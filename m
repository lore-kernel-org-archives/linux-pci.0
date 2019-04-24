Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0096BC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91A0218FC
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 05:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDXFiW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:38:22 -0400
Received: from verein.lst.de ([213.95.11.211]:51387 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfDXFiW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Apr 2019 01:38:22 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A1ADA68AFE; Wed, 24 Apr 2019 07:38:06 +0200 (CEST)
Date:   Wed, 24 Apr 2019 07:38:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/2] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Message-ID: <20190424053806.GA12136@lst.de>
References: <20190410080220.21705-1-hch@lst.de> <20190410080220.21705-3-hch@lst.de> <20190410081617.GA54229@gmail.com> <20190410214500.GK256045@google.com> <20190411051849.GA26205@lst.de> <20190411133543.GO256045@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411133543.GO256045@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Is anyone going to pick this patch up?
