Return-Path: <SRS0=du0w=AA=8bytes.org=joro@kernel.org>
Return-Path: <SRS0=du0w=AA=8bytes.org=joro@kernel.org>
Date: Wed, 30 Aug 2017 13:44:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Samuel Sieb <samuel@sieb.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Drake <drake@endlessm.com>,
	Alexander Deucher <Alexander.Deucher@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170830114412.GH19533@8bytes.org>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170713025608.GC4486@bhelgaas-glaptop.roam.corp.google.com>
 <b1570450-1c83-1f76-ab1e-c94bd34f9b84@sieb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b1570450-1c83-1f76-ab1e-c94bd34f9b84@sieb.net>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 01:02:41PM -0700, Samuel Sieb wrote:
> On 07/12/2017 07:56 PM, Bjorn Helgaas wrote:
> >Applied with Alex's ack to pci/virtualization for v4.14, thanks!
> 
> Is there any chance of getting this into an earlier kernel?  This is a
> pretty devastating bug for users!  I'm currently providing patched kernels,
> but if they run upgrades and get a new kernel without noticing it, any
> filesystem they access will get completely mangled.

The patch is queued for v4.14, so it will probably be picked up by
distributions when v4.14-rc1 is released. At least this will be the case
for the affected (Open)SUSE distributions.


	Joerg
