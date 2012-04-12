Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:55255 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934407Ab2DLQ1y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2012 12:27:54 -0400
From: Steven Newbury <steve@snewbury.org.uk>
Reply-To: Steven Newbury <steve@snewbury.org.uk>
To: Yinghai Lu <yinghai@kernel.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity>
	 <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
	 <4F84110E.3000400@snewbury.org.uk>
	 <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
	 <4F8467AA.90305@snewbury.org.uk>
	 <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
	 <4F848357.3060007@snewbury.org.uk>
	 <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
	 <4F848E10.1090703@snewbury.org.uk>
	 <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
	 <1334089568.4083.2.camel@Nokia-N900>
	 <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
	 <4F84A3EC.6030903@snewbury.org.uk>
	 <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>
	  <1334229754.30606.7.camel@Nokia-N900>
In-Reply-To: <1334229754.30606.7.camel@Nokia-N900>
Content-Type: text/plain; charset=utf-8
Date: Thu, 12 Apr 2012 17:29:43 +0100
Message-Id: <1334248183.2910.3.camel@Nokia-N900>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 12 Apr 2012, 12:22:34 BST, Steven Newbury <steve@snewbury.org.uk> wrote:
> I've attempted to modify probe.c to disable 64-bit BARs not allocated
> above 4G so they get reallocated above when possible later.   It seemed
> to work, but again broke GMA despite the BAR originally containing an
> invalid address as mentioned above, it seems for some reason something
> is different when the conflict is detected and rellocated, compared to
> disabling it early then allocating a valid value..?
I understand now why it didn't work.  Memory decoding was enabled in the GMA device.  When it's detected as in conflict with system RAM it gets reallocated cleanly, but setting the BAR to 0 prevents that from happening.  Somehow I need to get the resources I want moved onto a realloc list, but I can't work out where or how...
