Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36621 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbbLROCU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2015 09:02:20 -0500
MIME-Version: 1.0
In-Reply-To: <567410D3.7030909@suse.de>
References: <1450427719-29619-1-git-send-email-hare@suse.de>
	<1450427719-29619-3-git-send-email-hare@suse.de>
	<CAKgT0Uceg2CmiXu926nfAWg25pSb24UhbmNBw2noNKRNHwDMow@mail.gmail.com>
	<567410D3.7030909@suse.de>
Date: Fri, 18 Dec 2015 06:02:19 -0800
Message-ID: <CAKgT0Uc9vZGHvtUuzv4EkE2d4-U5F=22-YeSAOWBH=vGa4yJ5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: Update VPD size with correct length
From: Alexander Duyck <alexander.duyck@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Michal Kubecek <mkubecek@suse.com>,
	"Shane M. Seymour" <shane.seymour@hpe.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 18, 2015 at 5:57 AM, Hannes Reinecke <hare@suse.de> wrote:
> On 12/18/2015 02:49 PM, Alexander Duyck wrote:
>>
>> On Fri, Dec 18, 2015 at 12:35 AM, Hannes Reinecke <hare@suse.de> wrote:
>>>
>>> PCI-2.2 VPD entries have a maximum size of 32k, but might actually
>>> be smaller than that. To figure out the actual size one has to read
>>> the VPD area until the 'end marker' is reached.
>>> Trying to read VPD data beyond that marker results in 'interesting'
>>> effects, from simple read errors to crashing the card. And to make
>>> matters worse not every PCI card implements this properly, leaving
>>> us with no 'end' marker or even completely invalid data.
>>> This path modifies the size of the VPD attribute to the available
>>> size, or set it to '0' if no valid data could be read.
>>
>>
>> This isn't what I had in mind.  There is no need to add an f0 version
>> of the size function.  The size for all functions other than function
>> 0 when the F0 flag is set is 0.  We aren't going to be reading their
>> VPD, we only read the VPD region of function 0.
>>
> Ah. (I'm a bit confused about the proposed action for VPD other than
> function 0).
> So the idea here is to _disallow_ access to VPDs from functions other than
> '0' unless these functions have different PCI IDs?

If you take a look at the F0 functions what they do is bypass the VPD
of the functions other than function 0.  As such setting the size to 0
should really have no effect since the VPD of the function isn't
actually read if the F0 flag is set.

- Alex
