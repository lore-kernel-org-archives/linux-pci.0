Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46333 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab2AXQ6D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2012 11:58:03 -0500
Message-ID: <4F1ED9A5.8040601@jp.fujitsu.com>
Date: Tue, 24 Jan 2012 11:17:41 -0500
From: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] Add pcie_hp=nomsi to disable MSI/MSI-X for pciehp
 driver
References: <20120119223221.15239.6758.sendpatchset@dhcp-189-101.bos.redhat.com> <CAE9FiQWKRxZcm2FBhP2SxaBGYpROc4grJQtE68OyayPhjQHdsA@mail.gmail.com>
In-Reply-To: <CAE9FiQWKRxZcm2FBhP2SxaBGYpROc4grJQtE68OyayPhjQHdsA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 19 Jan 2012 15:41:09 -0800,
Yinghai Lu <yinghai@kernel.org> wrote:
>
> do you have statement for IDT, says that is chipset problem ?

No, I will ask.

> it could be your platform fw problem.
>
> if that is the case, you will disable MSI/MSIX for other platform that
> do not have fw problem.

Thanks,
Takahiro
