Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 7 Jan 2014 17:09:38 +0100
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
Subject: Re: [Patch Part1 V3 00/20] Bugfixes and improvements for Intel IOMMU
 drivers
Message-ID: <20140107160937.GA4446@8bytes.org>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 06, 2014 at 02:18:07PM +0800, Jiang Liu wrote:
> This patchset includes several bugfixes and code improvements for
> Intel DMA remapping and interrupt remapping drivers. It's also a
> preparation for Intel IOMMU device hotplug.
> 
> It applies to the latest mainstream kernel on top of
> 	commit 7e3528c3660a2e8602abc7858b0994d611f74bc3
> 
> It has been tested on Intel SandyBridge and Romley-4S platforms.

Okay, I reviewed these patches and they are looking fine to me. I
applied them to my x86/vt-d branch (fixed the detect_intel_iommu()
problem myself).
Unless anyone speaks up against it or testing in linux-next shows issues
I plan to send these changes upstream for v3.14.

Thanks,

	Joerg


