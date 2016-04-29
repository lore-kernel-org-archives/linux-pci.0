Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DFd4+NQcBHgaoXVNnixOQ4xYbi_LJsUcWzjMzTidGcgA@mail.gmail.com>
References: <1461167131-26025-1-git-send-email-andrew.smirnov@gmail.com>
	<1461167131-26025-3-git-send-email-andrew.smirnov@gmail.com>
	<CAOMZO5DFd4+NQcBHgaoXVNnixOQ4xYbi_LJsUcWzjMzTidGcgA@mail.gmail.com>
Date: Fri, 29 Apr 2016 14:52:50 +0200
Message-ID: <CAAMH-yt8fGJzhhHENFobWO86E3JZ-Xgc0tZso_HkdScoKdfVDA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx6qp: Specify imx6qp version of PCIe core
From: Gary Bisson <gary.bisson@boundarydevices.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

On Fri, Apr 29, 2016 at 3:48 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Apr 20, 2016 at 12:45 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> I.MX6Quad Plus has a slightly different version of PCIe core than
>> reqular i.MX6Quad.
>>
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Tested on a Nitrogen6QP_MAX with an Intel WiFi Link 5300 PCIe card.
Everything is working properly (Gen1 speed).
# lspci
00:00.0 Class 0604: 16c3:abcd
01:00.0 Class 0280: 8086:4235

Tested-by: Gary Bisson <gary.bisson@boundarydevices.com>

Thanks,
Gary
