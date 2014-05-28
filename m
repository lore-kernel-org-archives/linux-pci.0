Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62764 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbaE1I4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 May 2014 04:56:22 -0400
Date: Wed, 28 May 2014 10:57:23 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] rapidio/tsi721: Use pci_enable_msix_exact()
 instead of pci_enable_msix()
Message-ID: <20140528085722.GA12566@dhcp-26-207.brq.redhat.com>
References: <1399993292-31692-1-git-send-email-agordeev@redhat.com>
 <20140527231950.GI11907@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140527231950.GI11907@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 27, 2014 at 05:19:50PM -0600, Bjorn Helgaas wrote:
> I assume this is being handled by Matt and/or Alexandre (listed in
> MAINTAINERS).  Let me know if I should do anything.

Hi Bjorn,

No worries, the patch is in Andrew's tree already.

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
