Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:56417 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030644AbcJQTTN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Oct 2016 15:19:13 -0400
Date: Mon, 17 Oct 2016 15:30:23 -0400
From: Keith Busch <keith.busch@intel.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] x86/PCI: VMD: Remove unnecessary pci_set_drvdata()
Message-ID: <20161017193023.GA23617@localhost.localdomain>
References: <1476716684-6778-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476716684-6778-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 03:04:44PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
