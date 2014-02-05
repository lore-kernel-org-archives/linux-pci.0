Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <52F20388.9080109@codethink.co.uk>
Date: Wed, 05 Feb 2014 09:25:28 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
MIME-Version: 1.0
To: Magnus Damm <magnus.damm@gmail.com>
CC: linux-pci@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	"Simon Horman [Horms]" <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 00/04] PCI: rcar: Driver model and physical address space
 update
References: <20140205065243.29445.76593.sendpatchset@w520> <52F1F74C.2090106@codethink.co.uk> <CANqRtoRMAjBEXjBzivPxqMu8KhFsOkp0wb6jBbuZQx=B-qYuUA@mail.gmail.com>
In-Reply-To: <CANqRtoRMAjBEXjBzivPxqMu8KhFsOkp0wb6jBbuZQx=B-qYuUA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/02/14 09:00, Magnus Damm wrote:
> Hi Ben,

[snip]
> I think we should try to pick out the stuff that is ready to be merged
> first. I think these patches may require a bit of time before people
> start looking at them. I don't mind resending in the future.
>
> To be honest, I have not been paying too much attention to other
> patches including yours - been focused trying to get the memory
> management part right.. So I'd like to focus on correctness over DT
> for now if possible. Of course we it all.
>
> Would it be possible for you to provide a list of pci-rcar-gen2.c
> patches that you posted? Or perhaps you can resend your series and
> include acks that you received?

I don't think I have any acks, only review comments. I think the code
itself is pretty much ready to be merged and has been tested here with
the Lager board.

The big issue for us is that we /must/ boot with fdt, which means the
less fdt support that is in the kernel then the more patches we end up
carrying out of tree. This is why we have been pushing patches out to
try and get the support in.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
