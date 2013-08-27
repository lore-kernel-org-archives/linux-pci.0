Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:64988 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3H0Aj3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2013 20:39:29 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so4491468oah.37
        for <linux-pci@vger.kernel.org>; Mon, 26 Aug 2013 17:39:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo70BYoJ4f9WD+vkYER6zZeJNO+Ar5cetRte6YYA24RYOw@mail.gmail.com>
References: <1377141888-7000-1-git-send-email-wangyijing@huawei.com>
	<1377141888-7000-7-git-send-email-wangyijing@huawei.com>
	<20130822181823.GA25721@google.com>
	<521ACE99.9000505@huawei.com>
	<CAErSpo70BYoJ4f9WD+vkYER6zZeJNO+Ar5cetRte6YYA24RYOw@mail.gmail.com>
Date: Mon, 26 Aug 2013 17:39:28 -0700
Message-ID: <CAE9FiQWd7BWivERSFRrB+nhLrNcNNHq4D61j5dsGeBVVQ=vnHA@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] PCI: update device mps when doing pci hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, Jon Mason <jdmason@kudzu.us>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>, Jin Feng <joe.jin@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 26, 2013 at 2:33 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> The current Linux default is PCIE_BUS_TUNE_OFF, and given that I don't
> want to touch any MPS settings in that mode, I don't see a way to
> safely fix https://bugzilla.kernel.org/show_bug.cgi?id=60671 (the
> problem with hot-added devices not working because MPS is incorrect).
> In the long term, I hope we can fix it by making the default
> PCIE_BUS_SAFE, but that doesn't help right now.
>
> That leaves us with only the workaround of booting the Huawei rh5885
> box with "pci=pcie_bus_safe".
>
> I'm willing to accept that because I think we can argue that this is
> really a BIOS defect.  The BIOS *can* program MPS to values that will
> be safe for hotplug even if the OS does nothing, i.e., it can set
> MPS=128 in all paths that lead to a hotpluggable slot.  I think that's
> probably what this BIOS *should* do, since it has no way of knowing
> whether the OS will support hotplug or whether the OS will reprogram
> any MPS values.

BIOS should have several settings for MPS:
1. 128
2. auto or performance.

When it set to Auto, Linux will have problem with hot-add.

Default one was 128 before, that is ok,
as from sndbrige and ivbridge, chipset could support more than 128.

BIOS want to set it auto.
BIOS guys is claiming that other OSes are ok with Auto, but only Linux
has problem.

So maybe it's time for us to change default to pcie_bus_perf iff
1. we detect there are pcie bridge with hotplug support is around
2. mpss for those bridge is not set 128. --- keep this optional ?

at same time issue warning that we change to perf, is user have
problem they could try
to override from command line when they have problem.

Yinghai
