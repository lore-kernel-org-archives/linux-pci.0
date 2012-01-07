Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53234 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759072Ab2AGBVC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 20:21:02 -0500
Received: by ggdk6 with SMTP id k6so969942ggd.19
        for <linux-pci@vger.kernel.org>; Fri, 06 Jan 2012 17:21:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120106131436.17cf45e6@jbarnes-desktop>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
	<1323247984-15281-2-git-send-email-yinghai@kernel.org>
	<20120106131436.17cf45e6@jbarnes-desktop>
Date: Fri, 6 Jan 2012 17:21:01 -0800
Message-ID: <CAE9FiQUPkVu_L_R8TWqtMdEXSfPjh193NPyOTxYE1_6MF+Vw_A@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI : Calculate right add_size
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 6, 2012 at 1:14 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:

>> We should not pass add_size with min_size in calculate_memsize.
>> that will make add_size not contribute final add_size.
>>
>> Just pass add_size with size1 to calculate_memsize()
>>
>> With this change, We should have chance to remove extra addon in pci_reassign_resource...
>
> This one looks like a fairly standalone bug fix; it doesn't require
> subtle changes in behavior from the later patches to work right does it?
>

yes.

Yinghai
