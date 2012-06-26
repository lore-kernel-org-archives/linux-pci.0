Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65453 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab2FZSDv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jun 2012 14:03:51 -0400
Received: by pbbrp8 with SMTP id rp8so392312pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 26 Jun 2012 11:03:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A338DB2991D2A44B9A44B8718AECF650A41F453@G01JPEXMBYT03>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
	<1340437325-29282-3-git-send-email-yinghai@kernel.org>
	<4A338DB2991D2A44B9A44B8718AECF650A41F453@G01JPEXMBYT03>
Date: Tue, 26 Jun 2012 11:03:49 -0700
Message-ID: <CAE9FiQXPNn-NnspnCGAK9rs1FvcAtw_KPL5nbBYisL0_=VqRzw@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
From: Yinghai Lu <yinghai@kernel.org>
To: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2012 at 6:26 PM, Kaneshige, Kenji
<kaneshige.kenji@jp.fujitsu.com> wrote:
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org
>> [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Yinghai Lu
>> Sent: Saturday, June 23, 2012 4:42 PM
>> To: Bjorn Helgaas
>> Cc: linux-pci@vger.kernel.org; Yinghai Lu
>> Subject: [PATCH 2/5] pciehp: Don't enable presence notification while
>> surprise removal is not supported.
>>
>> If surprise removal is not supported, that event get dropped later.
>> So there is no point to enable that.
>
> Presence changed event is currently just for printing a kernel message when
> surprise removal is not supported, and I think the message is not so important.
> So I agree this change.
>
> Acked-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

Thanks

>
>>
>> Also some sick chipset have those bit flip around when the card is not
>> present.
>> and make log full of useless warning.
>
> Is there any other way to avoid this issue other than disabling presence
> changed notification? If we need enabling presence changed event in the
> future, this will happen again. I'm worrying about this.

could be fixed from HW change and CPLD change.

Thanks

Yinghai
