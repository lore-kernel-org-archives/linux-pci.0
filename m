Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44575 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751016AbdFOOE2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 10:04:28 -0400
Date: Thu, 15 Jun 2017 16:04:21 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Samuel Sieb <samuel@sieb.net>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170615140421.GB25710@suse.de>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491575538-22694-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Fri, Apr 07, 2017 at 04:32:18PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> ATS is broken on this hardware and causes IOMMU stalls and
> system failure. Disable ATS on these devices to make them
> usable again with IOMMU enabled.
> 
> Note that the commit in the Fixes-tag is not buggy, it
> just uncovers the problem in the hardware by increasing
> the ATS-flush rate.
> 
> Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/pci/quirks.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Any more objections on this patch? Please let me know if you want to
have something changed.


Regards,

	Joerg
