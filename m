Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2387 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbaBNW2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 14 Feb 2014 17:28:06 -0500
Date: Fri, 14 Feb 2014 14:27:58 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Chen, Jamie" <jamie.chen@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	USB list <linux-usb@vger.kernel.org>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: EHCI host broken -- interrupts disabled
Message-ID: <20140214222758.GA7395@xanatos>
References: <CAErSpo6v-QLkthigN3HdLizCa_7QxOS+dZ61Fse2jz5KJRdh0Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1401161435350.1109-100000@iolanthe.rowland.org>
 <20140117182231.GA18421@google.com>
 <F01C6967BCFFB14E8DF7F5D2FD1053EB1A18C3@PGSMSX103.gar.corp.intel.com>
 <CAErSpo4fGBhb+pj6pTpKFTTj9rzLYzB2w-EX2ghWRYR3Cjyd9g@mail.gmail.com>
 <CAErSpo4rTHFOgUDjmrGxxFAuE-+i9y7hW+T7+xTzB7x4_72_pg@mail.gmail.com>
 <F01C6967BCFFB14E8DF7F5D2FD1053EB1ECC22@PGSMSX103.gar.corp.intel.com>
 <CAErSpo4_ecD6Gom=WnH2MMSLsO=SEBnWHKhx3BiXz3Fgs8d2uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4_ecD6Gom=WnH2MMSLsO=SEBnWHKhx3BiXz3Fgs8d2uQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 14, 2014 at 01:47:48PM -0700, Bjorn Helgaas wrote:
> On Fri, Feb 14, 2014 at 9:36 AM, Chen, Jamie <jamie.chen@intel.com> wrote:
> > Sorry for late response.
> >
> > The dmesg attach in the mail.
> 
> Thanks, I put this info in
> https://bugzilla.kernel.org/show_bug.cgi?id=70601 and applied the
> patch to pci/misc.
> 
> This seems like a potentially important fix, so I think I'll
> cherry-pick it into for-linus for v3.14.

Thanks, Bjorn!

Do you think this patch is a candidate for stable as well?  Anyone with
an EHCI-only Baytrail system won't have working USB without this patch,
and the patch itself seems relatively small.

Sarah Sharp
