Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614E6C19F2A
	for <linux-pci@archiver.kernel.org>; Thu, 11 Aug 2022 09:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiHKJW3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Aug 2022 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiHKJW1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 05:22:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41192F4E;
        Thu, 11 Aug 2022 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Av/sl3RYGfVTVnASuzngq2vW0HKaWzdzZVdoC4iju1o=; b=zmIcNbPOdoVK4VUnjAlxmBUYLa
        cfEaf9PdNaqDlci0o2g5QLa0iJUCwlbNeyvOdeu61a/hYAU28gqhKmTQWUstp+/JPzBofSYeIb8yQ
        HiyKlpu/IQ9OWTSm3neFn128CyoxtQmQ9exKBCI0SJD8B+zJ3j+IKkYziwEYM0NKKVb+6qGU9Dg9k
        xCEYkxRH4FtZjVHGTNTSX+zao8mqg9ksSe7JR3wbvZR5u9YcgNbirfRTLj8TdkRw8aWXofFzMJZ1L
        UjiqIyZVI7NgV5w/NZxiXw9xB8SNedtmjH5Vd8+5u4vyQu6qpyYBpTGLBx5put/u5Z1ovyOdTOSpm
        iIWEb/3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oM4OS-00AiVz-A8; Thu, 11 Aug 2022 09:22:20 +0000
Date:   Thu, 11 Aug 2022 02:22:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: dwc: add support for 64-bit MSI target
 address
Message-ID: <YvTKTCABejYZERnh@infradead.org>
References: <20220809180051.1063653-1-willmcvicker@google.com>
 <20220809180051.1063653-3-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809180051.1063653-3-willmcvicker@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 09, 2022 at 06:00:50PM +0000, Will McVicker wrote:
> +	bool msi_64b = false;

Spellt out bit here?

> +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> +		msi_64b = msi_capabilities & PCI_MSI_FLAGS_64BIT ? true : false;

No need for the tenary operator here:

		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
