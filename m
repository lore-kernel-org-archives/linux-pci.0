Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:9739 "EHLO
	VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab1KIJ71 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2011 04:59:27 -0500
Date: Wed, 9 Nov 2011 10:59:02 +0100
From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] pci: More PRI/PASID cleanup
Message-ID: <20111109095902.GB13213@amd.com>
References: <20111103034359.10286.19062.stgit@bling.home>
 <20111108162826.GD5182@amd.com>
 <1320770670.19116.23.camel@bling.home>
 <20111108171725.GE5182@amd.com>
 <1320773518.19116.30.camel@bling.home>
 <20111108175410.GH5182@amd.com>
 <1320776406.19116.42.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1320776406.19116.42.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 08, 2011 at 11:20:06AM -0700, Alex Williamson wrote:

> My guess is that someone asked why a device would ever expose this table
> if it didn't support enable as a capability.  So, I wouldn't be
> surprised if your hardware sets it, but it's probably just as safe to
> assume enable is supported if the PASID table exists.

That is probably true. I suggest that you split the functional change
out of the patch and do only the renaming. I look over the code again
then and change it in a way that works with reality and the spec. Does
that work for you?


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

