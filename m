Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:48741 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab2GJXkP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 19:40:15 -0400
Received: by vbbff1 with SMTP id ff1so397302vbb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 16:40:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo40FOgXrMJBv9TRHtd8hX6muGLMipf8dq+h7oPOzD35Ug@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
	<1340437325-29282-3-git-send-email-yinghai@kernel.org>
	<CAErSpo5K9EqAQSKA5_YdM2WThWddJr4XDbFHr84h_MPHvSqJmg@mail.gmail.com>
	<CAE9FiQVX+CnRchXNe8PF8fz7hbc=UTzP8nCxEAzAzrJTeZk-Tg@mail.gmail.com>
	<CAErSpo40FOgXrMJBv9TRHtd8hX6muGLMipf8dq+h7oPOzD35Ug@mail.gmail.com>
Date: Tue, 10 Jul 2012 16:40:14 -0700
Message-ID: <CAE9FiQV0NM+9pQVUETSnQg=2qcMswCYMjLEguYnaaMjyjn+teQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] pciehp: Don't enable presence notification while
 surprise removal is not supported.
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 4:28 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Jul 10, 2012 at 5:12 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> Interesting, that means after card is plugged in, we don't need to
>> press attention button to bring
>> it online.
>>
>> And other oses like windows and solaris do need to press the button
>> like current linux doing.
>
> The attention button is apparently optional, depending on the form factor.
>
> I would guess that on a platform with no attention button and Hot-Plug
> Surprise == 0, Linux would be unable to do a hot-add.

yes.
