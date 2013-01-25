Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:57528 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab3AYS57 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2013 13:57:59 -0500
MIME-Version: 1.0
In-Reply-To: <CAErSpo58qUuwd+8bGMWQHQ6KrfQMvHGb+REVkpJqQdrfAQe3Qw@mail.gmail.com>
References: <1356594177-29453-1-git-send-email-linfeng@cn.fujitsu.com>
	<CAErSpo7EmvDaK11P6r-PKxPBqHQBPaGvZj=zvNZ8w=KFbdFgYA@mail.gmail.com>
	<5102583E.4030109@cn.fujitsu.com>
	<CAErSpo58qUuwd+8bGMWQHQ6KrfQMvHGb+REVkpJqQdrfAQe3Qw@mail.gmail.com>
Date: Fri, 25 Jan 2013 10:57:58 -0800
Message-ID: <CAE9FiQUP71TJgP21SRre4Mb2PrnUg+7KLzXnxHUviqCuNSL44w@mail.gmail.com>
Subject: Re: [PATCH] pci-sysfs: replace mutex_lock with mutex_trylock to avoid
 potential deadlock situation
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, tangchen@cn.fujitsu.com,
	laijs@cn.fujitsu.com, wency@cn.fujitsu.com,
	izumi.taku@jp.fujitsu.com, Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 25, 2013 at 9:44 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Yinghai]
>
> On Fri, Jan 25, 2013 at 3:02 AM, Gu Zheng

Hi, Gu,

Can you check if two patches in

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-root-bus-hotplug-part3

could solve your problem?

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=277df390baeab7ba6aa136356b677a096c890c0c

PCI: Rescan bus using callback method too


http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=282e2db3b58d56b5236ee755e1527574df0d298e

PCI, sysfs: Clean up rescan/remove with scheule_callback

Thanks

Yinghai
