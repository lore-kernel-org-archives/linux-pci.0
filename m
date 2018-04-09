Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58755 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbeDIXL6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Apr 2018 19:11:58 -0400
Date: Mon, 9 Apr 2018 17:14:48 -0600
From: Keith Busch <keith.busch@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 1/6] PCI/AER: Rename error recovery to generic PCI
 naming
Message-ID: <20180409231448.GB6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-2-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523284914-2037-2-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:49AM -0400, Oza Pawandeep wrote:
> This patch renames error recovery to generic name with pcie prefix
> 
> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

Looks fine.

Reviewed-by: Keith Busch <keith.busch@intel.com>
