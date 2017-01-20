Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38396 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbdATOjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2017 09:39:09 -0500
Subject: Re: [PATCH V2] PCI: enable extended tags support for PCIe devices
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1484921814-8511-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1214d229-0f0c-d9fd-3d25-39a6e257a36b@codeaurora.org>
Date: Fri, 20 Jan 2017 09:36:45 -0500
MIME-Version: 1.0
In-Reply-To: <1484921814-8511-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/20/2017 9:16 AM, Sinan Kaya wrote:
> Each PCIe device can issue up to 32 transactions at a time by default.
> This limitation is historically coming from PCI. Each transaction is
> tracked by a tag number on the bus. 2.2.6.2. Transaction Descriptor
> – Transaction ID Field section of the PCIe 3.1 specification describes
> extended tags.
> 

Apologies for the spam, no idea what happened. I need to review my publish scripts.



