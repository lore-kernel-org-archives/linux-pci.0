Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:47593 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaANWyY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 17:54:24 -0500
Received: by mail-ig0-f172.google.com with SMTP id k19so7950618igc.5
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 14:54:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUGpBTijNGX6T=mLgoVa7wVegOMye8uGOqhKq93-1hyqQ@mail.gmail.com>
References: <CAE9FiQUGpBTijNGX6T=mLgoVa7wVegOMye8uGOqhKq93-1hyqQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 14 Jan 2014 15:54:01 -0700
Message-ID: <CAErSpo6cYZL5q7R1ccEZW9GAGcmHsYrAeGr3r_z-A4S1SunfqA@mail.gmail.com>
Subject: Re: about mpss with pcie_bus_perf
To: Yinghai Lu <yinghai@kernel.org>
Cc: Myron Stowe <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jon Mason <jon.mason@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jon, Yijing]

On Thu, Jan 9, 2014 at 5:46 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> looks like we have some problem with MPSS.
>
> +-02.2-[10-1f]----00.0-[11-13]--+-02.0-[12]--+-00.0
>                            |                      |                   \-00.1
>                            |                      \-03.0-[13]----00.0
>
> kernel boot with pce_bus_perf:
> 00:02.2: cap/ctl: 256/256
> 10:00.0: cap/ctl: 256/256
> 11:02.0: cap/ctl: 256/256
> 12:00.0: cap/ctl: 128/128
> 12:00.1: cap/ctl: 128/128
>
> 11:03.0: cap/ctl: 256/256
> 13:00.0: cap/ctl: 256/256
>
> Should we set MPSS to 128?

Please propose a patch and/or open a bug report.  I don't do enough
with MPS to make the problem and its solution immediately obvious to
me.

Bjorn
