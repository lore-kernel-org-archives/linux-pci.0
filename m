Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:12613 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbbGNUxW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 16:53:22 -0400
Message-ID: <55A576BF.9060609@broadcom.com>
Date: Tue, 14 Jul 2015 13:53:19 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: SF Markus Elfring <elfring@users.sourceforge.net>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	LKML <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"Julia Lawall" <julia.lawall@lip6.fr>
Subject: Re: [PATCH] PCI-iproc: Delete unnecessary checks before two function
 calls
References: <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <55900A20.5070407@users.sourceforge.net> <20150714201059.GG24416@google.com> <55A56FBB.20203@broadcom.com> <20150714205128.GI24416@google.com>
In-Reply-To: <20150714205128.GI24416@google.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 7/14/2015 1:51 PM, Bjorn Helgaas wrote:
> On Tue, Jul 14, 2015 at 01:23:23PM -0700, Ray Jui wrote:
>> Hi Bjorn,
>>
>> On 7/14/2015 1:10 PM, Bjorn Helgaas wrote:
>>> On Sun, Jun 28, 2015 at 04:52:16PM +0200, SF Markus Elfring wrote:
>>>> From: Markus Elfring <elfring@users.sourceforge.net>
>>>> Date: Sun, 28 Jun 2015 16:42:04 +0200
>>>>
>>>> The functions phy_exit() and phy_power_off() test whether their argument
>>>> is NULL and then return immediately.
>>>> Thus the test around the calls is not needed.
>>>>
>>>> This issue was detected by using the Coccinelle software.
>>>>
>>>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>>>
>>> I haven't seen a followup to Ray's review, but in the interest of making
>>> progress, I updated and applied the patch as appended.  I also reviewed
>>> other phy_*() calls under drivers/pci, and they all look OK (with no
>>> unnecessary tests for NULL).
>>>
>>> This is on the pci/host-iproc branch for v4.3.
>>>
>>
>> Hmmm....I searched my mailbox but cannot find an email with this patch
>> (while I remember I reviewed and commented on the initial version of
>> this patch). It must have gone into some sub-folder or deleted by me by
>> accident. My bad.
>>
>> Nevertheless,the current patch looks good to me!
> 
> Thanks for checking it out!  Can I add your Reviewed-by to the patch below?
> 

Sure thanks!

Reviewed-by: Ray Jui <rjui@broadcom.com>

Ray
