Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59221 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbcDHDkR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2016 23:40:17 -0400
Subject: Re: [PATCH 2/2] pci, acpi: free IO resource during shutdown
To: Bjorn Helgaas <helgaas@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>
References: <1457389310-3538-1-git-send-email-okaya@codeaurora.org>
 <1457389310-3538-2-git-send-email-okaya@codeaurora.org>
 <20160407160624.GB8780@localhost> <57069CAF.8090803@codeaurora.org>
 <20160407214108.GB24492@localhost>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
	agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5707281B.6020805@codeaurora.org>
Date: Thu, 7 Apr 2016 23:40:11 -0400
MIME-Version: 1.0
In-Reply-To: <20160407214108.GB24492@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

On 4/7/2016 5:41 PM, Bjorn Helgaas wrote:
>>> You say this is undoing the effect of pci_remap_iospace(), but that's
>>> > > only called by native drivers and the generic (OF) driver, not by
>>> > > pci_root.c.
>> > 
>> > See the ACPI root bridge driver above.
> If this is a fix to patches that haven't been merged yet, we need to
> squash the fix into the patches.
> 

Can you merge these to two patches to your series for the next post?

I need to remove weak on the first patch per direction from Bjorn and 
fix the function comments. You could as well do this while you are merging. 

Let me know what your preference is.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
