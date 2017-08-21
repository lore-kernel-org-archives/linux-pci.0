Return-Path: <SRS0=k55j=7X=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=k55j=7X=intel.com=keith.busch@kernel.org>
Date: Mon, 21 Aug 2017 10:40:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: "helgaas@kernel.org" <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
	"charles.chenxin@huawei.com" <charles.chenxin@huawei.com>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH V5 1/2] PCI/DPC: Add eDPC support
Message-ID: <20170821144000.GD21397@localhost.localdomain>
References: <1503133641-114550-1-git-send-email-liudongdong3@huawei.com>
 <1503133641-114550-2-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503133641-114550-2-git-send-email-liudongdong3@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 19, 2017 at 02:07:20AM -0700, Dongdong Liu wrote:
> This code is to add eDPC support. Get and print the RP PIO error
> information when the trigger condition is RP PIO error.
> 
> For more information on eDPC, please see PCI Express Base Specification
> Revision 3.1, section 6.2.10.3, or view the PCI-SIG eDPC ECN here:
> https://pcisig.com/sites/default/files/specification_documents/ECN_Enhanced_DPC_2012-11-19_final.pdf
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

This looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
