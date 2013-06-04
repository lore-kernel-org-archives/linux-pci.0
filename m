Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41517 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab3FDWIK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2013 18:08:10 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so1775915iec.30
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2013 15:08:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6GBw4C3mXRrd_f=6GFnEwhH7tHcAkp+ib=HMwVPpc0=w@mail.gmail.com>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
	<1369974092-11450-2-git-send-email-jiang.liu@huawei.com>
	<CAErSpo70u7oM07jcGA+E1MUHA4OWiJ1gQ8SuS7YCRuvGMxeaqA@mail.gmail.com>
	<CAErSpo5YbhPtB9OtjkUrMo8OKkjFXzOxeR3Jc4dQU8eC9D45XQ@mail.gmail.com>
	<CAE9FiQW=WM5v+VExCS0Od6gow7j4tTEOunECwqHP_hZduOETJw@mail.gmail.com>
	<CAErSpo6GBw4C3mXRrd_f=6GFnEwhH7tHcAkp+ib=HMwVPpc0=w@mail.gmail.com>
Date: Tue, 4 Jun 2013 15:08:09 -0700
Message-ID: <CAE9FiQWBxm1bz2=gR_rho642qJVoWrxCSkc1YW-banwPBWXirg@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI, ACPI: Don't glue ACPI dev with pci VFs
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <liuj97@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Xudong Hao <xudong.hao@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 4, 2013 at 3:00 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Jun 4, 2013 at 3:57 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Well, I read that in the changelog, but that doesn't tell me what bad
> things happen as a result.  Can you elaborate a little bit?  Does it
> mean PM doesn't work, hotplug doesn't work, drivers can't bind to the
> VFs correctly, the magic smoke comes out of the PF, or what?

no, I did not notice anything unusual except the binding message.
as my platform have those PM disabled.
