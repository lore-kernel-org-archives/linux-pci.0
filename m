Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BYXx9VmhGrTv44O-njGQsz=GSRp9fA_VbkWapkqY+p=g@mail.gmail.com>
References: <20170510175752.6519-1-l.stach@pengutronix.de>
 <CAOMZO5BYXx9VmhGrTv44O-njGQsz=GSRp9fA_VbkWapkqY+p=g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 May 2017 16:04:47 -0300
Message-ID: <CAOMZO5AnDRbuvp3G-ruM+1fo+9_JPCApRDQ9=kuDL0NZXgHmqA@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: fix downstream bus scanning
To: Lucas Stach <l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Tim Harvey <tharvey@gateworks.com>, patchwork-lst@pengutronix.de,
 Peter Senna Tschudin <peter.senna@collabora.com>,
 Sascha Hauer <kernel@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 10, 2017 at 3:35 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Lucas,
>
> On Wed, May 10, 2017 at 2:57 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
>> The change in Linux 4.12 to make PCI configuartion requests non-posted
>> means that we are now getting a synchronous abort when the CFG space
>> read to probe for downstream devices times out.
>>
>> Synchronous aborts need to be handled differently from the async aborts
>> we were getting before, in particular the PC needs to be advanced when
>> resolving the abort. This is mostly a copy of what other PCI drivers do
>> on ARM to handle those aborts.
>>
>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> ---
>> This is a fix that needs to go in for 4.12, but I would hope to get
>> some thorough testing before.
>
> This fixes the kernel crash on my mx6q board with a PCI switch, thanks!
>
> PCI Wifi card is also correctly detected.

Forgot to add:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
