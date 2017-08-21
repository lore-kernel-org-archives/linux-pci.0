Return-Path: <SRS0=k55j=7X=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=k55j=7X=intel.com=keith.busch@kernel.org>
Date: Mon, 21 Aug 2017 10:40:55 -0400
From: Keith Busch <keith.busch@intel.com>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
	gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH V5 2/2] PCI/DPC: Add local struct device
Message-ID: <20170821144055.GE21397@localhost.localdomain>
References: <1503133641-114550-1-git-send-email-liudongdong3@huawei.com>
 <1503133641-114550-3-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503133641-114550-3-git-send-email-liudongdong3@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 19, 2017 at 05:07:21PM +0800, Dongdong Liu wrote:
> Use a local "struct device *dev" for brevity and consistency in DPC driver.
> No functional change intended.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
