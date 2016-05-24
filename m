Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60384 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504AbcEXJy5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2016 05:54:57 -0400
From: "Levy, Amir (Jer)" <amir.jer.levy@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Jamet, Michael" <michael.jamet@intel.com>,
	"Alloun, Dan" <dan.alloun@intel.com>,
	"Westerberg, Mika" <mika.westerberg@intel.com>,
	"Svahn, Kai" <kai.svahn@intel.com>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: [PATCH 6/6] thunderbolt: Networking doc
Date: Tue, 24 May 2016 09:54:53 +0000
Message-ID: <E607265CB020454880711A6F96C05A0377FBC697@hasmsx107.ger.corp.intel.com>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
 <1463993336-2750-7-git-send-email-amir.jer.levy@intel.com>
 <20160523153402.GA30137@kroah.com>
In-Reply-To: <20160523153402.GA30137@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Monday, May 23, 2016 18:34
> To: Levy, Amir (Jer) <amir.jer.levy@intel.com>
> Cc: andreas.noever@gmail.com; bhelgaas@google.com; linux-
> pci@vger.kernel.org; Jamet, Michael <michael.jamet@intel.com>; Alloun,
> Dan <dan.alloun@intel.com>; Westerberg, Mika
> <mika.westerberg@intel.com>; Svahn, Kai <kai.svahn@intel.com>;
> Shevchenko, Andriy <andriy.shevchenko@intel.com>; Winkler, Tomas
> <tomas.winkler@intel.com>
> Subject: Re: [PATCH 6/6] thunderbolt: Networking doc
> 
> On Mon, May 23, 2016 at 11:48:56AM +0300, Amir Levy wrote:
> > Adding Thunderbolt(TM) networking documentation.
> >
> > Signed-off-by: Amir Levy <amir.jer.levy@intel.com>
> > Signed-off-by: Michael Jamet <michael.jamet@intel.com>
> > ---
> >  Documentation/00-INDEX        |   2 +
> >  Documentation/thunderbolt.txt | 135
> > ++++++++++++++++++++++++++++++++++++++++++
> 
> This is networking with thunderbolt, you might want to name the
> documentation file to reflect that otherwise people are going to think this is
> describing all thunderbolt support in the kernel.
> 
> thanks,
> 
> greg k-h

OK, I'll rename it.
Our plan after this patch series is to provide more thunderbolt features that aren't related to networking.

Thanks,
Amir
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

