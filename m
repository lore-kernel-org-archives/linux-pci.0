Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:58640 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762003Ab2FVKVX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 06:21:23 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DAFE23EE0BC
	for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 19:21:21 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B6CE945DE56
	for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 19:21:21 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9E78145DE54
	for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 19:21:21 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 914A41DB804E
	for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 19:21:21 +0900 (JST)
Received: from m001.s.css.fujitsu.com (m001.s.css.fujitsu.com [10.23.4.39])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4C79C1DB804D
	for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 19:21:21 +0900 (JST)
Date: Fri, 22 Jun 2012 19:21:28 +0900
From: Taku Izumi <izumi.taku@jp.fujitsu.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH 0/4] acpi, pci: hostbridge hotplug support
Message-Id: <20120622192128.60b57d14.izumi.taku@jp.fujitsu.com>
In-Reply-To: <CAE9FiQUn-NhgJkhHXFu4gMi=xzWz06hSVxUJunj25e8gH_xqBw@mail.gmail.com>
References: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com>
	<CAE9FiQUn-NhgJkhHXFu4gMi=xzWz06hSVxUJunj25e8gH_xqBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 21 Jun 2012 11:18:07 -0700
Yinghai Lu <yinghai@kernel.org> wrote:

> On Thu, Jun 21, 2012 at 2:34 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
> >
> >  This patchset adds basic code for host bridge hotplug.
> >
> >  I assume ACPI container device (ACPI0004) which carries
> >  hostbridges will be hot-added or hot-removed. In that case
> >  some codes are now missing for hostbridge hotplug.
> >  This patchset mainly adds the following:
> >   - remove hostbridge and devices under it
> >   - resoruce-assign code for devices under hot-added hostbridge
> >
> >  The behavior when you don't try hostbridge hotplug should not change.
> >
> >  *[PATCH 1/4] acpi, pci: introduce list for acpi_pci_root drivers
> >  *[PATCH 2/4] acpi, pci: introduce acpi_root_sem for list manipulation
> >  *[PATCH 3/4] acpi, pci: add hostbridge removal function
> >  *[PATCH 4/4] acpi, pci: add resoruce-assign code for devices under
> >      hot-added hostbridge
> 
> Hi, did you check our pci root bus hot plug branch ?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-root-bus-hotplug
> 
> It contain some similar patches from jiang and me.

  Hi Yinghai,
  Thank you for your comment.

  I checked your branch out. It seems to include many work.
  Is it already scheduled to be merged to Bjorn's tree?
  If not, should I develop based on your tree?

  Best regards, 
  Taku Izumi <izumi.taku@jp.fujitsu.com>

