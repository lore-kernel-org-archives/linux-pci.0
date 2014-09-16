Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:36525 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbaIPGeT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 16 Sep 2014 02:34:19 -0400
Message-ID: <1410849257.12488.3.camel@concordia>
Subject: Re: [PATCH v2 5/5] MSI: Use __read_msi_msg() instead of
 read_msi_msg()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Date: Tue, 16 Sep 2014 16:34:17 +1000
In-Reply-To: <1408694880-8260-6-git-send-email-wangyijing@huawei.com>
References: <1408694880-8260-1-git-send-email-wangyijing@huawei.com>
	 <1408694880-8260-6-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-08-22 at 16:08 +0800, Yijing Wang wrote:
> Read_msi_msg() only be called in rtas_setup_msi_irqs(),
> use __read_msi_msg() instead of read_msi_msg for
> simplification. And rename __read_msi_msg() to
> read_msi_msg().
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@lists.ozlabs.org

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers


