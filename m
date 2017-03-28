Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33654 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdC1QYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2017 12:24:37 -0400
Subject: Re: [PATCH 5/5] PCI: remove pci_enable_msix
To: Christoph Hellwig <hch@lst.de>
References: <20170327082936.6830-1-hch@lst.de>
 <20170327082936.6830-6-hch@lst.de>
 <83f97789-0817-7549-bfa9-1f8dcb0c26d9@gmail.com>
 <20170327171148.GB28815@lst.de>
 <1eaa46ad-9890-c738-3a85-6468161284ba@gmail.com>
 <20170328064148.GA20271@lst.de>
Cc: bhelgaas@google.com, davem@davemloft.net,
        netanel@annapurnalabs.com, jcliburn@gmail.com,
        chris.snook@gmail.com, sgoutham@cavium.com, rric@kernel.org,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org
From: David Daney <ddaney.cavm@gmail.com>
Message-ID: <217ae0b0-1d0c-bde9-e3f1-c52cbd3bd112@gmail.com>
Date: Tue, 28 Mar 2017 09:24:15 -0700
MIME-Version: 1.0
In-Reply-To: <20170328064148.GA20271@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/27/2017 11:41 PM, Christoph Hellwig wrote:
> On Mon, Mar 27, 2017 at 10:30:46AM -0700, David Daney wrote:
>>> Use pci_enable_msix_{exact,range} for now, as I told you before.
>>>
>>
>> That still results in twice as many MSI-X being provisioned than are needed.
>
> How so?  Except for the return value, a pci_enable_msix_exact call with the
> same arguments as your previous pci_enable_msix will work exactly the
> same.
>

Sorry, I think it was my misunderstanding.  I didn't realize that we had 
essentially renamed the function, but left the functionality mostly 
unchanged.
