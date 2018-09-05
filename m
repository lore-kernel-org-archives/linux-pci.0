Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeIEHi7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 03:38:59 -0400
Subject: Re: RFC on PCI Device Lock
To: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
References: <87682473-6ffe-f7df-e8f8-3d00e8247621@kernel.org>
 <20180904165202.4e5bb59d@t450s.home>
 <3428a4e6-0095-3eb8-a6d2-c889e201ab98@intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <b85dab5a-62f0-78b0-0b7c-29af362784d9@kernel.org>
Date: Tue, 4 Sep 2018 20:10:57 -0700
MIME-Version: 1.0
In-Reply-To: <3428a4e6-0095-3eb8-a6d2-c889e201ab98@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/4/2018 7:59 PM, Dennis Dalessandro wrote:
> It sounds like all that is being done is put a band-aid on things and there is 
> some redesign work needed. Perhaps the best thing to do is back this out for 
> 4.19 and revisit with a more general solution for 4.20. That's a call for you 
> folks to make. My concern is getting our HW functioning again with 4.19 and 
> Sinan's patch along with my 1/1 seems to allow that at least.

Alex proposed another solution. That looks better IMO.
I think we can close this issue shortly. We have not exhausted bug fixing window
unless Bjorn thinks otherwise.

I'll upload another patch to bugzilla soon.
