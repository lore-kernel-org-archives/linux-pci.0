Return-Path: <SRS0=Qs2v=BQ=gmail.com=yhlu.kernel@kernel.org>
Return-Path: <SRS0=Qs2v=BQ=gmail.com=yhlu.kernel@kernel.org>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <59DC81DB.5070400@hisilicon.com>
References: <1506151482-113560-1-git-send-email-wangzhou1@hisilicon.com>
 <20171002041700.GA3834@localhost.localdomain> <20171002203830.GD5407@bhelgaas-glaptop.roam.corp.google.com>
 <59DC81DB.5070400@hisilicon.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 17 Oct 2017 00:00:23 -0700
Message-ID: <CAE9FiQVRdjgDpr4CLbb_xLkhXYfE0gcB5NQUCQ1dk2thzW0ByQ@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI: Fix prefetchable range broken in pci_bridge_check_ranges
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 10, 2017 at 1:16 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>
> So can we move pci_bridge_check_ranges to pci_setup_device? just like:

short answer is no.

As we have other user for __pci_bus_bridges, and before that the flags
could be cleared during resource allocation retries.

-Yinghai
