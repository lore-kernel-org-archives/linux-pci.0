Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1444407723.17726.14.camel@oracle.com>
Subject: Re: [PATCH v7 15/60] PCI: Restore pref MMIO allocation logic for
 host bridge without mmio64
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2015 10:22:03 -0600
In-Reply-To: <1444340359-8011-16-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-16-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> From 5b2854155 (PCI: Restrict 64-bit prefetchable bridge windows to 64-bit
> resources), we change the logic for pref mmio allocation:
> When bridge pref support mmio64, we will only put children pref
> that support mmio64 into it, and will put children pref mmio32
> into bridge's non-pref mmio32.
> 
> That could leave bridge pref bar not used when that pref bar is mmio64,
> and children res only has mmio32.
> Also could have allocation failure when non-pref mmio32 is not big
> enough space for those children pref mmio32.
> 
> That is not rational when the host bridge does not 64bit mmio above 4g
> at all.
> 
> The patch restore to old logic:
> when host bridge does not have has_mem64, put children pref mmio64 and
> pref mmio32 all under bridges pref bars.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 




