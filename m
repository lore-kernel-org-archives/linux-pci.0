Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:39201 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbeFAPHB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jun 2018 11:07:01 -0400
Subject: Re: [PATCH v2] PCI: Check for PCIe downtraining conditions
To: Sinan Kaya <okaya@codeaurora.org>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180601150129.10486-1-mr.nuke.me@gmail.com>
 <35a67b5b-5f37-c779-64a3-eb5e21362e9c@codeaurora.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <c677b42a-f5f0-474e-c9ce-da05ced45b23@gmail.com>
Date: Fri, 1 Jun 2018 10:06:58 -0500
MIME-Version: 1.0
In-Reply-To: <35a67b5b-5f37-c779-64a3-eb5e21362e9c@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/01/2018 10:03 AM, Sinan Kaya wrote:
> On 6/1/2018 11:01 AM, Alexandru Gagniuc wrote:
>> +	/* Multi-function PCIe share the same link/status. */
>> +	if (PCI_FUNC(dev->devfn) != 0)
>> +		return;
> 
> How about virtual functions?

I have almost no clue about those. Is your concern that we might end up
printing more than our fair share of link statuses?

Alex
