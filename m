Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Message-ID: <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Mon, 20 Aug 2018 15:33:16 +1000
In-Reply-To: <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
	 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
	 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
	 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
	 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
	 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
	 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
	 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
	 <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
	 <fe891b63-12c7-61ab-a59a-ae24ad766754@kernel.org>
	 <ab5cb5b277f1c1c1362ef597ca7b8c6a2cd32cdf.camel@kernel.crashing.org>
	 <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-08-20 at 10:49 +0530, poza@codeaurora.org wrote:
> 
> Reverting spec/Documentation which is fine by me.
> 
> But the good thing has happened now is; we can have very clear 
> definition for the framework to go forward.
> e.g. how the errors have to be handled.
> 
> Because of those patches, the whole error framework is under common code 
> base and now has become independent of service e.g. AER, DPC etc..

Well, EEH isn't yet :-) But then the EEH code is a real mess buried in
arch/powerpc. Sam (CC) is trying to improve that situation and I might
step in as well to help if we think we can make things more common, it
would definitely help.

> That enables us to define or extend policies in more clearly defined way 
> irrespective of what services are running.
> 
> Now it is just that we have to change in err.c and walk away with the 
> policies what we want to enforce.
> 
> let me know how this sounds Ben.

So for now, I've sent a revert patch for the Documentation/ bit to
Bjorn, and I have no (not yet at least) beef in what you do in
drivers/pci/* ... however, that said, I think it would be great to move
EEH toward having a bulk of the policy use common code as well.

It will be long road, in part due to the historical crappyness of our
EEH code, so my thinking is we should:

 - First agree on what we want the policy to be. I need to read a bit
more about DPC since that's new to me, it seems to be similar to what
our EEH does, with slighty less granularity (we can freeze access to
individual functions for example).

 - Rework err.c to implement that policy with the existing AER and DPC
code.

 - Figure out what hooks might be needed to be able to plumb EEH into
it, possibly removing a bunch of crap in arch/powerpc (yay !)

I don't think having a webex will be that practical with the timezones
involved. I'm trying to get approval to go to Plumbers in which case we
could setup a BOF but I have no guarantee at this point that I can make
it happen.

So let's try using email as much possible for now.

Cheers,
Ben.
