Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:54712 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeECNfC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 May 2018 09:35:02 -0400
Date: Thu, 3 May 2018 15:35:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gil Kupfer <gilkup@gmail.com>
Cc: dwmw2@infradead.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Gil Kupfer <gilkup@cs.technion.ac.il>
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
Message-ID: <20180503133459.waawna3ebtu3udn6@8bytes.org>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 29, 2018 at 09:16:48PM +0300, Gil Kupfer wrote:
> This patch adds noats option to the pci boot parameter.
> When noats is selected, all ATS related functions fail immediately and
> the IOMMU is configured to not use device-iotlb.
> 
> Any function that checks for ATS capabilities directly against the
> devices should also check this flag. (Currently, such functions exist
> only in IOMMU drivers, and they are covered by this patch.)
> 
> The motivation behind this patch is the existence of malicious devices.
> Lots of research has been done about how to utilitize the IOMMU as a
> protection from such devices. When ATS is supported, any I/O device can
> access any physical access by faking device-IOTLB entries.
> Adding the ability to ignore these entries lets sysadmins enhance system
> security.
> 
> Signed-off-by: Gil Kupfer <gilkup@cs.technion.ac.il>

This has also been on my list, thanks for doing that.

Acked-by: Joerg Roedel <jroedel@suse.de>
