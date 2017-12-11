Return-Path: <SRS0=VEcB=DH=googlemail.com=chris2553@kernel.org>
Return-Path: <SRS0=VEcB=DH=googlemail.com=chris2553@kernel.org>
Subject: Re: Oops on 4.15-rc[123] on shutdown/reboot
To: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, bhelgaas@google.com,
 linux-pci@vger.kernel.org
References: <1d802670-2d50-dd05-1205-561b0c025845@googlemail.com>
 <32fa4f94-8f36-0321-81fd-f9ccb91c2a1f@codeaurora.org>
 <20171211171751.GB16032@bhelgaas-glaptop.roam.corp.google.com>
From: Chris Clayton <chris2553@googlemail.com>
Message-ID: <e12d2b7c-6297-0053-997a-057126f74979@googlemail.com>
Date: Mon, 11 Dec 2017 20:04:27 +0000
MIME-Version: 1.0
In-Reply-To: <20171211171751.GB16032@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/12/17 17:17, Bjorn Helgaas wrote:
> [+cc linux-pci]
> 
> On Mon, Dec 11, 2017 at 11:29:50AM -0500, Sinan Kaya wrote:
>> Hi Chris,
>>
>>>
>>> I'm more than happy to provide additional diagnostics and test proposed fixes. As a starter for ten, I've attached the
>>> output from 'lspci -v'. If, however, you need to see the backtrace, I'll need some advice on how to capture that.
>>>
>>
>> Can you open a bugzilla and also share the boot log?
>>
>> There must be something unique about your system.
> 
> Can you attach "lspci -vv" output (as root) to the bugzilla, too?
> 

I've opened the bugzilla report (Bug 198141) and attached the dmesg and lspci -vv outputs to it.
