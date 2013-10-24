Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:55290 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754496Ab3JXK7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Oct 2013 06:59:42 -0400
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 24662-09 for <linux-pci@vger.kernel.org>;
 Thu, 24 Oct 2013 11:59:39 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH RFC v2 12/29] PCI/MSI: Introduce pcim_enable_msi*() family helpers
Date: Thu, 24 Oct 2013 11:57:40 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B73AA@saturn3.aculab.com>
In-Reply-To: <20131024105158.GB13159@mtj.dyndns.org>
References: <cover.1382103786.git.agordeev@redhat.com> <6bc575621ef70f72b206e4aa944acd32f1a75718.1382103786.git.agordeev@redhat.com> <20131024105158.GB13159@mtj.dyndns.org>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Tejun Heo" <tj@kernel.org>,
	"Alexander Gordeev" <agordeev@redhat.com>
Cc: <linux-kernel@vger.kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Michael Ellerman" <michael@ellerman.id.au>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Ben Hutchings" <bhutchings@solarflare.com>,
	"Mark Lord" <kernel@start.ca>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > ...would turn into a single helper call....
> >
> > 	rc = pcim_enable_msix_range(adapter->pdev,
> > 				    adapter->msix_entries,
> > 				    nvec,
> > 				    FOO_DRIVER_MINIMUM_NVEC);
> 
> I haven't looked into any details but, if the above works for most use
> cases, it looks really good to me.

The one case it doesn't work is where the driver either
wants the full number or the minimum number - but not
a value in between.

Might be worth adding an extra parameter so that this
(and maybe other) odd requirements can be met.

Some static inline functions could be used for the common cases.

	David



