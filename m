Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34649 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcI2IWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 04:22:33 -0400
Date: Thu, 29 Sep 2016 10:22:29 +0200
From: "tj@kernel.org" <tj@kernel.org>
To: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "holler@ahsoftware.de" <holler@ahsoftware.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ATA failure regression
Message-ID: <20160929082229.GA11087@mtj.duckdns.org>
References: <DM5PR12MB17698A0E873273577E60A97BA0C80@DM5PR12MB1769.namprd12.prod.outlook.com>
 <8520D5D51A55D047800579B094147198258E4869@XAP-PVEXMBX01.xlnx.xilinx.com>
 <MWHPR12MB177486F96C515BCAEADC7D70A0CF0@MWHPR12MB1774.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR12MB177486F96C515BCAEADC7D70A0CF0@MWHPR12MB1774.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Wed, Sep 28, 2016 at 05:45:08AM +0000, Shah, Nehal-bakulchandra wrote:
> Can someone please help me to debug this issue?

The only thing I can do from libata side is disbling msi on the
affected platform, but the problem doesn't seem confined to ahci, so
probably the right thing to do for now is disabling msi on the
platform?

Thanks.

-- 
tejun
