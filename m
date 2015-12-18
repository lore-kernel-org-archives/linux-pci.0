Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59712 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387AbbLRN5m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Dec 2015 08:57:42 -0500
Subject: Re: [PATCH 2/2] pci: Update VPD size with correct length
To: Alexander Duyck <alexander.duyck@gmail.com>
References: <1450427719-29619-1-git-send-email-hare@suse.de>
 <1450427719-29619-3-git-send-email-hare@suse.de>
 <CAKgT0Uceg2CmiXu926nfAWg25pSb24UhbmNBw2noNKRNHwDMow@mail.gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Michal Kubecek <mkubecek@suse.com>,
	"Shane M. Seymour" <shane.seymour@hpe.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <567410D3.7030909@suse.de>
Date: Fri, 18 Dec 2015 14:57:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uceg2CmiXu926nfAWg25pSb24UhbmNBw2noNKRNHwDMow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/18/2015 02:49 PM, Alexander Duyck wrote:
> On Fri, Dec 18, 2015 at 12:35 AM, Hannes Reinecke <hare@suse.de> wrote:
>> PCI-2.2 VPD entries have a maximum size of 32k, but might actually
>> be smaller than that. To figure out the actual size one has to read
>> the VPD area until the 'end marker' is reached.
>> Trying to read VPD data beyond that marker results in 'interesting'
>> effects, from simple read errors to crashing the card. And to make
>> matters worse not every PCI card implements this properly, leaving
>> us with no 'end' marker or even completely invalid data.
>> This path modifies the size of the VPD attribute to the available
>> size, or set it to '0' if no valid data could be read.
>
> This isn't what I had in mind.  There is no need to add an f0 version
> of the size function.  The size for all functions other than function
> 0 when the F0 flag is set is 0.  We aren't going to be reading their
> VPD, we only read the VPD region of function 0.
>
Ah. (I'm a bit confused about the proposed action for VPD other than 
function 0).
So the idea here is to _disallow_ access to VPDs from functions 
other than '0' unless these functions have different PCI IDs?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
