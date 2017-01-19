Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:35317 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751902AbdASNrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jan 2017 08:47:20 -0500
Subject: Re: PCIe card supporting multiple MSI vectors
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
References: <a6eb25e3-effc-39a4-88c1-8309d601d7b9@mailbox.org>
 <5880B828.3000302@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
From: Stefan Roese <stefan.roese@mailbox.org>
Message-ID: <3e58ca8c-1cba-b1b7-e58c-6f5554e9fffa@mailbox.org>
Date: Thu, 19 Jan 2017 14:47:16 +0100
MIME-Version: 1.0
In-Reply-To: <5880B828.3000302@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 19.01.2017 13:59, Guilherme G. Piccoli wrote:
> On 01/18/2017 08:43 AM, Stefan Roese wrote:
>> Hi,
>>
>> for some test with MSI related tests I would like to test
>> with a desktop PCIe card that supports multiple MSI vectors.
>> Could somebody please make a suggestion for such a card
>> (not too expansive if possible) with a Linux driver that
>> also support multiple MSI vectors?
>
> I'd suggest NVMe PCI card. Some of them support up to 128 MSI-X
> interrupts at same time.
>
> The problem is in "not too expansive if possible" heheh
> Those cards could be a little bit expensive currently...but worth to
> take a look, maybe works for you. Also, nvme driver is pretty good.

Thanks, this is a good idea. But I'm actually not looking for
MSI-X but for "plain" MSI-multi cards.

Thanks,
Stefan
