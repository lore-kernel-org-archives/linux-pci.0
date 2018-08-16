Return-Path: <SRS0=VWJN=K7=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=VWJN=K7=intel.com=keith.busch@kernel.org>
Date: Thu, 16 Aug 2018 15:19:40 -0600
From: Keith Busch <keith.busch@intel.com>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "helgaas@kernel.org" <helgaas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"okaya@kernel.org" <okaya@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"liudongdong3@huawei.com" <liudongdong3@huawei.com>,
	"poza@codeaurora.org" <poza@codeaurora.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Message-ID: <20180816211940.GB7400@localhost.localdomain>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
 <20180816154940.GD5762@bombadil.infradead.org>
 <1534434641.17819.27.camel@intel.com>
 <20180816203111.GB10316@bhelgaas-glaptop.roam.corp.google.com>
 <1534452635.17819.53.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534452635.17819.53.camel@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 01:50:42PM -0700, Derrick, Jonathan wrote:
> It can also be disabled with setpci, but is that any less of a hassle?
> Genuine question to understand your point of view.

That is not a real solution, IMO. 'setpci' is good to inject things
for testing, but it changes config space without the kernel aware that
you've done that, so it is inherently racey with other kernel threads
touching pci config space. And the kernel or platform may end up undoing
what you had 'setpci' do anyway with no immediate way to be notified it
was changed.
