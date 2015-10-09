Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1444407625.17726.9.camel@oracle.com>
Subject: Re: [PATCH v7 10/60] OF/PCI: Add IORESOURCE_MEM_64 for 64-bit
 resource
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Date: Fri, 09 Oct 2015 10:20:25 -0600
In-Reply-To: <1444340359-8011-11-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-11-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
> For device resource PREF bit setting under bridge 64-bit pref resource,
> we need to make sure only set PREF for 64bit resource, so set
> IORESOUCE_MEM_64 for 64bit resource during OF device resource flags
> parsing.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org

Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 




