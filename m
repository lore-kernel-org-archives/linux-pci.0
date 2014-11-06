Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 6 Nov 2014 08:51:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Neela Syam Kolli <megaraidlinux@lsi.com>,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Alexander Gordeev <agordeev@redhat.com>,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] megaraid_sas : Fix bug in handling return value of
 pci_enable_msix_range()
Message-ID: <20141106165139.GA17176@infradead.org>
References: <1415018660-30775-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415018660-30775-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks,

applied to the drivers-for-3.18 branch.

