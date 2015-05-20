Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1430382149-1645-3-git-send-email-jszhang@marvell.com>
References: <1430382149-1645-1-git-send-email-jszhang@marvell.com>
	<1430382149-1645-3-git-send-email-jszhang@marvell.com>
Date: Wed, 20 May 2015 21:12:28 +0530
Message-ID: <CAHM4w1=6mgp+gU9wUBNZg-Mpz0vOgCw1no568qLoB1X95u2YGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: designware: use iATU0 for cfg and IO, iATU1
 for MEM
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Minghuan.Lian@freescale.com, fabrice.gasnier@st.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 30, 2015 at 1:52 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
> Most transactions' type are cfg0 and MEM, so the Current iATU usage is not
> balanced, iATU0 is hot while iATU1 is rarely used. This patch refactors
> the iATU usage: iATU0 for cfg and IO, iATU1 for MEM. This allocation
> ideas comes from Minghuan Lian <Minghuan.Lian@freescale.com>:
>
>  http://www.spinics.net/lists/linux-pci/msg40440.html
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Nice optimization of resources. Thanks :)

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
