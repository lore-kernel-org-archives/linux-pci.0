Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:48885 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbaJCNFr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Oct 2014 09:05:47 -0400
Received: by mail-qa0-f48.google.com with SMTP id dc16so797870qab.21
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2014 06:05:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412313820.30859.2.camel@pasglop>
References: <1412210082.10667.2.camel@pasglop>
	<CADnq5_PhuFbRPgzAa_hEA1czTQjY9xdLFOWhL393DN4CYDnFng@mail.gmail.com>
	<1412313820.30859.2.camel@pasglop>
Date: Fri, 3 Oct 2014 09:05:46 -0400
Message-ID: <CADnq5_NGnVgmYb3uX2_7z71u4mVPxfx8Vyvp0=7Q=4oxW6S-MA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sound/radeon: Move 64-bit MSI quirk from arch to driver
From: Alex Deucher <alexdeucher@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 3, 2014 at 1:23 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-10-01 at 22:13 -0400, Alex Deucher wrote:
>
>> The attached updated patch only flags the affected asics.
>
> I need formal (email :-) permission to add your s-o-b (and From: while
> at it since you wrote most of it) for this patch. I'll then include
> it in my new series.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
