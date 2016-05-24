Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50386 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419AbcEXN6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2016 09:58:21 -0400
From: "Levy, Amir (Jer)" <amir.jer.levy@intel.com>
To: Lukas Wunner <lukas@wunner.de>
CC: "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Jamet, Michael" <michael.jamet@intel.com>,
	"Alloun, Dan" <dan.alloun@intel.com>,
	"Westerberg, Mika" <mika.westerberg@intel.com>,
	"Svahn, Kai" <kai.svahn@intel.com>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: [PATCH 0/6] thunderbolt: Introducing Thunderbolt(TM) networking
Date: Tue, 24 May 2016 13:58:14 +0000
Message-ID: <E607265CB020454880711A6F96C05A0377FBD337@hasmsx107.ger.corp.intel.com>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
 <20160524105506.GB5396@wunner.de>
In-Reply-To: <20160524105506.GB5396@wunner.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Lukas Wunner [mailto:lukas@wunner.de]
> Sent: Tuesday, May 24, 2016 13:55
> To: Levy, Amir (Jer) <amir.jer.levy@intel.com>
> Cc: andreas.noever@gmail.com; gregkh@linuxfoundation.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; Jamet, Michael
> <michael.jamet@intel.com>; Alloun, Dan <dan.alloun@intel.com>;
> Westerberg, Mika <mika.westerberg@intel.com>; Svahn, Kai
> <kai.svahn@intel.com>; Shevchenko, Andriy
> <andriy.shevchenko@intel.com>; Winkler, Tomas
> <tomas.winkler@intel.com>
> Subject: Re: [PATCH 0/6] thunderbolt: Introducing Thunderbolt(TM)
> networking
> 
> Hi Amir,
> 
> On Mon, May 23, 2016 at 11:48:50AM +0300, Amir Levy wrote:
> > Thunderbolt(TM) networking, introduced in these patches, provides the
> > capability of connecting hosts together by emulating an Ethernet adapter.
> 
> Thank you for this contribution. I think it may take some time to review
> everything, for now just some general observations:
> 
> - Up until now this driver was Mac-only. IIUC the functionality you're
>   adding will also be used on non-Macs. That's an important change that
>   should probably be made more explicit in the commit messages. Did you
>   test your patches on a Mac to see that nothing regresses? 

Yes, we did some tests on MacBook Pro with Falcon Ridge.
Note that (as written in the cover letter), the functionality that we are adding is based on ICM (Intel Connection Manager, firmware).
These patches will keep the current functionality on Mac and will add the networking functionality on non-Macs.
 
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

