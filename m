Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48203 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbcAOOSf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 09:18:35 -0500
Subject: Re: [PATCHv2 0/4] PCI VPD access fixes
To: Babu Moger <babu.moger@oracle.com>,
	"Seymour, Shane M" <shane.seymour@hpe.com>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
 <DDB9C85B850785449757F9914A034FCB4450CEC7@G9W0766.americas.hpqcorp.net>
 <5698FDF1.1060601@oracle.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5698FFB9.2000103@suse.de>
Date: Fri, 15 Jan 2016 15:18:33 +0100
MIME-Version: 1.0
In-Reply-To: <5698FDF1.1060601@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/15/2016 03:10 PM, Babu Moger wrote:
> Shane, Thank You very much..
>
> On 1/14/2016 7:07 PM, Seymour, Shane M wrote:
>> For the series. Tested with AE311 PCI-Express 4Gb Fibre Channel HBA.
>> Truncation of the vpd data returned works (154 bytes) and lspci -vvv
>> prints out the VPD tags the same way with and without the changes.
>> This card did not require any quirks it was capable of returning 32k
>> of data (although it repeated every 4k).
>> ---
>> Tested-by: Shane Seymour <shane.seymour@hpe.com>
>>
So, Alexander, are you happy with this series?
It looks as if the technical issues are resolved now ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
