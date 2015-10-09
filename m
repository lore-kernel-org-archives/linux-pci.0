Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1444407671.17726.11.camel@oracle.com>
Subject: Re: [PATCH v7 12/60] PCI: Only treat non-pref mmio64 as pref if all
 bridges have MEM_64
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2015 10:21:11 -0600
In-Reply-To: <1444340359-8011-13-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-13-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> If any bridge up to root only have 32bit pref mmio, We don't need to
> treat device non-pref mmio64 as as pref mmio64.
> 
> We need to move pci_bridge_check_ranges calling early.
> for parent bridges pref mmio BAR may not allocated by BIOS, res flags
> is still 0, we need to have it correct set before we check them for
> child device resources.
> 
> -v2: check all bus resources instead of just res[15].
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>


Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 




