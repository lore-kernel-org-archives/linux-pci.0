Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Aug 2012 12:50:10 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: <dwmw2@infradead.org>, <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dsahern@gmail.com>
Subject: Re: [PATCH 0/2] Fix ACS path checking
Message-ID: <20120806105010.GK1996@amd.com>
References: <20120804180155.6144.83332.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20120804180155.6144.83332.stgit@bling.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 04, 2012 at 12:08:46PM -0600, Alex Williamson wrote:
> Joerg, I notice that ACS isn't getting enabled on my AMD system on
> 3.6-rc1.  I'll investigate more, but mention it in case you get to
> it first.

Hmm, tried it here, At least pci_request_acs() still gets called. How do
you detect if ACS is really enabled?

Regards,

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

