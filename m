Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:29642 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdE3RnA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 May 2017 13:43:00 -0400
Date: Tue, 30 May 2017 09:31:34 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
        CQ Tang <cq.tang@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, ashok.raj@intel.com
Subject: Re: [PATCH 1/2] PCI: Save properties required to handle FLR for
 replay purposes.
Message-ID: <20170530163132.GA167511@otc-nc-03>
References: <1494441543-8216-1-git-send-email-ashok.raj@intel.com>
 <aa916e13-063f-3b25-34a5-b1a24200e021@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa916e13-063f-3b25-34a5-b1a24200e021@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 11, 2017 at 11:50:24AM +0100, Jean-Philippe Brucker wrote:
> Hi,
> 
> On 10/05/17 19:39, Ashok Raj wrote:
> > From: CQ Tang <cq.tang@intel.com>
> > 
> > Requires: https://patchwork.kernel.org/patch/9593891
> 
> Since your series is likely to go in much earlier than my SVM mess, maybe
> you could carry that PCI patch along with it? Or I could resend it on its
> own if you prefer.

I have send the 2 patches to the list, so we can get them in before the long
SVM series gets in. 



> 
> I'm planning to resend the SVM series in a few weeks but it still won't
> make it into mainline since it hasn't run on hardware.
> 
> Thanks,
> Jean-Philippe
> 
Cheers,
Ashok
