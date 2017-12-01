Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V4 3/5] device property: Introduce a common API to fetch
 device match data
To: Sakari Ailus <sakari.ailus@linux.intel.com>
References: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
 <1512096776-22883-4-git-send-email-okaya@codeaurora.org>
 <20171201091325.weepl5rtxg4zqqyd@paasikivi.fi.intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <472bc344-009c-6163-e71f-d97ba856827d@codeaurora.org>
Date: Fri, 1 Dec 2017 10:51:44 -0500
MIME-Version: 1.0
In-Reply-To: <20171201091325.weepl5rtxg4zqqyd@paasikivi.fi.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 12/1/2017 4:13 AM, Sakari Ailus wrote:
> Most of the dev->of_node checks have been removed from property.c and
> replaced by calls to the firmware specific fwnode operations. What remains
> should probably be moved there, too (apart from dev_fwnode).
> 
> How about adding a new op for this one to struct fwnode_operations in
> include/linux/fwnode.h?

Sure, let me look. I was following the get_dma function. Bad example I guess.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
