Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:57269 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752106AbcLVFy6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Dec 2016 00:54:58 -0500
Subject: Re: [PATCH] pci: add kernel config option for disabling common PCI
 quirks
To: Christoph Hellwig <hch@infradead.org>
References: <1482306784-29224-1-git-send-email-john@phrozen.org>
 <20161221122213.GA32563@infradead.org>
 <8630ec3a-9424-653c-7c7a-d88554011151@phrozen.org>
 <20161221142607.GA8594@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>
From: John Crispin <john@phrozen.org>
Message-ID: <dba6a1d8-d1d6-581e-8a1b-7988ff2577e0@phrozen.org>
Date: Thu, 22 Dec 2016 06:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <20161221142607.GA8594@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 21/12/2016 15:26, Christoph Hellwig wrote:
> On Wed, Dec 21, 2016 at 02:11:25PM +0100, John Crispin wrote:
>> I can turn it into an enable patch that is selected by default.
>>
>> The current patch disables all those quirks that are used for x86/PC
>> style machines and hence are not required in the embedded world.
> 
> Maybe we'll just need to reorganize the quirks so that most of them
> arch in arch code or the affected drivers?
> 

Hi Christoph

to be honest i have no opinion on this. I am currently trying to reduce
the amount of patches that we have inside the LEDE tree. the patches
were written by other people and then dumped on us. obviously i am
interested to get this upstream with the least amount of effort. I am
quite aware though that some patches will need an overhaul to be
applicable for upstream. its not really my call if it is enough to make
this an enable patch and review the quirks enabled by it or if the code
needs to be moved.

	John
