Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19828 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdCNPmO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Mar 2017 11:42:14 -0400
Date: Tue, 14 Mar 2017 08:41:55 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <andi@firstfloor.org>, bhelgaas@google.com,
        x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86, pci: Add interface to force mmconfig
Message-ID: <20170314154155.GG32070@tassilo.jf.intel.com>
References: <20170302232104.10136-1-andi@firstfloor.org>
 <20170302232104.10136-3-andi@firstfloor.org>
 <alpine.DEB.2.20.1703141407090.3619@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1703141407090.3619@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> And the way how this function is used is a horrible hack. It's called from
> a random driver at some random point in time.
> 
> The proper solution is to identify the bus at the point where the bus is
> discovered and switch it to mmconfig if possible.

But how would you know that it is safe?
AFAIK the only one who knows "this is an internal SOC device" is the driver.

Or are you saying it should be enabled unconditionally for everything?
Or define some quirk table just for this purpose?

-Andi
