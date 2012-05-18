Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49446 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967836Ab2ERJIQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2012 05:08:16 -0400
Received: by dady13 with SMTP id y13so3582069dad.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 02:08:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWOoEX3H6V7+c+azm8DJieX8bpXRmsYuOE+ZUDJ-p3-yQ@mail.gmail.com>
References: <1333968563.5678.19.camel@infinity>
	<CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com>
	<1334248841.2910.6.camel@Nokia-N900>
	<4F89B5E8.3040906@snewbury.org.uk>
	<4F89BC84.50308@snewbury.org.uk>
	<4F89C513.3000006@snewbury.org.uk>
	<4F89CB16.2000908@snewbury.org.uk>
	<4F89CE43.7040200@snewbury.org.uk>
	<CAE9FiQVwDNM9MkqG_g139LDf6Ypjx0uygzVqosDe=fF=c_Y3gA@mail.gmail.com>
	<4F8AA0DC.6010902@snewbury.org.uk>
	<4F8AB312.7060606@snewbury.org.uk>
	<4F8B04A4.4070507@snewbury.org.uk>
	<4F8B0609.8010603@snewbury.org.uk>
	<CAE9FiQUsQjUNeW1sa_mQL6MEaDhxvoMhFaN9wLPAqOXzh+AXPQ@mail.gmail.com>
	<CAE9FiQVzC2YCkXtFDPkCMVMcMqt9c0t8hKVvpgFpwjRdBen0Uw@mail.gmail.com>
	<CAE9FiQX7iVYZSoEJVVHJTx1gUSKh6RP+iJRGJqMZmDgkFDnPQQ@mail.gmail.com>
	<CAE9FiQXrF+o9UW-J+UDSN3OR4SOWWAZwJbH=39k4xFf2m-Jd9A@mail.gmail.com>
	<4F96770D.2050606@snewbury.org.uk>
	<4FB227D3.7090002@snewbury.org.uk>
	<CAE9FiQX48eCS85eWMFxm6fCWgu2zwxvSywtQhsf-35WEvBfJVQ@mail.gmail.com>
	<4FB4EE99.10509@snewbury.org.uk>
	<4FB4F039.2040308@snewbury.org.uk>
	<CAE9FiQUpdVJeF06BtqOKo448n1oH+AMJyC03FpB13=fOdkwM+w@mail.gmail.com>
	<CAE9FiQWOoEX3H6V7+c+azm8DJieX8bpXRmsYuOE+ZUDJ-p3-yQ@mail.gmail.com>
Date: Fri, 18 May 2012 02:08:15 -0700
Message-ID: <CAE9FiQU1Bq3xpo0m_eNwBHoxF+oH=pXpg59hQguf_5GpWytyKg@mail.gmail.com>
Subject: Re: PCI resources above 4GB
From: Yinghai Lu <yinghai@kernel.org>
To: Steven Newbury <steve@snewbury.org.uk>
Cc: linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 18, 2012 at 12:45 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, May 17, 2012 at 9:36 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Thu, May 17, 2012 at 5:34 AM, Steven Newbury <steve@snewbury.org.uk> wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Strange, the busn branch is merged with for-pci-res-alloc, but for
>>> some reason it isn't working.  Only the bridge is detected, not the
>>> devices behind it.
>>
>> Can you post the boot log ? maybe recently reordering patches applying
>> sequence break it.
>
> Never mind, found the problem.

updated for-pci-res-alloc branch. please check it.

Thanks

Yinghai
