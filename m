Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27721 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab3G3PEW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Jul 2013 11:04:22 -0400
Message-ID: <51F7D5E5.3030907@redhat.com>
Date: Tue, 30 Jul 2013 11:04:05 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: jeffrey.t.kirsher@intel.com
CC: Yinghai Lu <yinghai@kernel.org>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Greg Rose <gregory.v.rose@intel.com>
Subject: Re: [PATCH v2 3/3] PCI: Stop sriov after stop PF if PF's driver skip
 that
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>  <1374937868-24437-2-git-send-email-yinghai@kernel.org>  <CAErSpo7xk-NGp+4ZFo-jnVnQSEomY=7=CXDSbZPzrhdjZ4zVSA@mail.gmail.com>  <51F6D161.1040106@redhat.com> <51F6D9A2.8020403@intel.com>  <51F6DF35.40909@redhat.com> <1375134764.2104.1.camel@jtkirshe-mobl>  <CAE9FiQWsaMuAPrx62rTGBokyV-O49NuX0tsaVzqKUcxuoEoPvA@mail.gmail.com> <1375140189.2104.25.camel@jtkirshe-mobl>
In-Reply-To: <1375140189.2104.25.camel@jtkirshe-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/29/2013 07:23 PM, Jeff Kirsher wrote:
> On Mon, 2013-07-29 at 16:14 -0700, Yinghai Lu wrote:
>> On Mon, Jul 29, 2013 at 2:52 PM, Jeff Kirsher
>> <jeffrey.t.kirsher@intel.com>  wrote:
>>> Can I apply this patch as a standalone? or will I need the entire 3
>>> patch series?
>>
>> would be better if you can test those three on top of pci/for-linus branch.
>> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=for-linus
>
> I will have to do that, because I was only able to get patch 3 of the
> series to apply to David Miller's net tree.
I could only find 1/3 of the other 2 patches; don't know why 2/3 is missing in my mailbox.

Given that Yinghai has requested all 3, and you agreed, sounds like you have your answer. ;-)

- Don

