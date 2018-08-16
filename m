Return-Path: <SRS0=seR5=K7=infradead.org=willy@kernel.org>
Return-Path: <SRS0=seR5=K7=infradead.org=willy@kernel.org>
Date: Thu, 16 Aug 2018 08:49:40 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@kernel.org>,
	Oza Pawandeep <poza@codeaurora.org>,
	Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Message-ID: <20180816154940.GD5762@bombadil.infradead.org>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 15, 2018 at 03:26:39PM -0600, Jon Derrick wrote:
> Some users may want to disable downstream port containment (DPC), so
> give them this option

Is it possible they might only want to disable DPC on a subset of the
hierarchy rather than globally?
