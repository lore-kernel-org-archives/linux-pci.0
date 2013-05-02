Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:37595 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758558Ab3EBMge (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 May 2013 08:36:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id 4BB9212B0AF
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2013 14:36:33 +0200 (CEST)
Date: Thu, 2 May 2013 14:36:31 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jan Beulich <JBeulich@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 -tip/apic 2/2] x86/MSI: Allocate as many multiple-MSIs
 as requested
Message-ID: <20130502123631.GB24440@8bytes.org>
References: <cover.1367319112.git.agordeev@redhat.com>
 <096b258a86c1cb46e4f3084f1fbcf37c7859bb15.1367319112.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <096b258a86c1cb46e4f3084f1fbcf37c7859bb15.1367319112.git.agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 30, 2013 at 01:11:11PM +0200, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Please add a proper commit message explaining why this change is
necessary or what problem it fixes.


	Joerg


