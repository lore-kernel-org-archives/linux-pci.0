Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48397 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab2AGGMg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Jan 2012 01:12:36 -0500
Received: by yhnn56 with SMTP id n56so936079yhn.19
        for <linux-pci@vger.kernel.org>; Fri, 06 Jan 2012 22:12:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXc8zNsg4t4+7LZFioof7nTrJK5JOa-1ExGQ=eOY08weg@mail.gmail.com>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-3-git-send-email-yinghai@kernel.org>
	<20120106134915.705f5b47@jbarnes-desktop>
	<CAE9FiQXKVgkHg9fqXHvs7umnXkQ1Hmxudfy84jdy1n_Mo5D9Cg@mail.gmail.com>
	<CAE9FiQXbsUH1v3+FXcyZwXk=SbLuhY2FeoH-LEi2mtvu4zOeQA@mail.gmail.com>
	<CAE9FiQXc8zNsg4t4+7LZFioof7nTrJK5JOa-1ExGQ=eOY08weg@mail.gmail.com>
Date: Fri, 6 Jan 2012 22:12:35 -0800
Message-ID: <CAE9FiQXORmQhP1f3ZK5vYutWv2CdpP-jN7AR0oe=w_mqz+y1fw@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 6, 2012 at 9:53 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Jan 6, 2012 at 9:51 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Jan 6, 2012 at 7:46 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> This looks like a separate bug fix; can you separate it out?  I assume
>>>> you ran into it at least once as you were adding more recursion and
>>>> occasionally not exiting it quickly. :)
>>
>> hi,  the patch has been separated into three patches.
>>
>> please check attached.
>>
>> please let me know if you like me to resend the whole patch set.

just rebase my for-pci branch. please check them at

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci

5007278: pciehp: Checking pci conf reading to new added device instead
of sleep 1s
f390f69: PCI: Make sriov work with hotplug remove
93acbd6: PCI: Fixing multiple retrying with pci resource optional
resources allocation under multi bridges
7f5dac3: PCI: Make pci_rescan_bus handle add_list
18dd9be: PCI: Make rescan bus could increase bridge resource size if needed
52e0afc: PCI: Using add_list in pcie hotplug path.
2b6542d: PCI: Try to assign required+option size at first
4beb962: PCI: Move get_res_add_size() early
8cb9020: PCI: Make add_to_list() return status
8535f21: PCI : Calculate right add_size

after those patches get into your tree, I will try do clean up as
linus pointed in another mail.

Thanks

Yinghai
