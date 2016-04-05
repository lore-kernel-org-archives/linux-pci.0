Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0148.outbound.protection.outlook.com ([65.55.169.148]:37077
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933626AbcDEU3b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2016 16:29:31 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Hadden Hoppert <haddenh@microsoft.com>
Subject: RE: [PATCH v4 3/7] drivers:hv: Use new vmbus_mmio_free() from client
 drivers.
Date: Tue, 5 Apr 2016 20:13:28 +0000
Message-ID: <DM2PR0301MB1232E1739F8668D40B1F0F13AB9E0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <y> <1459558067-1725-1-git-send-email-jakeo@microsoft.com>
 <1459558067-1725-4-git-send-email-jakeo@microsoft.com>
 <20160405175949.GA15353@localhost>
In-Reply-To: <20160405175949.GA15353@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, April 5, 2016 11:00 AM
> To: Jake Oshins <jakeo@microsoft.com>
> Cc: linux-pci@vger.kernel.org; gregkh@linuxfoundation.org; KY Srinivasan
> <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; Haiyang Zhang <haiyangz@microsoft.com>; Hadden
> Hoppert <haddenh@microsoft.com>
> Subject: Re: [PATCH v4 3/7] drivers:hv: Use new vmbus_mmio_free() from
> client drivers.
> 
> Hi Jake,
> 
> On Fri, Apr 01, 2016 at 05:47:43PM -0700, Jake Oshins wrote:
> > This patch modifies all the callers of vmbus_mmio_allocate()
> > to call vmbus_mmio_free() instead of release_mem_region().
> 
> This changelog merely restates the C code.  Presumably there's some
> important difference between release_mem_region() and
> vmbus_mmio_free(), and we need a hint about what that is.
> 
> Oh, I see, there actually is no difference *yet*, but it's coming.
> I'd combine this with patch 2.  Then the patch is obviously correct
> all by itself, and the changelog for patch 2 makes clear what's
> happening.
> 
> In changelogs, don't bother with "this patch does" or "this function
> is introduced."  The context is obvious because the changelog is part
> of the commit.  Write imperative sentences, e.g., "Call
> vmbus_mmio_free() instead of release_mem_region()."
> 

Will do.  Thanks.

-- Jake Oshins

