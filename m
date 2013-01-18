Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45862 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab3ARWCL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Jan 2013 17:02:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [RFC PATCH v5 7/8] PCI/PCIe: add "pci=nopciehp" to disable PCIe native hotplug
Date: Fri, 18 Jan 2013 23:08:07 +0100
Message-ID: <1449960.YISN9L5GZD@vostro.rjw.lan>
In-Reply-To: <CAE9FiQU6K1M=rbnhPLsAkhK5dZw8CAoQzAi=YLjtz722jCix-w@mail.gmail.com>
References: <1358525267-14268-1-git-send-email-jiang.liu@huawei.com> <CAErSpo6E0SrY8_JOU6pmrCt9opfKe_jJ6b0E0daNAbpX5KtFuQ@mail.gmail.com> <CAE9FiQU6K1M=rbnhPLsAkhK5dZw8CAoQzAi=YLjtz722jCix-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, January 18, 2013 09:50:59 AM Yinghai Lu wrote:
> On Fri, Jan 18, 2013 at 9:35 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > If you want "pci=nopciehp" as a way for users to deal with this
> > problem by forcing the use of acpiphp, I object.  Windows manages to
> > make these slots work without having users do anything special, so we
> > should be able to do it, too.
> 
> Agreed.
> 
> We need to think that more.
> 
> I think that we should fix acpiphp, and should follow first come and
> first serve for acpiphp and pciehp.

That would introduce regressions for some users, though.

I actually think we should merge acpiphp with pciehp and make one driver that
can use both types of signalling.  There would be a problem with getting
notifications for the same event from both sources, but that doesn't seem to
be unsolvable.

And I don't think that that one combined driver should be modular.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
