Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52064 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab2AGFvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Jan 2012 00:51:22 -0500
Received: by yenm11 with SMTP id m11so978534yen.19
        for <linux-pci@vger.kernel.org>; Fri, 06 Jan 2012 21:51:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXKVgkHg9fqXHvs7umnXkQ1Hmxudfy84jdy1n_Mo5D9Cg@mail.gmail.com>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
	<20120106134915.705f5b47@jbarnes-desktop>
	<CAE9FiQXKVgkHg9fqXHvs7umnXkQ1Hmxudfy84jdy1n_Mo5D9Cg@mail.gmail.com>
Date: Fri, 6 Jan 2012 21:51:21 -0800
Message-ID: <CAE9FiQXbsUH1v3+FXcyZwXk=SbLuhY2FeoH-LEi2mtvu4zOeQA@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 6, 2012 at 7:46 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> This looks like a separate bug fix; can you separate it out?  I assume
>> you ran into it at least once as you were adding more recursion and
>> occasionally not exiting it quickly. :)

hi,  the patch has been separated into three patches.

please check attached.

please let me know if you like me to resend the whole patch set.

Thanks

Yinghai Lu
