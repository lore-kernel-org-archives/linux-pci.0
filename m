Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 7 Jan 2014 16:25:27 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Tony Luck <tony.luck@intel.com>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [Patch Part1 V3 09/20] iommu/vt-d: mark internal functions as
 static
Message-ID: <20140107152523.GG2742@8bytes.org>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
 <1388989107-4795-10-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388989107-4795-10-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 06, 2014 at 02:18:16PM +0800, Jiang Liu wrote:
> Function detect_intel_iommu()/alloc_iommu()/parse_ioapics_under_ir()
> are only used internally, so mark them as static.

Doesn't seem to be true for detect_intel_iommu which is used in ia64
setup code, no?


	Joerg


