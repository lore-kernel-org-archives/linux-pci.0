Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:49149 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaKJGg5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 01:36:57 -0500
Received: by mail-oi0-f44.google.com with SMTP id h136so4990842oig.3
        for <linux-pci@vger.kernel.org>; Sun, 09 Nov 2014 22:36:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001401cff95e$ec061f60$c4125e20$%han@samsung.com>
References: <001401cff95e$ec061f60$c4125e20$%han@samsung.com>
Date: Mon, 10 Nov 2014 12:06:57 +0530
Message-ID: <CAKohpomBxJuxqapc59BRTarL0wAtcTnOg9f5zR34v+A-bRMdgw@mail.gmail.com>
Subject: Re: [PATCH] PCI: spear: Add exynos spear13xx before add_pcie_port/pcie_init
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6 November 2014 06:43, Jingoo Han <jg1.han@samsung.com> wrote:
> The add_pcie_port/pcie_init functions are SPEAr13xx-specific.
> Add exynos prefix to avoid collision in global name space.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pci/host/pcie-spear13xx.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

The diff looks fine but log and subject aren't correct.. SPEAr13xx is
not an Exynos SoC, but is from ST Microelectronics.
