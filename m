Return-Path: <SRS0=DR+N=5Y=bombadil.srs.infradead.org=BATV+c839010d8a82889b76e4+5048+infradead.org+hch@kernel.org>
Return-Path: <SRS0=DR+N=5Y=bombadil.srs.infradead.org=BATV+c839010d8a82889b76e4+5048+infradead.org+hch@kernel.org>
Date: Mon, 19 Jun 2017 14:10:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: haiyangz@microsoft.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
	kys@microsoft.com, sthemmin@microsoft.com, olaf@aepfle.de,
	vkuznets@redhat.com, driverdev-devel@linuxdriverproject.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Message-ID: <20170619211014.GA19330@infradead.org>
References: <1495658355-13103-1-git-send-email-haiyangz@exchange.microsoft.com>
 <20170619210742.GA554@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619210742.GA554@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

FYI, I've also got another driver in progress that will need domains
assigned outside the ACPI range, so it's not just limited to VMD.
