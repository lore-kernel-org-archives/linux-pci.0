Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:61356 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbaAPE1Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2014 23:27:25 -0500
Received: by mail-ig0-f173.google.com with SMTP id c10so9950001igq.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2014 20:27:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPoiz9ySed6fAi8h0TFCG08EVKgGN6uDiAHyKLj9v3yLkMhGDQ@mail.gmail.com>
References: <CAE9FiQUGpBTijNGX6T=mLgoVa7wVegOMye8uGOqhKq93-1hyqQ@mail.gmail.com>
	<CAErSpo6cYZL5q7R1ccEZW9GAGcmHsYrAeGr3r_z-A4S1SunfqA@mail.gmail.com>
	<CAPoiz9xhm0J1DJ9EYyFFFez8dQ8-6iVG-T_0NpVxie6qVwQYVQ@mail.gmail.com>
	<52D5EEA1.3030603@huawei.com>
	<CAPoiz9ySed6fAi8h0TFCG08EVKgGN6uDiAHyKLj9v3yLkMhGDQ@mail.gmail.com>
Date: Wed, 15 Jan 2014 20:27:25 -0800
Message-ID: <CAE9FiQXry8hC=XNuN8sW2nXrhXY4PK7gdYuQGp3LJ-Wk8m61JA@mail.gmail.com>
Subject: Re: about mpss with pcie_bus_perf
From: Yinghai Lu <yinghai@kernel.org>
To: Jon Mason <jdmason@kudzu.us>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Myron Stowe <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jon Mason <jon.mason@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 15, 2014 at 10:18 AM, Jon Mason <jdmason@kudzu.us> wrote:
>
> If all inter-device communication is removed, then the only
> communication is CPU, Endpoint, and switches in-between.  Going from
> CPU to Endpoint, the MPS is actually going to be the Cache Line size.
> Since the Cache line size is 64B on x86 and most other architectures,
> there is no worry that the endpoint will get a PCIE packet larger than
> the MPS.  Also, using the MRRS to clamp down the endpoint to the MPS
> of the switches should ensure no reads larger than the MPS.  Going
> from Endpoint to CPU, we must ensure that all switches have a MPSS
> large enough for any device under them.  If not, then we must clamp
> down the Endpoint MPS.
>
> If all of this works, then we can ensure a much larger MPS for all of
> the PCI devices under a switch and not be bound by the smallest MPSS
> of an endpoint on the switch.

I'm confused by above statement.

On system have pcie hotplug support, BIOS set root port mps to 255,
and end port 255 during post.
then hot-remove and hot-add cards, new MPS will be 128 default.
when driver put load the end device, we will have lots of AER about TLP etc.

After change root port mps and end device mps to 128, we will not have
AER anymore.

So question is: root port's mpss 256 and end device's mpss 128 should
work well without any problem?

Also I have noticed BIOS set MPSS to 256 and MRRS 512.
so what is reason for current code for pcie_bus_perf to limit MRRS with MPSS?

Thanks

Yinghai
