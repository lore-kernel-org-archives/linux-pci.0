Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdKHRYY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 12:24:24 -0500
Date: Wed, 8 Nov 2017 09:24:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: subrahmanya l <l.subrahmanya@mobiveil.co.in>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [Patch] export irq_set_msi_desc
Message-ID: <20171108172424.GA19449@infradead.org>
References: <CAFZiPx1sgxr8X9mtW11fK1XMPuk+4jUFb5Cc-pVJn06ZztHwng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFZiPx1sgxr8X9mtW11fK1XMPuk+4jUFb5Cc-pVJn06ZztHwng@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 08, 2017 at 09:54:09PM +0530, subrahmanya l wrote:
> Few of the PCIe driver compilation fails with undefined symbol
> "irq_set_msi_desc".
> This patch is to export it.

Which ones?  Also please add an explanation of why you thing it should
be exported and Cc the irq code maintainers.
