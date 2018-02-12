Return-Path: <SRS0=yRpG=FG=chelsio.com=leedom@kernel.org>
Return-Path: <SRS0=yRpG=FG=chelsio.com=leedom@kernel.org>
From: Casey Leedom <leedom@chelsio.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: Arjun V. <arjun@chelsio.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Miller
	<davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, Santosh Rastapur
	<santosh@chelsio.com>, Ganesh GR <ganeshgr@chelsio.com>, "Nirranjan
 Kirubaharan" <nirranjan@chelsio.com>, Kumar A S <kumaras@chelsio.com>, "SWise
 OGC" <swise@opengridcomputing.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [REGRESSION, bisect] pci: cxgb4 probe fails after commit
 104daa71b3961434 ("PCI: Determine actual VPD size on first access")
Date: Mon, 12 Feb 2018 18:06:50 +0000
Message-ID: <BY2PR1201MB0983BD00DFBB77041758E897C8F70@BY2PR1201MB0983.namprd12.prod.outlook.com>
References: <1516710549-26660-1-git-send-email-arjun@chelsio.com>
 <20180212174341.GC75542@bhelgaas-glaptop.roam.corp.google.com>,<CAKgT0Ucr7SZURefYtCSziNhPF_cc66tT7GzSp0u43-2tJ=Lt_A@mail.gmail.com>
In-Reply-To: <CAKgT0Ucr7SZURefYtCSziNhPF_cc66tT7GzSp0u43-2tJ=Lt_A@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

  Yes, the issue is not that random stack garbage is being copied.  It's
that the VPD Read silently returns without any error if the read exceeds th=
e
computed/set size (something I'm still not comfortable with).

  And yes, we did try to address this with kernel.org commit cb92148b where
I introduced the new pci_set_vpd_size() API.  Later, in commit 1c7de2b4ff88=
,
Alexey Kardashevskiy introduced the cxgb3 PCIe Quirk using the new
pci_set_vpd_size() API for our T3-based adapters rather than modifying the
driver code as I'd done for cxgb4.  In talking with Bjorn I think that
Alexey's approach is better and I'm going to work up a patch to do the same
for all of our adapters.

  Thanks to everyone for helping talk through this!

Casey
