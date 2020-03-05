Return-Path: <SRS0=ofoM=4W=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F18C3F2D2
	for <linux-pci@archiver.kernel.org>; Thu,  5 Mar 2020 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBC520637
	for <linux-pci@archiver.kernel.org>; Thu,  5 Mar 2020 16:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eJz1LuwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgCEQhY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:37:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCEQhY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Mar 2020 11:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8336ORe+HzFZDW1N6r0A74tnlGoHSd4arD8lInbgJDY=; b=eJz1LuwA/a2j4LV6IA4ns3q8Zw
        hmU8FxtO5+mFEkuO8/qwobfDXxCKOVZ4SwD9sJ9dYt/X/BrnySR2/rd2mree0dCs1CDJUd1eKyati
        4iZ+2bkaTadEZMpOERaf0HQXYoG7RtcITaCdwnCEWDpTqBRHI0L3BJBrr2Y79kR+UNg8pUuqxUvkQ
        0AFoKthSwRaMLf3yvfwyasTRCz4+HvNmgNzJIvZN2ZR7XPcUwW/fqBkxTPljFB1nlCBgdPyZpV4tk
        F9u0U5LBKgRl7B4DKg/TVM1qLbP/HHfzlClsR5Ufr/U0jmsRVYEXvGjhZIFUFmX8NLPMdUNwtpHWy
        TJjPWOkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9tUx-00071M-Rc; Thu, 05 Mar 2020 16:37:23 +0000
Date:   Thu, 5 Mar 2020 08:37:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v16 7/9] PCI/DPC: Export DPC error recovery functions
Message-ID: <20200305163723.GB14299@infradead.org>
References: <cover.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <ef15401783b3d4f33072f8ffe84073cea178486d.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef15401783b3d4f33072f8ffe84073cea178486d.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please fix your subject.  Nothing is being exported in this patch.
