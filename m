Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984Ab3KDIKw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Nov 2013 03:10:52 -0500
Date: Mon, 4 Nov 2013 09:12:39 +0100
From: Alexander Gordeev <agordeev@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ben Hutchings <bhutchings@solarflare.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Mark Lord <kernel@start.ca>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v2 12/29] PCI/MSI: Introduce pcim_enable_msi*()
 family helpers
Message-ID: <20131104081239.GA25567@dhcp-26-207.brq.redhat.com>
References: <cover.1382103786.git.agordeev@redhat.com>
 <6bc575621ef70f72b206e4aa944acd32f1a75718.1382103786.git.agordeev@redhat.com>
 <20131024105158.GB13159@mtj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131024105158.GB13159@mtj.dyndns.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 24, 2013 at 11:51:58AM +0100, Tejun Heo wrote:

Hi Tejun,

> I haven't looked into any details but, if the above works for most use
> cases, it looks really good to me.

Could you please take a look (at least) at patches 10 and 12?

> tejun

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
