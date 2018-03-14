Return-Path: <SRS0=V62j=GE=bombadil.srs.infradead.org=BATV+f6fb34e83e736936479f+5316+infradead.org+hch@kernel.org>
Return-Path: <SRS0=V62j=GE=bombadil.srs.infradead.org=BATV+f6fb34e83e736936479f+5316+infradead.org+hch@kernel.org>
Date: Wed, 14 Mar 2018 01:35:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mikael Starvik <starvik@axis.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	David Howells <dhowells@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-am33-list@redhat.com
Subject: Re: [PATCH] PCI/MSI: Don't set up INTx if MSI or MSI-X is enabled
Message-ID: <20180314083519.GA24043@infradead.org>
References: <152097754955.241946.9551793957889760940.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152097754955.241946.9551793957889760940.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Should this logic go into a little helper so that everyone is kept
in sync?
