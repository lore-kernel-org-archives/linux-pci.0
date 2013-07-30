Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:57540 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab3G3LxD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Jul 2013 07:53:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id 41C4E12B21E
	for <linux-pci@vger.kernel.org>; Tue, 30 Jul 2013 13:53:01 +0200 (CEST)
Date: Tue, 30 Jul 2013 13:52:59 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	stephen@networkplumber.org, linux-pci@vger.kernel.org,
	ddutile@redhat.com
Subject: Re: [PATCH v2 0/2] iommu/intel: Quirk non-compliant PCIe-to-PCI
 bridges
Message-ID: <20130730115259.GL28811@8bytes.org>
References: <20130528183527.3318.5365.stgit@bling.home>
 <1373303240.2602.28.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373303240.2602.28.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(sorry for the delay)

On Mon, Jul 08, 2013 at 11:07:20AM -0600, Alex Williamson wrote:
> Where do we stand on this series?  You had a concern that the heuristic
> used in patch 1/ could be dangerous.  The suggestion for detecting the
> issue was actually from Bjorn who replied with his rationale.  Do you
> want to go in the direction of a fixed whitelist or do you agree that
> even if the heuristic breaks it provides better behavior than what we
> have now?  Thanks,

So if this workaround should still live in the IOMMU code (after your
discussion with Bjorn) you can either convince me that the heuristic
will never fail or you resend a version that uses a list of known to be
broken bridges to match against.


	Joerg


