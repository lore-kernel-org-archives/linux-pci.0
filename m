Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48172 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaJCFYN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Oct 2014 01:24:13 -0400
Message-ID: <1412313820.30859.2.camel@pasglop>
Subject: Re: [PATCH v2 3/4] sound/radeon: Move 64-bit MSI quirk from arch to
 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Fri, 03 Oct 2014 15:23:40 +1000
In-Reply-To: <CADnq5_PhuFbRPgzAa_hEA1czTQjY9xdLFOWhL393DN4CYDnFng@mail.gmail.com>
References: <1412210082.10667.2.camel@pasglop>
	 <CADnq5_PhuFbRPgzAa_hEA1czTQjY9xdLFOWhL393DN4CYDnFng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-10-01 at 22:13 -0400, Alex Deucher wrote:

> The attached updated patch only flags the affected asics.

I need formal (email :-) permission to add your s-o-b (and From: while
at it since you wrote most of it) for this patch. I'll then include
it in my new series.

Cheers,
Ben.


