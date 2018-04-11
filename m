Return-Path: <SRS0=1PPZ=HA=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=1PPZ=HA=linuxfoundation.org=gregkh@kernel.org>
Date: Wed, 11 Apr 2018 16:19:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	sulrich@codeaurora.org, timur@codeaurora.org,
	linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: quirk HT1100 & HT2000 and one HT2100 Root Ports for
 Extended Tags
Message-ID: <20180411141922.GA13832@kroah.com>
References: <1522882209-9743-1-git-send-email-okaya@codeaurora.org>
 <20180410194144.GD54986@bhelgaas-glaptop.roam.corp.google.com>
 <20180410195008.GE54986@bhelgaas-glaptop.roam.corp.google.com>
 <1c94361d-7a8d-ad18-12e5-1612326a54db@codeaurora.org>
 <20180411135151.GB91792@bhelgaas-glaptop.roam.corp.google.com>
 <ecdad8f4-6996-cfe0-d005-fbc67ba3cd79@codeaurora.org>
 <20180411140849.GA12557@kroah.com>
 <1290e3d3-e7f0-a4f5-925d-2b7c2cb42b93@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290e3d3-e7f0-a4f5-925d-2b7c2cb42b93@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 11, 2018 at 10:13:11AM -0400, Sinan Kaya wrote:
> On 4/11/2018 10:08 AM, Greg Kroah-Hartman wrote:
> >>> So I added these stable tags:
> >>>
> >>>   CC: stable@vger.kernel.org      # v4.11: 62ce94a7a5a5 PCI: Mark Broadcom HT2100 Root Port Extended Tags as broken
> >>>   CC: stable@vger.kernel.org      # v4.11
> >>>
> >>> I'm not sure I'm using the stable request correctly, but my intent is:
> 
> Asking if we placed the tags correctly. Sounds like we did.
> 
> >>>
> >>>   - 62ce94a7a5a5 appeared in v4.14, so cherry-pick 62ce94a7a5a5 to
> >>>     v4.11 through v4.13
> >>>   - cherry-pick *this* patch on top of 62ce94a7a5a5 to v4.11 and later
> > Bjorn is correct here, why are you dragging me into this?
> 
> Thanks

Next time explicitly ask the question, don't expect someone to rummage
through an email to determine what you are thinking.  You are being lazy
by just adding someone else to an email thread like this, be considerate
and take the time to explain yourself when asking someone else to do
work.

greg k-h
