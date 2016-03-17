Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
Date: Thu, 17 Mar 2016 09:58:26 +0530
Message-ID: <CAHM4w1ki8wJetiZqth9QQ8wtKcvVe-WTwpgE0EBudttfYUE3WA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup code to dw_pcie_setup_rc()
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 16, 2016 at 5:10 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
> dw_pcie_setup_rc(), as its name indicates, setups the RC. But current
> dw_pcie_host_init() also contains some necessary rc setup code.
>
> Another reason: the host may lost power during suspend to ram, the RC
> need to be re-setup after resume. The rc can't be correctly resumed
> without the rc setup code in dw_pcie_host_init().
>
> So this patch moves the code to dw_pcie_setup_rc() to address the above
> two issues. After this patch, each pcie designware driver users could
> call dw_pcie_setup_rc() to re-setup rc when resume back.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Seems reasonable. Thanks for the cleanup. :-)

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
