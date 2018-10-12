Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E364AC6783C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78392087D
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 09:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbdGC3Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78392087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeJLQtj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:49:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeJLQti (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Oct 2018 12:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5MI4lu+BIuGCTuR88Pfi0tySuhtp27gf77ge+iY9dM0=; b=hbdGC3Zu5Yj9kh5IwHW4nHnpo
        bki9334rfhDYWiHExW3MbqARpt+omtU0yY42ysGZwp2NYqEeqIjRsTaxSgdQ21ueFbVHZ5l7OJUPt
        9vnCO1ds8W4mgE+kTP0cMQXOeV8nmJE6a/EoC6JY1BhIrm4/8Se2NQEYQSq12jFHn7RxGcZ5DACJ0
        Xv96ZPSYtFs8Lcdcz2fzJQAe9y/h04E++xZaFMtAERCYp30uhmeEXBVuaatpW1+9diaaXP6X46cQP
        ztLGT3atmupE34Gy1lco48xhWCI0KcYrGfcjtw5v0bfPgOgSwcSkgyKii8cIum4qYxaj3w/2pFV02
        FE4TLI4Vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAtaD-0002po-FO; Fri, 12 Oct 2018 09:18:09 +0000
Date:   Fri, 12 Oct 2018 02:18:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH v5 08/11] PCI: Unify pci_reset_function_locked() and
 __pci_reset_function_locked()
Message-ID: <20181012091809.GA6669@infradead.org>
References: <20181011045008.32212-1-okaya@kernel.org>
 <20181011045008.32212-8-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011045008.32212-8-okaya@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 04:50:00AM +0000, Sinan Kaya wrote:
> The difference between pci_reset_function_locked() and
> __pci_reset_function_locked() is the saving and restoring of the registers.
> Unify these API by adding saverestore argument that caller passes.

Adding random boolean arguments doesn't really help the API.  Either
make this another flag for reset_type or if there is a clear benefit
add an additional flags parameter with well described flags.
