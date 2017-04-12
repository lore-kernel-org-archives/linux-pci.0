Return-Path: <SRS0=2pf2=3U=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=2pf2=3U=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20170411043204.19343-1-christophe.jaillet@wanadoo.fr>
 <20170412172736.GF25197@bhelgaas-glaptop.roam.corp.google.com>
Cc: kurt.schwemmer@microsemi.com, stephen.bates@microsemi.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <eb5a4cbf-4059-6ef1-5a3c-83327442312b@deltatee.com>
Date: Wed, 12 Apr 2017 11:28:12 -0600
MIME-Version: 1.0
In-Reply-To: <20170412172736.GF25197@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH] switchtec: Fix an error handling
List-ID: <linux-pci.vger.kernel.org>



On 12/04/17 11:27 AM, Bjorn Helgaas wrote:
> On Tue, Apr 11, 2017 at 06:32:04AM +0200, Christophe JAILLET wrote:
>> 'stuser_create' returns an error pointer in case of error, not NULL.
>> So test its return value with IS_ERR.
>>
>> Fixes: 74004262f329 ("MicroSemi Switchtec management interface driver")
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Since this hasn't been merged to Linus' tree yet, I folded the fix
> into the original commit on pci/switchtec and added attribution to
> Christophe.

Thanks Bjorn.

Logan
