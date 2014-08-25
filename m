Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61963 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813AbaHYQbt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 12:31:49 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so9736880iec.5
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2014 09:31:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140825163518.GB5853@agordeev.usersys.redhat.com>
References: <cover.1394128952.git.agordeev@redhat.com>
	<2ba22558b5db90740d5833c35570c3e7cc1e359e.1394128952.git.agordeev@redhat.com>
	<CAPcyv4jW19zxApviDdbofbXB1OvvN2sCriL3Paszfk9o3T8x0w@mail.gmail.com>
	<20140306214356.GA16376@dhcp-26-207.brq.redhat.com>
	<CAPcyv4ivvxHvyT_5oybVvRJAUKABQQ1ZH4Eua-1KVDeri5kpkA@mail.gmail.com>
	<20140307074932.GC2670@dhcp-26-207.brq.redhat.com>
	<20140825163518.GB5853@agordeev.usersys.redhat.com>
Date: Mon, 25 Aug 2014 09:31:48 -0700
Message-ID: <CAPcyv4hhM+EFsgr66Tdr4CrsnvJdnDoS0S9LLnZCP65nJ59CBw@mail.gmail.com>
Subject: Re: [PATCH v2] ioat: Use pci_enable_msix_exact() instead of pci_enable_msix()
From: Dan Williams <dan.j.williams@intel.com>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Vinod Koul <vinod.koul@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 25, 2014 at 9:35 AM, Alexander Gordeev <agordeev@redhat.com> wrote:
> On Fri, Mar 07, 2014 at 08:49:32AM +0100, Alexander Gordeev wrote:
>> As result of deprecation of MSI-X/MSI enablement functions
>> pci_enable_msix() and pci_enable_msi_block() all drivers
>> using these two interfaces need to be updated to use the
>> new pci_enable_msi_range()  or pci_enable_msi_exact()
>> and pci_enable_msix_range() or pci_enable_msix_exact()
>> interfaces.
>
> Dan, Vinod,
>
> This patch hangs in -next for quite some time.
> Would you release it, please?

On its way... apologies for the delay.
