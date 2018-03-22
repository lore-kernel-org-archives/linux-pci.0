Return-Path: <SRS0=oZA6=GM=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=oZA6=GM=kernel.crashing.org=benh@kernel.org>
Message-ID: <1521756164.16434.319.camel@kernel.crashing.org>
Subject: Re: PCIe resets/restore and lack of CRS wait
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michael
	Neuling <michael.neuling@au1.ibm.com>,
        linux-pci-owner@vger.kernel.org
Date: Fri, 23 Mar 2018 09:02:44 +1100
In-Reply-To: <6aec45f1-74d9-d36f-7169-0c91733985e3@codeaurora.org>
References: <1521691380.16434.287.camel@kernel.crashing.org>
	 <f6af9b6e424c469f433735a106b8ee69@codeaurora.org>
	 <1521695531.16434.294.camel@kernel.crashing.org>
	 <1521699853.16434.301.camel@kernel.crashing.org>
	 <4d1c04efa51db50dd5095ae258c3c52b@codeaurora.org>
	 <1521726371.16434.307.camel@kernel.crashing.org>
	 <172f0ea9-7eba-1505-bb79-1ee31cc4d692@codeaurora.org>
	 <20180322141402.GA242245@bhelgaas-glaptop.roam.corp.google.com>
	 <6aec45f1-74d9-d36f-7169-0c91733985e3@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-03-22 at 12:54 -0500, Sinan Kaya wrote:
> Ben,
> 
> On 3/22/2018 9:14 AM, Bjorn Helgaas wrote:
> > CRS SV is optional, so the code has to work when it's absent.  But we
> > can tell whether it's supported, so if we need to, we can do something
> > different when it's absent.
> 
> Let us know if you want to work on this or not. Otherwise, I'll add
> to the list of things I'm doing.

On my side (powerpc) I'll make sure we do get ffff's and that our retry
timeouts aren't too high. I just need to makes sure we don't end up
triggering an EEH failure on the timeout though.

Cheers,
Ben.
