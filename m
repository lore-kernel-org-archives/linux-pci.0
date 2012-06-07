Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andi Kleen <andi@firstfloor.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Garrett <mjg@redhat.com>, Khalid Aziz <khalid.aziz@hp.com>,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] Disable Bus Master on PCI device shutdown
References: <20120427190033.GA17588@ldl.usa.hp.com>
	<20120606135009.GB1517@srcf.ucam.org>
	<20120606215034.257d7549@pyramind.ukuu.org.uk>
Date: Thu, 07 Jun 2012 10:07:29 -0700
In-Reply-To: <20120606215034.257d7549@pyramind.ukuu.org.uk> (Alan Cox's
	message of "Wed, 6 Jun 2012 21:50:34 +0100")
Message-ID: <m21ulrjbji.fsf@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> This protects against the case where a piece of hardware is continuing 
>> to DMA even after the driver shutdown method has been called? I'm not 
>
> It doesn't. We also have hardware which craps itself if you clear the bus
> mastering bit and we have platforms where the BIOS gets most upset if you
> do that on suspend paths. There are also lots of devices that simply
> ignore the bus mastering bit !

But it also makes my system do kexec successfully for the first time.

Maybe can make it an option.

n-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
