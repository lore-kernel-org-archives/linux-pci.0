Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:41171 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756132AbcLUNL3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Dec 2016 08:11:29 -0500
Subject: Re: [PATCH] pci: add kernel config option for disabling common PCI
 quirks
To: Christoph Hellwig <hch@infradead.org>
References: <1482306784-29224-1-git-send-email-john@phrozen.org>
 <20161221122213.GA32563@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>
From: John Crispin <john@phrozen.org>
Message-ID: <8630ec3a-9424-653c-7c7a-d88554011151@phrozen.org>
Date: Wed, 21 Dec 2016 14:11:25 +0100
MIME-Version: 1.0
In-Reply-To: <20161221122213.GA32563@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 21/12/2016 13:22, Christoph Hellwig wrote:
> On Wed, Dec 21, 2016 at 08:53:04AM +0100, John Crispin wrote:
>> This patch has been lingering inside the OpenWrt for some years. I am not
>> sure if this is the best way to remove the quirks from the build. Let me
>> know if you prefer a different way of solving this.
> 
> As a start negative options (_DISABLE_) are very confusing, I would
> recommend to turn this into a postive option with a default y.
> 
> On what grounds did you decide which quirks to keep and which to
> remove?
> 

Hi Christoph,

I can turn it into an enable patch that is selected by default.

The current patch disables all those quirks that are used for x86/PC
style machines and hence are not required in the embedded world.

	John
