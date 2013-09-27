Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:47016 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab3I0TKL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 15:10:11 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so5020950ieb.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2013 12:10:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001a01ceaace$013ec980$03bc5c80$%han@samsung.com>
References: <001a01ceaace$013ec980$03bc5c80$%han@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 27 Sep 2013 13:09:49 -0600
Message-ID: <CAErSpo5S873mmFZ=RiRsCbKnz89D5p62AzLkVb80VRp7mjKKFg@mail.gmail.com>
Subject: Re: [PATCH V3] PCI: exynos: add support for MSI
To: Jingoo Han <jg1.han@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	SRIKANTH TUMKUR SHIVANAND <ts.srikanth@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Sean Cross <xobs@kosagi.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 6, 2013 at 12:54 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> This patch adds support for Message Signaled Interrupt in the
> Exynos PCIe diver using Synopsys designware PCIe core IP.
>
> Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> Signed-off-by: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>

Applied to my pci/host-exynos branch for v3.13.  Thanks!

Bjorn
