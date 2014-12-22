Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:50737 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbaLVOGd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 09:06:33 -0500
Message-ID: <54982561.2080200@gmail.com>
Date: Mon, 22 Dec 2014 12:06:25 -0200
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
MIME-Version: 1.0
To: Nils Holland <nholland@tisys.org>,
	Prashant Sreedharan <prashant@broadcom.com>
CC: davem@davemloft.net, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	rajatxjain@gmail.com, Michael Chan <mchan@broadcom.com>
Subject: Re: [PATCH net]tg3: tg3_disable_ints using uninitialized mailbox
 value to disable interrupts
References: <1419106577-12891-1-git-send-email-prashant@broadcom.com> <20141220221606.GA2591@teela.fritz.box>
In-Reply-To: <20141220221606.GA2591@teela.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20-12-2014 20:16, Nils Holland wrote:
> On Sat, Dec 20, 2014 at 12:16:17PM -0800, Prashant Sreedharan wrote:
>>
>> This driver bug was exposed because of the commit a7877b17a667 (PCI: Check only
>> the Vendor ID to identify Configuration Request Retry). Also this issue is only
>> seen in older generation chipsets like 5722 because config space write to offset
>> 0 from driver is possible.
>>
>> Fixed by initializing the interrupt mailbox registers before calling tg3_halt.
>>
>> Please queue for -stable.
>
> I gave this patch a try and can confirm what was to be expected: It
> fixes the issue and the network interface is once again working
> properly on my system. Thus, I guess the issue is adequately solved.
>
> Thanks to everyone involved, especially to Marcelo for additional
> debugging and the guys at Broadcom for the quick fix!
>
> Greetings,
> Nils

Same here, it works again.

Thanks!
Marcelo
