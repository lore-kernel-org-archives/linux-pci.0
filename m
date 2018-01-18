Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeARF0U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jan 2018 00:26:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 18 Jan 2018 10:56:19 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v5 4/4] PCI/DPC: Enumerate the devices after DPC trigger
 event
In-Reply-To: <b255864b-1272-0626-f448-db2d9c3710c5@codeaurora.org>
References: <1516185438-31556-1-git-send-email-poza@codeaurora.org>
 <1516185438-31556-5-git-send-email-poza@codeaurora.org>
 <b255864b-1272-0626-f448-db2d9c3710c5@codeaurora.org>
Message-ID: <8c3e20a60cff5eb2b60f3571d1b7335c@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-17 21:57, Sinan Kaya wrote:
> On 1/17/2018 5:37 AM, Oza Pawandeep wrote:
>> +static bool dpc_wait_link_active(struct pci_dev *pdev)
>> +{
> 
> I think you can also make this function common instead of making
> another copy here.
> Of course, this would be another patch.

ok I will make a separate patch taking one more parameter
dpc_wait_link_active(struct pci_dev *, bool)

if not in this series, then immediate one.

Regards,
Oza.
