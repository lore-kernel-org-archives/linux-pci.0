Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: Alexander Gordeev <agordeev@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: infinipath <infinipath@intel.com>,
	Roland Dreier <roland@kernel.org>,
	"Hefty, Sean" <sean.hefty@intel.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 2/2] qib: Use pci_enable_msix_range() instead of
 pci_enable_msix()
Date: Tue, 18 Feb 2014 16:52:14 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC211F5860@FMSMSX107.amr.corp.intel.com>
References: <cover.1392733151.git.agordeev@redhat.com>
 <f0eabd77b96e0d679ce6c2e2e544c73063c508ee.1392733151.git.agordeev@redhat.com>
In-Reply-To: <f0eabd77b96e0d679ce6c2e2e544c73063c508ee.1392733151.git.agordeev@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: [PATCH 2/2] qib: Use pci_enable_msix_range() instead of
> pci_enable_msix()
> 
We are testing this now.

I suggest a subject/summary adding the IB/:
IB/qib: Use pci_enable_msix_range() instead of pci_enable_msix()

