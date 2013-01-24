Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37888 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3AXCBq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jan 2013 21:01:46 -0500
Message-ID: <51009645.5040406@infradead.org>
Date: Wed, 23 Jan 2013 18:02:45 -0800
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>
CC: Rob Landley <rob@landley.net>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>, linux-pci@vger.kernel.org,
	Andrew Murray <andrew.murray@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com
Subject: Re: [Update][PATCH] PCI: Document PCIE BUS MPS parameters
References: <1358944092-28884-1-git-send-email-wangyijing@huawei.com> <510074C7.6090203@infradead.org> <510094A4.3040806@huawei.com>
In-Reply-To: <510094A4.3040806@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/23/13 17:55, Yijing Wang wrote:
> Hi Randy,
>    Thanks for your review and comments! please refer to inlined comments below.
> 
> On 2013/1/24 7:39, Randy Dunlap wrote:
>> On 01/23/13 04:28, Yijing Wang wrote:

>>
>> What is (are) MRRS?
> 
> MRRS is "Max Read Request Size" and MPS is "Max Payload Size".
> Need use "Max Read Request Size" instead of MRRS ?

Where is MRRS documented?

I would probably do it like so:

Also set MRRS (Max Read Request Size) to the ....

-- 
~Randy
